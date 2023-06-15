import 'package:flutter/material.dart';
import 'package:math_expressions/math_expressions.dart';

class Calculator extends StatefulWidget {
  const Calculator({super.key});

  @override
  State<StatefulWidget> createState() => _CalculatorState();
}

class _CalculatorState extends State {
  String _result = "";
  String _calculationStructure = "";

  final List<String> textsButtons = [
    "C",
    "(",
    ")",
    "/",
    "7",
    "8",
    "9",
    "*",
    "4",
    "5",
    "6",
    "-",
    "1",
    "2",
    "3",
    "+",
    "+/-",
    "0",
    ".",
    "=",
  ];

  final List<String> hightlightTexts = [
    "+",
    "-",
    "/",
    "=",
    "*",
  ];

  void changeResult(String value) {
    setState(() => _result = value);
  }

  void changeCalculationStructure(String operationOrValue) {
    if (operationOrValue != "C") {
      setState(() => _calculationStructure += operationOrValue);
    } else if (operationOrValue == "C") {
      setState(() => _calculationStructure = "");
      changeResult("");
    }

    if (operationOrValue == "=") {
      changeResult(calculator(_calculationStructure.replaceFirst("=", "")));
    }
  }

  String calculator(String inputString) {
    try {
      var exp = Parser().parse(inputString);
      var result = exp.evaluate(EvaluationType.REAL, ContextModel());
      var resultInString = result.toString();

      resultInString = resultInString.endsWith(".0")
          ? resultInString.replaceAll(".0", "")
          : resultInString;

      return resultInString;
    } catch (e) {
      return "Error";
    }
  }

  Color getTextColor(String text) {
    if (text == "C") {
      return const Color.fromRGBO(172, 65, 65, 1);
    }
    if (hightlightTexts.contains(text)) {
      return const Color.fromRGBO(65, 172, 108, 1);
    } else {
      return const Color.fromRGBO(68, 68, 68, 1);
    }
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
        crossAxisAlignment: CrossAxisAlignment.end,
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
      child: GridView.builder(
        itemCount: 20,
        padding: const EdgeInsets.all(16),
        gridDelegate:
            const SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 4),
        itemBuilder: (context, index) => button(textsButtons[index]),
      ),
    );
  }

  Widget button(String text) {
    return Container(
      margin: const EdgeInsets.all(8),
      alignment: Alignment.center,
      decoration: BoxDecoration(
        color: Colors.grey[50],
        borderRadius: BorderRadius.circular(16),
      ),
      child: TextButton(
        style: ButtonStyle(
          minimumSize: const MaterialStatePropertyAll<Size>(Size.infinite),
          shape: MaterialStatePropertyAll(
            BeveledRectangleBorder(
              borderRadius: BorderRadius.circular(8),
            ),
          ),
          overlayColor: const MaterialStatePropertyAll<Color>(
            Colors.grey,
          ),
        ),
        child: Text(
          text,
          textAlign: TextAlign.center,
          style: TextStyle(
            fontSize: 24,
            color: getTextColor(text),
          ),
        ),
        onPressed: () => changeCalculationStructure(text),
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
            Flexible(flex: 3, child: buttons())
          ],
        ),
      ),
    );
  }
}
