import 'package:flutter/material.dart';

class RepaymentDetailPage extends StatelessWidget {
  final String amount;
  final String months;

  RepaymentDetailPage({required this.amount, required this.months});

  @override
  Widget build(BuildContext context) {
    String monthNumber = months.split(' ')[3];

    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        title: const Text('Repayment Details'),
        leading: IconButton(
          onPressed: () {
            Navigator.pop(context);
          },
          icon: const Icon(Icons.arrow_back),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            Container(
              padding: EdgeInsets.all(16),
              height: 100,
              width: 150,
              decoration: BoxDecoration(
                color: const Color.fromARGB(255, 103, 255, 72),
                borderRadius: BorderRadius.circular(12),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'EMI Amount',
                    style: TextStyle(color: const Color.fromARGB(255, 0, 0, 0), fontSize: 16),
                  ),
                  SizedBox(height: 8),
                  Text(
                    amount,
                    style: TextStyle(
                      color: const Color.fromARGB(255, 85, 0, 255),
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(width: 8),
            Container(
              padding: EdgeInsets.all(16),
              height: 100, 
              width: 150,
              decoration: BoxDecoration(
                color: const Color.fromARGB(255, 241, 223, 32),
                borderRadius: BorderRadius.circular(12),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Duration',
                    style: TextStyle(color: const Color.fromARGB(255, 0, 0, 0), fontSize: 16),
                  ),
                  SizedBox(height: 6),
                  Text(
                    monthNumber,
                    style: TextStyle(
                      color: const Color.fromARGB(255, 55, 0, 255),
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
