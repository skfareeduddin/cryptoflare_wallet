import 'dart:convert';

import 'package:cryptoflare_wallet/components/nft_balances.dart';
import 'package:cryptoflare_wallet/components/send_tokens.dart';
import 'package:cryptoflare_wallet/pages/landing_screen.dart';
import 'package:cryptoflare_wallet/provider/wallet_provider.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:web3dart/credentials.dart';
import 'package:cryptoflare_wallet/utils/get_balance.dart';
import 'package:web3dart/web3dart.dart';

class WalletPage extends StatefulWidget {
  const WalletPage({super.key});

  static const id = 'wallet_screen';

  @override
  State<WalletPage> createState() => _WalletPageState();
}

class _WalletPageState extends State<WalletPage> {
  String walletAddress = '';
  String balance = '0';
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

      String response = await getBalance(address.hex, 'sepolia');
      dynamic data = json.decode(response);
      String newBalance = data['balance'] ?? '0';

      EtherAmount latestBalance = EtherAmount.fromBigInt(
        EtherUnit.wei,
        BigInt.parse(newBalance),
      );

      String latestBalanceInEther =
          latestBalance.getValueInUnit(EtherUnit.ether).toString();

      setState(() {
        balance = latestBalanceInEther;
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
                        onPressed: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) =>
                                  SendTokensScreen(privateKey: pvKey),
                            ),
                          );
                        },
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
                            Column(
                              children: [
                                Card(
                                  margin: const EdgeInsets.all(16.0),
                                  shape: const RoundedRectangleBorder(
                                    borderRadius: BorderRadius.all(
                                      Radius.circular(2.0),
                                    ),
                                  ),
                                  child: Padding(
                                    padding: const EdgeInsets.all(16.0),
                                    child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        const Text(
                                          'Sepolia ETH',
                                          style: TextStyle(
                                            fontSize: 15.0,
                                            fontWeight: FontWeight.bold,
                                          ),
                                        ),
                                        Text(
                                          balance.substring(0, 4),
                                          style: const TextStyle(
                                            fontSize: 15.0,
                                            fontWeight: FontWeight.bold,
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                )
                              ],
                            ),
                            SingleChildScrollView(
                              child: NFTListPage(
                                address: walletAddress,
                                chain: 'sepolia',
                              ),
                            ),
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
