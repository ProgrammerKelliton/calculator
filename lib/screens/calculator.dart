import 'package:calculator/screens/historic.dart';
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

  Color getTextColor(String text, BuildContext context) {
    if (text == "C") {
      return const Color.fromRGBO(172, 65, 65, 1);
    }
    if (hightlightTexts.contains(text)) {
      return const Color.fromRGBO(65, 172, 108, 1);
    } else {
      return Theme.of(context).colorScheme.onBackground;
    }
  }

  void navigateToCalculationsHistory() {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => const Historic(),
      ),
    );
  }

  Widget chooceMode(BuildContext context) {
    return Container(
      margin: const EdgeInsets.all(24),
      width: 120,
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Theme.of(context).colorScheme.secondary,
        borderRadius: BorderRadius.circular(32),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          IconButton(
            constraints: const BoxConstraints(),
            padding: EdgeInsets.zero,
            icon: Image.asset("assets/icons/moon-selected.png"),
            color: Theme.of(context).colorScheme.onBackground,
            onPressed: () => {}, // ! Mude o tema
          ),
          IconButton(
            constraints: const BoxConstraints(),
            padding: EdgeInsets.zero,
            icon: Image.asset("assets/icons/sun.png"),
            color: Theme.of(context).colorScheme.onBackground,
            onPressed: () => {}, // ! Mude o tema
          )
        ],
      ),
    );
  }

  Widget history(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(24),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          IconButton(
            onPressed: navigateToCalculationsHistory,
            icon: Icon(
              Icons.history,
              color: Theme.of(context).colorScheme.secondary,
            ),
          ),
        ],
      ),
    );
  }

  Widget viewResult(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16),
      alignment: Alignment.centerRight,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.end,
        children: [
          Text(
            _calculationStructure,
            style: TextStyle(
              color: Theme.of(context).colorScheme.secondary,
              fontSize: 24,
            ),
          ),
          Text(
            _result,
            style: TextStyle(
              color: Theme.of(context).colorScheme.secondary,
              fontSize: 32,
            ),
          ),
        ],
      ),
    );
  }

  Widget buttons(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Theme.of(context).colorScheme.secondary,
        borderRadius: const BorderRadius.only(
          topLeft: Radius.circular(32),
          topRight: Radius.circular(32),
        ),
      ),
      child: GridView.builder(
        itemCount: 20,
        padding: const EdgeInsets.all(16),
        gridDelegate:
            const SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 4),
        itemBuilder: (context, index) => button(textsButtons[index], context),
      ),
    );
  }

  Widget button(String text, BuildContext context) {
    return Container(
      margin: const EdgeInsets.all(8),
      alignment: Alignment.center,
      decoration: BoxDecoration(
        color: Theme.of(context).colorScheme.secondary,
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
            color: getTextColor(text, context),
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
        backgroundColor: Theme.of(context).colorScheme.background,
        appBar: AppBar(
          backgroundColor: Colors.transparent,
          toolbarHeight: 100,
          shadowColor: Colors.transparent,
          leadingWidth: screen.width,
          actions: [chooceMode(context)],
          leading: history(context),
        ),
        body: Column(
          children: [
            Flexible(child: viewResult(context)),
            Flexible(flex: 3, child: buttons(context))
          ],
        ),
      ),
    );
  }
}
