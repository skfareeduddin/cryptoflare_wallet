import 'package:cryptoflare_wallet/pages/landing_screen.dart';
import 'package:cryptoflare_wallet/provider/wallet_provider.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:web3dart/credentials.dart';

class WalletPage extends StatefulWidget {
  const WalletPage({super.key});

  static const id = 'wallet_screen';

  @override
  State<WalletPage> createState() => _WalletPageState();
}

class _WalletPageState extends State<WalletPage> {
  String walletAddress = '';
  String balance = '';
  String pvKey = '';

  @override
  void initState() {
    super.initState();
    loadWalletData();
  }

  Future<void> loadWalletData() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? privateKey = prefs.getString('privateKey');

    if (privateKey != null) {
      final walletProvider = WalletProvider();
      await walletProvider.loadPrivateKey();
      EthereumAddress address = await walletProvider.getPublicKey(privateKey);

      setState(() {
        walletAddress = address.hex;
        pvKey = privateKey;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
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
          'Wallet',
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
                'Wallet Address',
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20.0),
              ),
              const SizedBox(height: 10.0),
              Text(
                walletAddress,
                style: const TextStyle(fontSize: 18.0, color: Colors.black54),
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 30.0),
              const Text(
                'Balance',
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20.0),
              ),
              const SizedBox(height: 10.0),
              Text(
                balance,
                style: const TextStyle(fontSize: 20.0),
              ),
              const SizedBox(height: 60.0),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Column(
                    children: [
                      IconButton.filled(
                        style: ButtonStyle(
                          backgroundColor:
                              MaterialStateProperty.all(Colors.blueAccent),
                          elevation: MaterialStateProperty.all(3.0),
                          shadowColor: MaterialStateProperty.all(Colors.grey),
                        ),
                        onPressed: () {},
                        icon: const Icon(
                          Icons.send,
                          color: Colors.white,
                          size: 20.0,
                        ),
                      ),
                      const Text(
                        'Send',
                        style: TextStyle(fontSize: 12.0),
                      ),
                    ],
                  ),
                  const SizedBox(width: 80.0),
                  Column(
                    children: [
                      IconButton.filled(
                        style: ButtonStyle(
                          backgroundColor:
                              MaterialStateProperty.all(Colors.blueAccent),
                          elevation: MaterialStateProperty.all(3.0),
                          shadowColor: MaterialStateProperty.all(Colors.grey),
                        ),
                        onPressed: () {},
                        icon: const Icon(
                          Icons.refresh_rounded,
                          color: Colors.white,
                          size: 20.0,
                        ),
                      ),
                      const Text(
                        'Refresh',
                        style: TextStyle(fontSize: 12.0),
                      ),
                    ],
                  ),
                ],
              ),
              const SizedBox(height: 30.0),
              Expanded(
                child: DefaultTabController(
                  length: 3,
                  child: Column(
                    children: [
                      const TabBar(
                        labelColor: Colors.blueAccent,
                        tabs: [
                          Tab(
                            text: 'Assets',
                          ),
                          Tab(
                            text: 'NFTs',
                          ),
                          Tab(
                            text: 'Options',
                          ),
                        ],
                      ),
                      Expanded(
                        child: TabBarView(
                          children: [
                            const Column(
                              children: [
                                Card(
                                  margin: EdgeInsets.all(16.0),
                                  child: Padding(
                                    padding: EdgeInsets.all(16.0),
                                    child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        Text(
                                          'Sepolia ETH',
                                          style: TextStyle(
                                            fontSize: 24.0,
                                            fontWeight: FontWeight.bold,
                                          ),
                                        ),
                                        Text(
                                          'Balance',
                                          style: TextStyle(
                                            fontSize: 24.0,
                                            fontWeight: FontWeight.bold,
                                          ),
                                        )
                                      ],
                                    ),
                                  ),
                                )
                              ],
                            ),
                            SingleChildScrollView(),
                            Center(
                              child: ListTile(
                                leading: const Icon(Icons.logout),
                                title: const Text('Logout'),
                                onTap: () async {
                                  SharedPreferences prefs =
                                      await SharedPreferences.getInstance();
                                  await prefs.remove('privateKey');
                                  // ignore: use_build_context_synchronously
                                  Navigator.pushAndRemoveUntil(
                                    context,
                                    MaterialPageRoute(
                                      builder: (context) =>
                                          const LandingScreen(),
                                    ),
                                    (route) => false,
                                  );
                                },
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
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
