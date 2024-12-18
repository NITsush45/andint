import 'package:flutter/material.dart';

class EditableRepaymentPage extends StatefulWidget {
  final String initialAmount;
  final String initialMonths;

  EditableRepaymentPage({required this.initialAmount, required this.initialMonths});

  @override
  _EditableRepaymentPageState createState() => _EditableRepaymentPageState();
}

class _EditableRepaymentPageState extends State<EditableRepaymentPage> {
  late TextEditingController _amountController;
  late TextEditingController _monthsController;

  @override
  void initState() {
    super.initState();
    _amountController = TextEditingController(text: widget.initialAmount);
    _monthsController = TextEditingController(text: widget.initialMonths);
  }

  @override
  void dispose() {
    _amountController.dispose();
    _monthsController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        title: const Text('Edit Repayment Plan'),
        leading: IconButton(
          onPressed: () {
            Navigator.pop(context);
          },
          icon: const Icon(Icons.arrow_back),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            TextField(
              controller: _amountController,
              decoration: InputDecoration(
                labelText: 'EMI Amount',
                labelStyle: TextStyle(color: const Color.fromARGB(255, 242, 255, 0)),
                filled: true,
                fillColor: const Color.fromARGB(255, 131, 135, 130),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
              ),
              keyboardType: TextInputType.number,
              style: TextStyle(color: const Color.fromARGB(255, 0, 187, 255)),
            ),
            SizedBox(height: 16),
            TextField(
              controller: _monthsController,
              decoration: InputDecoration(
                labelText: 'Duration (Months)',
                labelStyle: TextStyle(color: const Color.fromARGB(255, 251, 255, 0)),
                filled: true,
                fillColor: const Color.fromARGB(255, 130, 128, 130),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
              ),
              keyboardType: TextInputType.number,
              style: TextStyle(color: const Color.fromARGB(255, 0, 187, 255)),
            ),
            SizedBox(height: 24),
            ElevatedButton(
              onPressed: () {
                Navigator.pop(
                  context,
                  {
                    'amount': _amountController.text,
                    'months': _monthsController.text,
                  },
                );
              },
              child: Text('Save Changes'),
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.blue,
                foregroundColor: Colors.white,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
