import 'package:flutter/material.dart';
import 'dart:math';
import 'package:intl/intl.dart';
import 'package:credproj/components/credproj.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';


class CredProjScreen extends StatefulWidget {
  @override
  _CredProjScreenState createState() => _CredProjScreenState();
}

class _CredProjScreenState extends State<CredProjScreen> {
  double _creditAmount = 150000;
  double _maxCreditAmount = 487891;
  double _dialAngle = 0;

  final NumberFormat _numberFormat = NumberFormat('#,##,##0');

  @override
  void initState() {
    super.initState();
    fetchCreditData();
  }
  Future<void> fetchCreditData() async {
    final url = Uri.parse('https://api.mocklets.com/p6764/test_mint');

    try {
      final response = await http.get(url);

      if (response.statusCode == 200) {
        final data = jsonDecode(response.body);
        setState(() {
          _creditAmount = data['creditAmount']?.toDouble() ?? _creditAmount;
          _maxCreditAmount = data['maxCreditAmount']?.toDouble() ?? _maxCreditAmount;
        });
      } else {
        print('Failed to load data: ${response.statusCode}');
      }
    } catch (e) {
      print('Error: $e');
    }
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        title: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Text(
              'Credit Amount',
              style: TextStyle(
                color: Color.fromARGB(255, 0, 0, 0),
                fontWeight: FontWeight.bold,
              ),
            ),
          ],
        ),
        leading: IconButton(
          onPressed: () {
            Navigator.pop(context);
          },
          icon: const Icon(Icons.close),
        ),
        actions: [
          IconButton(
            icon: Icon(Icons.help_outline),
            onPressed: () {},
          ),
        ],
      ),
      body: SingleChildScrollView(
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Padding(
                padding: const EdgeInsets.all(16.0),
                child: Text(
                  'nikunj, how much do you need?',
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ),
                ),
              ),
              Text(
                'move the dial and set any amount you need up to ₹${_numberFormat.format(_maxCreditAmount)}',
                style: TextStyle(color: Colors.grey, fontSize: 14),
              ),
              SizedBox(height: 32),
              Container(
                width: 400,
                height: 360,
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(20),
                ),
                child: Stack(
                  alignment: Alignment.center,
                  children: [
                    GestureDetector(
                      onPanUpdate: (details) {
                        setState(() {
                          final localPosition = details.localPosition;
                          final center = Offset(180, 150);
                          double newAngle = atan2(
                              localPosition.dy - center.dy,
                              localPosition.dx - center.dx);

                          if (newAngle < 0) {
                            newAngle += 2 * pi;
                          }

                          _dialAngle += (newAngle - _dialAngle) * 0.1;
                          _creditAmount =
                              (_dialAngle / (2 * pi)) * _maxCreditAmount;
                        });
                      },
                      child: CustomPaint(
                        size: Size(200, 200),
                        painter: DialPainter(dialAngle: _dialAngle),
                      ),
                    ),
                    Positioned(
                      top: 135,
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          const Text(
                            "credit amount",
                            style: TextStyle(color: Colors.black, fontSize: 14),
                          ),
                          Text(
                            "₹${_numberFormat.format(_creditAmount)}",
                            style: TextStyle(
                              fontSize: 20,
                              fontWeight: FontWeight.bold,
                              color: Colors.black,
                              decoration: TextDecoration.underline,
                              decorationStyle: TextDecorationStyle.dotted,
                            ),
                          ),
                          SizedBox(height: 4),
                          Text(
                            '@1.04% monthly',
                            style: TextStyle(
                              color: Colors.green[800],
                              fontSize: 12,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ],
                      ),
                    ),
                    Positioned(
                      bottom: 20,
                      child: ElevatedButton(
                        onPressed: () {
                          // Implement button action
                        },
                        child: Text('Get ₹${_numberFormat.format(_creditAmount)}'),
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.black,
                          foregroundColor: Colors.white,
                          padding: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(height: 12),
              ElevatedButton(
                onPressed: () {
                  Navigator.of(context).push(
                    PageRouteBuilder(
                      pageBuilder: (context, animation, secondaryAnimation) =>
                          RepayPage(
                            onBack: () {
                              Navigator.of(context).pop(); // Go back on button click
                            },
                          ),
                      transitionsBuilder: (context, animation, secondaryAnimation, child) {
                        var begin = Offset(0.0, 1.0);
                        var end = Offset.zero;
                        var curve = Curves.easeInOut;
                        var tween = Tween(begin: begin, end: end)
                            .chain(CurveTween(curve: curve));
                        var offsetAnimation = animation.drive(tween);

                        return SlideTransition(
                          position: offsetAnimation,
                          child: child,
                        );
                      },
                    ),
                  );
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.blue,
                  padding: EdgeInsets.symmetric(vertical: 16),
                  minimumSize: Size(double.infinity, 50),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                ),
                child: Text(
                  'Repay Options',
                  style: TextStyle(color: Colors.white, fontSize: 14),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class DialPainter extends CustomPainter {
  final double dialAngle;

  DialPainter({required this.dialAngle});

  @override
  void paint(Canvas canvas, Size size) {
    final center = Offset(size.width / 2, size.height / 2);
    final radius = size.width / 2;

    // Draw the background circle
    final backgroundPaint = Paint()
      ..strokeWidth = 20
      ..strokeCap = StrokeCap.round
      ..color = const Color.fromARGB(255, 1, 128, 246).withOpacity(0.3)
      ..style = PaintingStyle.stroke;

    canvas.drawCircle(center, radius - 10, backgroundPaint);

    // Draw the progress arc
    final arcPaint = Paint()
      ..strokeWidth = 20
      ..strokeCap = StrokeCap.round
      ..color = const Color.fromARGB(255, 76, 0, 255)
      ..style = PaintingStyle.stroke;

    canvas.drawArc(
      Rect.fromCircle(center: center, radius: radius - 10),
      -pi / 2, // Start angle
      dialAngle, // Sweep angle based on user interaction
      false,
      arcPaint,
    );

    // Draw the thumb (circle indicator)
    final thumbRadius = 12.0;
    final thumbX = center.dx + (radius - 10) * cos(dialAngle - pi / 2);
    final thumbY = center.dy + (radius - 10) * sin(dialAngle - pi / 2);

    final thumbPaint = Paint()..color = const Color.fromARGB(255, 0, 0, 0);
    canvas.drawCircle(Offset(thumbX, thumbY), thumbRadius, thumbPaint);
  }

  @override
  bool shouldRepaint(DialPainter oldDelegate) =>
      oldDelegate.dialAngle != dialAngle;
} 