import 'package:calculator/credit_page.dart';
import 'package:flutter/material.dart';
void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Kredi',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: CreditPage(),
    );
  }
}
