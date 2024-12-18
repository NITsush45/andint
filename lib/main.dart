import 'package:flutter/material.dart';
import 'components/credprojscreen.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Cred Project',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: CredProjScreen(),
    );
  }
}
