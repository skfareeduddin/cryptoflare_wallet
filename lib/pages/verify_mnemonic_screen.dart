import 'package:cryptoflare_wallet/pages/wallet_screen.dart';
import 'package:cryptoflare_wallet/provider/wallet_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class VerifyMnemonicScreen extends StatefulWidget {
  const VerifyMnemonicScreen({super.key, required this.mnemonic});

  final String mnemonic;

  static const id = 'verify_mnemonic_screen';

  @override
  State<VerifyMnemonicScreen> createState() => _VerifyMnemonicScreenState();
}

class _VerifyMnemonicScreenState extends State<VerifyMnemonicScreen> {
  bool isVerified = false;
  String verificationText = '';

  void verifyMnemonic() {
    final walletProvider = Provider.of<WalletProvider>(context, listen: false);

    if (verificationText.trim() == widget.mnemonic.trim()) {
      walletProvider.getPrivateKey(widget.mnemonic).then((privateKey) {
        setState(() {
          isVerified = true;
          print('Mnemonic Verified');
        });
      });
    }
    print(verificationText);
    print(widget.mnemonic);
  }

  @override
  Widget build(BuildContext context) {
    void navigateToWallet() {
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => const WalletPage(),
        ),
      );
      print('Go to wallet');
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
          'Verify Mnemonic',
          style: TextStyle(color: Colors.white),
        ),
        centerTitle: true,
        backgroundColor: Colors.blueAccent,
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
                  onPressed: () {
                    verifyMnemonic();
                  },
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
                    'Verify',
                    style: TextStyle(color: Colors.white),
                  ),
                ),
              ),
              const SizedBox(height: 10.0),
              SizedBox(
                width: double.infinity,
                height: 30.0,
                child: ElevatedButton(
                  onPressed: () {
                    isVerified ? navigateToWallet() : null;
                  },
                  style: ElevatedButton.styleFrom(
                    foregroundColor: Colors.black,
                    backgroundColor: Colors.white,
                  ),
                  child: const Text('Next'),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
