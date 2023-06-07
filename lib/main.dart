import 'package:flutter/material.dart';
import 'package:razorpay_payment_gateway/presentation/animated_screen/widgets/bubble_atpoint.dart';
import 'presentation/animated_screen/widgets/bubbles_overlay_widget.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.teal,
      ),
      home: const BubbleAnimationAtPoint(),
    );
  }
}
