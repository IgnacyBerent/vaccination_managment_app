import 'package:flutter/material.dart';
import 'package:vaccination_managment_app/models/vaccine.dart';
import 'package:vaccination_managment_app/views/vaccines/vaccine_item.dart';
import 'package:vaccination_managment_app/api/database_api.dart';

class VaccinesScreen extends StatefulWidget {
  const VaccinesScreen({Key? key}) : super(key: key);

  @override
  State<VaccinesScreen> createState() => _VaccinesScreenState();
}

class _VaccinesScreenState extends State<VaccinesScreen> {
  final DatabaseApi _db = DatabaseApi();
  List<Vaccine> vaccines = [];

  @override
  void initState() {
    super.initState();
    _db.fetchVaccines().then((value) {
      setState(() {
        vaccines = value;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: vaccines.length,
      itemBuilder: (context, index) {
        return VaccineItem(
          vaccines[index],
        );
      },
    );
  }
}
