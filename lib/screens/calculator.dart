import 'package:calculator/components/buttons.dart';
import 'package:flutter/material.dart';
import 'package:math_expressions/math_expressions.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Calculator extends StatefulWidget {
  const Calculator({super.key});

  @override
  State<StatefulWidget> createState() => _CalculatorState();
}

class _CalculatorState extends State {
  String _result = "";
  String _calculationStructure = "";
  Future<SharedPreferences> prefs = SharedPreferences.getInstance();

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
        ),
        body: Column(
          children: [
            Flexible(child: viewResult(context)),
            Flexible(
              flex: 3,
              child: Buttons(c: changeCalculationStructure),
            )
          ],
        ),
      ),
    );
  }
}
