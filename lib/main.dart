import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'wallet_provider.dart';

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
    final walletProvider = Provider.of<WalletProvider>(context);

    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        appBar: AppBar(
          title: const Text(
            'CryptoFlare Wallet',
            style: TextStyle(color: Colors.white),
          ),
          centerTitle: true,
          backgroundColor: Colors.blueAccent,
        ),
        body: SafeArea(
          child: Center(
            child: ElevatedButton(
              onPressed: () async {
                final mnemonic = walletProvider.generateMnemonic();
                final privateKey = await walletProvider.getPrivateKey(mnemonic);
                final publicKey = await walletProvider.getPublicKey(privateKey);

                print('Mnemonic: $mnemonic');
                print('Private Key: $privateKey');
                print('Public Key: $publicKey');
              },
              style: ButtonStyle(
                shape: MaterialStateProperty.all(
                  const RoundedRectangleBorder(
                    borderRadius: BorderRadius.all(
                      Radius.circular(5.0),
                    ),
                  ),
                ),
                backgroundColor: MaterialStateProperty.all(Colors.blueAccent),
              ),
              child: const Text(
                'Generate Wallet',
                style: TextStyle(color: Colors.white),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
