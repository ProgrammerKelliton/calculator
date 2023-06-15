import 'package:flutter/material.dart';

class Calculator extends StatefulWidget {
  const Calculator({super.key});

  @override
  State<StatefulWidget> createState() => _CalculatorState();
}

class _CalculatorState extends State {
  String _result = "0";
  String _calculationStructure = "0";

  void changeResult(String value) {
    setState(() => _result = value);
  }

  void changeCalculationStructure(String value) {
    setState(() => _calculationStructure = value);
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: const Color.fromRGBO(68, 68, 68, 1),
        body: Column(
          children: [
            Flexible(
              child: Container(
                padding: const EdgeInsets.all(16),
                alignment: Alignment.centerRight,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      _calculationStructure,
                      style: const TextStyle(
                        color: Color.fromRGBO(152, 152, 152, 1),
                        fontSize: 24,
                      ),
                    ),
                    Text(
                      _result,
                      style: const TextStyle(
                        color: Colors.white,
                        fontSize: 32,
                      ),
                    ),
                  ],
                ),
              ),
            ),
            Flexible(
              flex: 2,
              child: Container(
                decoration: const BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(32),
                    topRight: Radius.circular(32),
                  ),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
