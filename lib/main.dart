import 'package:cryptoflare_wallet/pages/generate_mnemonic_screen.dart';
import 'package:cryptoflare_wallet/pages/landing_screen.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'provider/wallet_provider.dart';

void main() {
  runApp(
    ChangeNotifierProvider(
      create: (context) => WalletProvider(),
      child: const CryptoFlare(),
    ),
  );
}

class CryptoFlare extends StatelessWidget {
  const CryptoFlare({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      initialRoute: LandingScreen.id,
      routes: {
        LandingScreen.id: (context) => const LandingScreen(),
        GenerateMnemonicScreen.id: (context) => const GenerateMnemonicScreen(),
      },
    );
  }
}
