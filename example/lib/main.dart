import 'package:flutter/material.dart';
import 'package:flutter_loan_calculator/flutter_loan_calculator.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {

  String description = "When you want to buy a house, you can find a suitable residence or"
      "through the X application of consumer loan rates"
      "by comparing your loan application on a single page"
      "you can easily.";

  @override
  Widget build(BuildContext context) {
    return PaymentGenerator(
      // description: description,
    );
  }
}
