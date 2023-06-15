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

  void navigateToCalculationsHistory() {}

  Widget chooceMode() {
    return Container(
      margin: const EdgeInsets.all(24),
      width: 120,
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(32),
      ),
      child: const Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          ImageIcon(
            AssetImage("assets/icons/moon-selected.png"),
            color: Color.fromRGBO(68, 68, 68, 1),
          ),
          ImageIcon(
            AssetImage("assets/icons/sun.png"),
            color: Color.fromRGBO(68, 68, 68, 1),
          )
        ],
      ),
    );
  }

  Widget history() {
    return Container(
      padding: const EdgeInsets.all(24),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          IconButton(
            onPressed: navigateToCalculationsHistory,
            icon: const Icon(
              Icons.history,
              color: Colors.white,
            ),
          ),
        ],
      ),
    );
  }

  Widget viewResult() {
    return Container(
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
    );
  }

  Widget buttons() {
    return Container(
      decoration: const BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(32),
          topRight: Radius.circular(32),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    Size screen = MediaQuery.of(context).size;

    return SafeArea(
      child: Scaffold(
        backgroundColor: const Color.fromRGBO(68, 68, 68, 1),
        appBar: AppBar(
          backgroundColor: Colors.transparent,
          toolbarHeight: 100,
          leadingWidth: screen.width,
          actions: [chooceMode()],
          leading: history(),
        ),
        body: Column(
          children: [
            Flexible(child: viewResult()),
            Flexible(flex: 2, child: buttons())
          ],
        ),
      ),
    );
  }
}
