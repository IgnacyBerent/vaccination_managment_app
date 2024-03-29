import 'package:flutter/material.dart';

class AnimatedBackgroundContainer extends StatefulWidget {
  final Widget child;

  const AnimatedBackgroundContainer({Key? key, required this.child})
      : super(key: key);

  @override
  AnimatedBackgroundContainerState createState() =>
      AnimatedBackgroundContainerState();
}

class AnimatedBackgroundContainerState
    extends State<AnimatedBackgroundContainer>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<Color?> _colorTween1;
  late Animation<Color?> _colorTween2;

  @override
  void initState() {
    super.initState();
    _controller =
        AnimationController(duration: const Duration(seconds: 7), vsync: this);
    _colorTween1 = ColorTween(
      begin: const Color.fromARGB(255, 7, 219, 131),
      end: const Color.fromARGB(255, 158, 252, 197),
    ).animate(
        CurvedAnimation(parent: _controller, curve: Curves.easeInOutSine));
    _colorTween2 = ColorTween(
      begin: const Color.fromARGB(255, 158, 252, 197),
      end: const Color.fromARGB(255, 38, 255, 103),
    ).animate(CurvedAnimation(parent: _controller, curve: Curves.easeInOutSine))
      ..addListener(() {
        setState(() {});
      })
      ..addStatusListener((status) {
        if (status == AnimationStatus.completed) {
          _controller.reverse();
        } else if (status == AnimationStatus.dismissed) {
          _controller.forward();
        }
      });

    WidgetsBinding.instance.addPostFrameCallback((_) {
      _controller.forward();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      height: double.infinity,
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topRight,
          end: Alignment.bottomLeft,
          colors: [
            _colorTween1.value ?? Colors.transparent,
            _colorTween2.value ?? Colors.transparent
          ],
        ),
      ),
      child: widget.child,
    );
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }
}
