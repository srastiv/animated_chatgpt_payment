import 'package:flutter/material.dart';

class AnimatedCircle extends StatefulWidget {
  const AnimatedCircle({super.key});

  @override
  State<AnimatedCircle> createState() => _AnimatedCircleState();
}

class _AnimatedCircleState extends State<AnimatedCircle>
    with TickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _rotationAnimation;
  late Animation<double> _radiusAnimation;

  @override
  void initState() {
    // animation controller
    _controller =
        AnimationController(vsync: this, duration: const Duration(seconds: 2))
          ..forward();

    // rotation animation
    _rotationAnimation = Tween(begin: 0.0, end: 1.0)
        .animate(CurvedAnimation(parent: _controller, curve: Curves.easeInOut));

    // radius animation
    _radiusAnimation = Tween(begin: 450.0, end: 1.0)
        .animate(CurvedAnimation(parent: _controller, curve: Curves.easeInOut));

    _controller.addListener(() {
      setState(() {});
    });

    // make animation go back and forth
    _controller.addStatusListener((status) {
      if (status == AnimationStatus.completed) {
        _controller.reverse();
      } else if (status == AnimationStatus.dismissed) {
        _controller.forward();
      }
    });

    super.initState();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Stack(alignment: Alignment.center, children: [
      animationWidget(color: Colors.teal[800]!, angle: 0, height: 225),
      animationWidget(color: Colors.teal[700]!, angle: 0.2, height: 200),
      animationWidget(color: Colors.teal[600]!, angle: 0.4, height: 175),
      animationWidget(color: Colors.teal[500]!, angle: 0.6, height: 150),
      animationWidget(color: Colors.teal[400]!, angle: 0.8, height: 125),
      animationWidget(color: Colors.teal[300]!, angle: 1.0, height: 100),
      animationWidget(color: Colors.teal[200]!, angle: 1.2, height: 75),
      animationWidget(color: Colors.teal[100]!, angle: 1.4, height: 50),
      animationWidget(color: Colors.teal[50]!, angle: 1.6, height: 25),
    ]);
  }

  Transform animationWidget({
    required Color color,
    required double angle,
    required double height,
  }) {
    return Transform.rotate(
        angle: _rotationAnimation.value + angle,
        child: Container(
            width: height,
            height: height,
            decoration: BoxDecoration(
                color: color,
                borderRadius: BorderRadius.circular(_radiusAnimation.value),
                boxShadow: [
                  BoxShadow(
                      color: color.withOpacity(0.8),
                      offset: const Offset(-6.0, -6.0)),
                  BoxShadow(
                      color: Colors.black.withOpacity(0.1),
                      offset: const Offset(6.0, 6.0))
                ])));
  }
}
