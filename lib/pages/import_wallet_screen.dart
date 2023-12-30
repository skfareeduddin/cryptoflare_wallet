import 'package:cryptoflare_wallet/pages/wallet_screen.dart';
import 'package:cryptoflare_wallet/provider/wallet_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class ImportWalletScreen extends StatefulWidget {
  const ImportWalletScreen({super.key});

  static const id = 'import_from_seed';

  @override
  State<ImportWalletScreen> createState() => _ImportWalletScreenState();
}

class _ImportWalletScreenState extends State<ImportWalletScreen> {
  bool isVerified = false;
  String verificationText = '';

  void navigateToWallet() {
    Navigator.pushNamed(context, WalletPage.id);
  }

  @override
  Widget build(BuildContext context) {
    void verifyMnemonic() async {
      final walletProvider =
          Provider.of<WalletProvider>(context, listen: false);
      final privateKey = await walletProvider.getPrivateKey(verificationText);

      navigateToWallet();
    }

    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          onPressed: () {
            Navigator.pop(context);
          },
          icon: const Icon(Icons.arrow_back_ios),
          color: Colors.white,
        ),
        title: const Text(
          'Import Wallet',
          style: TextStyle(color: Colors.white),
        ),
        centerTitle: true,
        backgroundColor: Colors.blueAccent,
        elevation: 5.0,
        shadowColor: Colors.grey,
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                'Please verify your mnemonic phrase:',
                style: TextStyle(
                  color: Colors.black54,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 10.0),
              TextField(
                onChanged: (value) {
                  setState(() {
                    verificationText = value;
                  });
                },
                decoration: const InputDecoration(
                  labelText: 'Enter Mnemonic Phrase',
                  labelStyle: TextStyle(
                    color: Colors.grey,
                    fontSize: 15.0,
                  ),
                ),
              ),
              const SizedBox(height: 10.0),
              SizedBox(
                width: double.infinity,
                height: 30.0,
                child: ElevatedButton(
                  onPressed: verifyMnemonic,
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
                    'Import',
                    style: TextStyle(color: Colors.white),
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
