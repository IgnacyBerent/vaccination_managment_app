import 'dart:developer';

import 'package:http/http.dart' as http;
import 'dart:convert';

import 'package:vaccination_managment_app/api/jwt_token.dart';

class Authenticate {
  final String baseUrl =
      'https://vaccinatemanagmentbackend-production.up.railway.app/user';
  final JwtToken jwt = JwtToken();

  Future<void> login(String username, String password) async {
    final response = await http.post(
      Uri.parse('$baseUrl/login/'),
      body: {'username': username, 'password': password},
    );

    if (response.statusCode == 200) {
      final responseBody = json.decode(response.body);
      await jwt.saveTokens(responseBody);
    } else {
      if (response.statusCode == 401) {
        throw Exception('Invalid credentials');
      } else if (response.statusCode == 400) {
        throw Exception('Bad request');
      } else {
        throw Exception('Failed to login');
      }
    }
  }

  Future<void> register(String username, String email, String password) async {
    final response = await http.post(
      Uri.parse('$baseUrl/register/'),
      body: {
        'username': username,
        'email': email,
        'password': password,
        'password2': password
      },
    );

    if (response.statusCode == 201) {
      await login(username, password);
    } else {
      if (response.statusCode == 400) {
        throw Exception('Bad request');
      } else {
        throw Exception('Failed to register');
      }
    }
  }

  Future<void> logout() async {
    await jwt.deleteToken();
  }

  Future<bool> refreshToken() async {
    String? rt = await jwt.getRefreshToken();
    if (rt == null) {
      log('No refresh token found');
      return false;
    }

    final response = await http.post(
      Uri.parse('$baseUrl/api/token/refresh/'),
      body: {'refresh': rt},
    );

    if (response.statusCode == 200) {
      final responseBody = json.decode(response.body);
      await jwt.updateToken(responseBody['access']);
      return true;
    } else {
      if (response.statusCode == 400) {
        log('Bad request');
        return false;
      } else {
        log('Failed to refresh token');
        return false;
      }
    }
  }

  Future<void> sendPushNotificationToken(String token) async {
    // TODO: implement sendPushNotificationToken
    throw Exception('Not implemented');
  }
}
