import 'package:flutter/material.dart';
import 'dart:math';
import 'editablecontent.dart';
import 'expandedpage.dart';
import 'credassign.dart';

class RepayPage extends StatefulWidget {
  final VoidCallback onBack;

  const RepayPage({Key? key, required this.onBack}) : super(key: key);

  @override
  _RepayPageState createState() => _RepayPageState();
}

class _RepayPageState extends State<RepayPage> {
  int? selectedBoxIndex;
  String? customAmount;
  String? customMonths;

  final List<Color> boxColors = [
    const Color.fromARGB(197, 255, 218, 32),
    const Color.fromARGB(136, 64, 129, 241),
    const Color.fromARGB(132, 98, 215, 158),
    const Color.fromARGB(168, 169, 124, 65),
    const Color.fromARGB(164, 208, 91, 229),
    const Color.fromARGB(151, 209, 209, 85),
    const Color.fromARGB(148, 95, 225, 212),
    const Color.fromARGB(141, 165, 43, 84),
    const Color.fromARGB(174, 83, 102, 209),
    const Color.fromARGB(133, 82, 216, 234),
    const Color.fromARGB(176, 232, 56, 147),
    const Color.fromARGB(136, 72, 74, 227),
    const Color.fromARGB(255, 71, 141, 124),
    const Color.fromARGB(124, 224, 36, 36),
    const Color.fromARGB(153, 184, 51, 207),
    const Color.fromARGB(136, 217, 229, 86),
  ];

  final List<Color> selectionColors = [
    Colors.redAccent,
    Colors.greenAccent,
    Colors.blueAccent,
    Colors.orangeAccent,
    Colors.purpleAccent,
  ];

  final List<String> repaymentAmounts = [];
  final Random _random = Random();

  @override
  void initState() {
    super.initState();
    for (int i = 0; i < boxColors.length; i++) {
      repaymentAmounts
          .add(i == 2 ? '₹1324/mo for 8 months' : generateRandomRepayment());
    }
  }

