import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:razorpay_flutter/razorpay_flutter.dart';

class PaymentPage extends StatefulWidget {
  const PaymentPage({super.key});

  @override
  State<PaymentPage> createState() => _PaymentPageState();
}

class _PaymentPageState extends State<PaymentPage> {
  var _razorPay = Razorpay();

  @override
  void initState() {
    _razorPay.on(Razorpay.EVENT_PAYMENT_SUCCESS, _handlePaymentSuccess);
    _razorPay.on(Razorpay.EVENT_PAYMENT_ERROR, _handlePaymentError);
    _razorPay.on(Razorpay.EVENT_EXTERNAL_WALLET, _handleExternalWallet);
    super.initState();
  }

  void _handlePaymentSuccess(PaymentSuccessResponse response) {
    // Do something when payment succeeds
    if (kDebugMode) {
      print('SUCCESS');
    }
  }

  void _handlePaymentError(PaymentFailureResponse response) {
    // Do something when payment fails
    if (kDebugMode) {
      print('ERROR');
    }
  }

  void _handleExternalWallet(ExternalWalletResponse response) {
    // Do something when an external wallet is selected
  }
  final TextEditingController _amountController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Razorpay Payment')),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            TextFormField(
              keyboardType: TextInputType.number,
              controller: _amountController,
              decoration: InputDecoration(
                labelText: 'Enter amount in Rupees',
                labelStyle: TextStyle(
                  color: Colors.grey[600],
                  fontSize: 16.0,
                ),
                enabledBorder: OutlineInputBorder(
                  borderSide: const BorderSide(color: Colors.grey),
                  borderRadius: BorderRadius.circular(10.0),
                ),
                focusedBorder: OutlineInputBorder(
                  borderSide: const BorderSide(color: Colors.blue),
                  borderRadius: BorderRadius.circular(10.0),
                ),
                filled: true,
                fillColor: Colors.grey[200],
              ),
              style: const TextStyle(fontSize: 16.0),
            ),
            ElevatedButton(
              onPressed: () {
                var options = {
                  'key': 'rzp_test_BjQEDusVYYTlcP',
                  'amount': convertRupeesToPaise(_amountController.text)
                      .toString(), //in the smallest currency sub-unit, eg., paise
                  'name': 'Srasti',
                  'description': 'Learning razorpay',
                  'timeout': 60, // in seconds
                  'prefill': {
                    'contact': '8318992238',
                    'email': 'srashtiv3@gmail.com'
                  }
                };
                _razorPay.open(options);
              },
              child: const Text('Pay Amount'),
            ),
          ],
        ),
      ),
    );
  }

  int convertRupeesToPaise(String text) {
    return int.parse(text) * 100;
  }

  @override
  void dispose() {
    _razorPay.clear();
    super.dispose();
  }
}
