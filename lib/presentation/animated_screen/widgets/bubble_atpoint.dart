import 'dart:async';
import 'dart:math';

import 'package:flutter/material.dart';

class BubbleAnimationAtPoint extends StatefulWidget {
  const BubbleAnimationAtPoint({super.key});
  @override
  State<BubbleAnimationAtPoint> createState() => _BubbleAnimationAtPointState();
}

class _BubbleAnimationAtPointState extends State<BubbleAnimationAtPoint>
    with SingleTickerProviderStateMixin {
  late AnimationController _animationController;
  List<Bubble> bubbles = [];
  Offset? tapPosition;

  @override
  void initState() {
    super.initState();
    _animationController = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 4),
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
    const double initialSize = 5.0; // Initial size of the bubbles
    const double targetSize = 50.0; // Target size of the bubbles

    for (var bubble in bubbles) {
      double horizontalDirection = 1.0;
      if (tapPosition != null) {
        if (tapPosition!.dx < MediaQuery.of(context).size.width / 2) {
          // Tapped on the left side of the screen
          horizontalDirection = 1.0;
        } else {
          // Tapped on the right side of the screen
          horizontalDirection = -1.0;
        }
      }
      bubble.top = bubble.top! - speed * _animationController.value;
      bubble.left = bubble.left! +
          (speed * horizontalDirection * _animationController.value);

      // Calculate the current size based on the animation progress
      double currentSize = initialSize +
          ((targetSize - initialSize) * _animationController.value);

      if (bubble.top! < -(bubble.size)!) {
        bubble.top = MediaQuery.of(context)
            .size
            .height; // Reset the bubble to the bottom of the screen
        bubble.left = Random().nextDouble() *
            MediaQuery.of(context)
                .size
                .width; // Randomize the horizontal position
      }
    }
  }

  void _startAnimationAtPosition(Offset position) {
    setState(() {
      tapPosition = position; // Adjust for the status bar height
      bubbles.clear(); // Clear existing bubbles
      _generateBubbles(); // Generate new bubbles
      _animationController
        ..reset()
        ..forward();
      _stopAnimationAfterDelay(const Duration(seconds: 5));
    });
  }

  void _stopAnimationAfterDelay(Duration delay) {
    Timer(delay, () {
      setState(() {
        tapPosition = null;
        _animationController.stop();
        bubbles.clear(); // Remove the bubbles from the list
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 50, 50, 50),
      body: GestureDetector(
        behavior: HitTestBehavior.translucent,
        onTapDown: (TapDownDetails details) {
          _startAnimationAtPosition(details.localPosition);
        },
        child: Stack(
          children: [
            AnimatedBuilder(
              animation: _animationController,
              builder: (context, child) {
                return Stack(
                  children: bubbles.map((bubble) {
                    return Positioned(
                      top: tapPosition != null
                          ? tapPosition!.dy + bubble.top!
                          : bubble.top,
                      left: tapPosition != null
                          ? tapPosition!.dx + bubble.left!
                          : bubble.left,
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
                                colors: [
                                  Colors.blue.shade200,
                                  Colors.purple.shade100,
                                  Colors.amber.shade100,
                                  Colors.teal.shade100,
                                  Colors.blue,
                                ],
                                begin: Alignment.topLeft,
                                end: Alignment.bottomRight,
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
    size = Random().nextDouble() * 30 + 10; // Adjust the size range
  }
}