  String generateRandomRepayment() {
    int amount = 1000 + _random.nextInt(10000);
    int months = _random.nextInt(12) + 1;
    return '₹$amount/mo for $months months';
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        leading: IconButton(
          onPressed: widget.onBack,
          icon: const Icon(Icons.arrow_back),
        ),
        title: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Text(
              'Repay',
              style: TextStyle(
                color: Color.fromARGB(255, 0, 0, 0),
                fontWeight: FontWeight.bold,
              ),
            ),
          ],
        ),
        backgroundColor: const Color.fromARGB(255, 255, 254, 254),
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Expanded(
            child: SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const SizedBox(height: 24),
                    const Text(
                      'How do you wish to repay?',
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                      ),
                    ),
                    const SizedBox(height: 8),
                    const Text(
                      'Choose one of our recommended plans or make your own',
                      style: TextStyle(
                        fontSize: 14,
                        color: Colors.white,
                      ),
                    ),
                    const SizedBox(height: 16),
                    if (customAmount != null && customMonths != null)
                      Container(
                        padding: const EdgeInsets.all(16),
                        decoration: BoxDecoration(
                          color: Colors.grey.shade800,
                          borderRadius: BorderRadius.circular(12),
                        ),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const Text(
                              'My Plan',
                              style:
                                  TextStyle(color: Colors.white, fontSize: 16),
                            ),
                            const SizedBox(height: 8),
                            Text(
                              'EMI: $customAmount',
                              style: const TextStyle(
                                color: Colors.greenAccent,
                                fontSize: 16,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            Text(
                              'Duration: $customMonths months',
                              style: const TextStyle(
                                color: Colors.blueAccent,
                                fontSize: 16,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ],
                        ),
                      ),
                    const SizedBox(height: 24),
                    SizedBox(
                      height: 180,
                      child: ListView.builder(
                        scrollDirection: Axis.horizontal,
                        itemCount: boxColors.length,
                        itemBuilder: (context, index) {
                          return GestureDetector(
                            onTap: () {
                              setState(() {
                                selectedBoxIndex = index;
                              });
                              final amount =
                                  repaymentAmounts[index].split('/')[0];
                              final months =
                                  repaymentAmounts[index].split('/')[1];

                              Navigator.of(context).push(
                                MaterialPageRoute(
                                  builder: (context) => RepaymentDetailPage(
                                    amount: amount,
                                    months: 'per $months',
                                  ),
                                ),
                              );
                            },
                            child: AnimatedContainer(
                              duration: const Duration(milliseconds: 300),
                              width: 150,
                              margin: const EdgeInsets.only(right: 16),
                              padding: const EdgeInsets.all(12),
                              decoration: BoxDecoration(
                                color: boxColors[index % boxColors.length],
                                borderRadius: BorderRadius.circular(8),
                                border: Border.all(
                                  color: selectedBoxIndex == index
                                      ? selectionColors[
                                          index % selectionColors.length]
                                      : Colors.transparent,
                                  width: 2,
                                ),
                              ),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  if (index == 2)
                                    Container(
                                      padding: const EdgeInsets.all(4),
                                      decoration: BoxDecoration(
                                        color: Colors.white,
                                        borderRadius: BorderRadius.circular(10),
                                      ),
                                      child: const Text(
                                        'Recommended',
                                        style: TextStyle(
                                          fontSize: 10,
                                          fontWeight: FontWeight.bold,
                                          color: Colors.black,
                                        ),
                                      ),
                                    ),
                                  const SizedBox(height: 8),
                                  Icon(
                                    Icons.check_circle,
                                    color: selectedBoxIndex == index
                                        ? Colors.black
                                        : Colors.grey,
                                    size: 18,
                                  ),
                                  const SizedBox(height: 8),
                                  Text(
                                    repaymentAmounts[index].split('/')[0],
                                    style: const TextStyle(
                                      fontSize: 16,
                                      fontWeight: FontWeight.bold,
                                      color: Colors.white,
                                    ),
                                  ),
                                  Text(
                                    'per ${repaymentAmounts[index].split('/')[1]}',
                                    style: TextStyle(
                                      fontSize: 12,
                                      color: Colors.white.withOpacity(0.8),
                                    ),
                                  ),
                                  const SizedBox(height: 4),
                                  GestureDetector(
                                    onTap: () {
                                      final amount =
                                          repaymentAmounts[index].split('/')[0];
                                      final months =
                                          repaymentAmounts[index].split('/')[1];
                                      Navigator.of(context).push(
                                        MaterialPageRoute(
                                          builder: (context) =>
                                              RepaymentDetailPage(
                                            amount: amount,
                                            months: 'per $months',
                                          ),
                                        ),
                                      );
                                    },
                                    child: const Text(
                                      'See calculation',
                                      style: TextStyle(
                                        fontSize: 10,
                                        fontWeight: FontWeight.bold,
                                        color: Colors.lightBlueAccent,
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          );
                        },
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              children: [
                Row(
                  mainAxisAlignment:
                      MainAxisAlignment.start,
                  children: [
                    ElevatedButton(
                      onPressed: () {
                        Navigator.of(context)
                            .push(
                          MaterialPageRoute(
                            builder: (context) => EditableRepaymentPage(
                              initialAmount: customAmount ?? '₹0/mo',
                              initialMonths: customMonths ?? '0',
                            ),
                          ),
                        )
                            .then((result) {
                          if (result != null && result is Map<String, String>) {
                            setState(() {
                              customAmount = result['amount'];
                              customMonths = result['months'];
                            });
                          }
                        });
                      },
                      child: const Text('Create your own plan'),
                      style: ElevatedButton.styleFrom(
                        backgroundColor: const Color.fromARGB(255, 160, 159, 159),
                        foregroundColor: const Color.fromARGB(255, 64, 0, 255),
                        padding: EdgeInsets.symmetric(vertical: 16),
                        minimumSize: Size(150, 50),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(20),
                        ),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 16),
                ElevatedButton(
                  onPressed: () {
                    Navigator.of(context).push(
                      PageRouteBuilder(
                        pageBuilder: (context, animation, secondaryAnimation) =>
                            PaymentScreen(),
                        transitionsBuilder:
                            (context, animation, secondaryAnimation, child) {
                          return SlideTransition(
                            position: Tween<Offset>(
                              begin: const Offset(0, 1),
                              end: Offset.zero,
                            ).animate(animation),
                            child: child,
                          );
                        },
                      ),
                    );
                  },
                  child: Text(
                    'Select your Bank Account',
                    style: TextStyle(color: Colors.white, fontSize: 14),
                  ),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.blue,
                    padding: EdgeInsets.symmetric(vertical: 16),  
                    minimumSize: Size(double.infinity, 50),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                  ),
                ),
              ],
            ),
          )
        ],
      ),
    );
  }
}
