import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class LandingScreen extends StatelessWidget {
  const LandingScreen({super.key});

  static const id = 'landing_screen';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Text(
                'CryptoFlare Wallet',
                style: TextStyle(
                  fontSize: 20.0,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 30.0),
              SvgPicture.asset(
                'assets/flutter_logo.svg',
                width: 80.0,
              ),
              const SizedBox(height: 40.0),
              SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  onPressed: () async {},
                  style: ButtonStyle(
                    shape: MaterialStateProperty.all(
                      const RoundedRectangleBorder(
                        borderRadius: BorderRadius.all(
                          Radius.circular(5.0),
                        ),
                      ),
                    ),
                    backgroundColor:
                        MaterialStateProperty.all(Colors.blueAccent),
                  ),
                  child: const Text(
                    'Create Wallet',
                    style: TextStyle(color: Colors.white),
                  ),
                ),
              ),
              const SizedBox(height: 5.0),
              SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  onPressed: () async {},
                  style: ButtonStyle(
                    shape: MaterialStateProperty.all(
                      const RoundedRectangleBorder(
                        borderRadius: BorderRadius.all(
                          Radius.circular(5.0),
                        ),
                      ),
                    ),
                    backgroundColor: MaterialStateProperty.all(Colors.white),
                  ),
                  child: const Text(
                    'Import From Seed',
                    style: TextStyle(color: Colors.black),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
