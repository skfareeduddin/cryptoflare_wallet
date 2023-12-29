import 'package:flutter/material.dart';

void main() {
  runApp(const CryptoFlare());
}

class CryptoFlare extends StatelessWidget {
  const CryptoFlare({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        body: SafeArea(
          child: Center(
            child: ElevatedButton(
              onPressed: () {},
              child: const Text('Generate Wallet'),
            ),
          ),
        ),
      ),
    );
  }
}
