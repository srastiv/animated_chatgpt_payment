import 'package:flutter/material.dart';
import 'dart:math';

class BubbleAnimation extends StatefulWidget {
  const BubbleAnimation({super.key});
  @override
  State<BubbleAnimation> createState() => _BubbleAnimationState();
}

class _BubbleAnimationState extends State<BubbleAnimation>
    with TickerProviderStateMixin {
  late AnimationController _animationController;
  List<Bubble> bubbles = [];

  @override
  void initState() {
    super.initState();
    _animationController = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 2),
    )
      ..addListener(() {
        setState(() {
          _updateBubblesPosition();
        });
      })
      ..repeat();

    _generateBubbles();
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  void _generateBubbles() {
    for (int i = 0; i < 20; i++) {
      bubbles.add(Bubble());
    }
  }

  void _updateBubblesPosition() {
    const double speed = 10.0; // Adjust the speed of the bubbles

    for (var bubble in bubbles) {
      bubble.top = bubble.top! - speed * _animationController.value;

      if (bubble.top! < -(bubble.size)!) {
        bubble.top = 600.0; // Reset the bubble to the bottom of the screen
        bubble.left =
            Random().nextDouble() * 300; // Randomize the horizontal position
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          AnimatedBuilder(
            animation: _animationController,
            builder: (context, child) {
              return Stack(
                children: bubbles.map((bubble) {
                  return Positioned(
                    top: bubble.top,
                    left: bubble.left,
                    child: Transform.scale(
                      scale: bubble.scale,
                      child: Opacity(
                        opacity: bubble.opacity!,
                        child: Container(
                          width: bubble.size,
                          height: bubble.size,
                          decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            gradient: LinearGradient(
                              begin: Alignment.topLeft,
                              end: Alignment.bottomRight,
                              colors: [
                                Colors.blue.shade200,
                                Colors.purple.shade100,
                                Colors.teal.shade100,
                                Colors.blue,
                              ],
                            ),
                          ),
                        ),
                      ),
                    ),
                  );
                }).toList(),
              );
            },
          ),
        ],
      ),
    );
  }
}

class Bubble {
  double? top;
  double? left;
  double? scale;
  double? opacity;
  double? size;

  Bubble({this.left, this.opacity, this.scale, this.size, this.top}) {
    top = Random().nextDouble() * 500;
    left = Random().nextDouble() * 300;
    scale = Random().nextDouble() * 2 + 0.5;
    opacity = Random().nextDouble();
    size = Random().nextDouble() * 50 + 10;
  }
}
