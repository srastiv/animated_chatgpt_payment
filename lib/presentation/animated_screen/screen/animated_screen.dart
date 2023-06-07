import 'package:flutter/material.dart';
import 'package:razorpay_payment_gateway/presentation/animated_screen/widgets/bubbles_overlay_widget.dart';
class AnimatedScreen extends StatelessWidget {
  const AnimatedScreen({super.key});
  @override
  Widget build(BuildContext context) {
    return const Scaffold(
        backgroundColor: Colors.teal,
        body: Padding(padding: EdgeInsets.only(top: 0), child: BubbleOverlay()
            // Column(
            //     mainAxisAlignment: MainAxisAlignment.start,
            //     crossAxisAlignment: CrossAxisAlignment.center,
            //     children: [
            //       const Center(child: AnimatedCircle()),
            //       const SizedBox(height: 20),
            //       TextButton(
            //         onPressed: () {},
            //         style: TextButton.styleFrom(foregroundColor: Colors.black),
            //         child: const Text('Enter'),
            //       ),
            //     ]),
            ));
  }
}