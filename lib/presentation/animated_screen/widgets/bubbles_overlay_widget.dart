import 'package:flutter/material.dart';

class BubbleOverlay extends StatefulWidget {
  const BubbleOverlay({super.key});
  @override
  State<BubbleOverlay> createState() => _BubbleOverlayState();
}

class _BubbleOverlayState extends State<BubbleOverlay> {
  List<Offset> bubblePositions = [];

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTapDown: (TapDownDetails details) {
        setState(() {
          bubblePositions.add(details.globalPosition);
        });
      },
      child: Scaffold(
        body: Stack(
          children: [
            // Your main UI elements here
            Positioned.fill(
              child: CustomPaint(painter: BubblesPainter(bubblePositions)),
            ),
          ],
        ),
      ),
    );
  }
}

class BubblesPainter extends CustomPainter {
  final List<Offset> bubblePositions;

  BubblesPainter(this.bubblePositions);

  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = const Color.fromARGB(255, 183, 123, 229).withOpacity(0.5)
      ..style = PaintingStyle.fill;

    for (final position in bubblePositions) {
      canvas.drawCircle(position, 20, paint);
    }
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) => true;
}
