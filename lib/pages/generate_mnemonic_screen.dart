import 'package:cryptoflare_wallet/pages/verify_mnemonic_screen.dart';
import 'package:cryptoflare_wallet/provider/wallet_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';

class GenerateMnemonicScreen extends StatelessWidget {
  const GenerateMnemonicScreen({super.key});

  static const id = "generate_mnemonic_screen";

  @override
  Widget build(BuildContext context) {
    final walletProvider = Provider.of<WalletProvider>(context);
    final mnemonicPhrase = walletProvider.generateMnemonic();
    final mnemonicWords = mnemonicPhrase.split(' ');

    void copyToClipboard() {
      Clipboard.setData(ClipboardData(text: mnemonicPhrase));

      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Copied to Clipboard!'),
        ),
      );

      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => VerifyMnemonicScreen(mnemonic: mnemonicPhrase),
        ),
      );
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
          'Generate Mnemonic',
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
            children: [
              const Text(
                'Please store the below mnemonic phrase safely:',
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: List.generate(
                  mnemonicWords.length,
                  (index) => Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Text('${index + 1}. ${mnemonicWords[index]}'),
                  ),
                ),
              ),
              const SizedBox(height: 10.0),
              ElevatedButton.icon(
                onPressed: () {
                  copyToClipboard();
                },
                icon: const Icon(
                  Icons.copy,
                  color: Colors.white,
                ),
                label: const Text(
                  'Copy to Clipboard',
                  style: TextStyle(color: Colors.white),
                ),
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
              ),
            ],
          ),
        ),
      ),
    );
  }
}
