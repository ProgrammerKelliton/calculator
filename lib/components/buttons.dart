import 'package:flutter/material.dart';

class Buttons extends StatelessWidget {
  final Function c;

  const Buttons({super.key, required this.c});

  final List<String> textsButtons = const [
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

  final List<String> hightlightTexts = const [
    "+",
    "-",
    "/",
    "=",
    "*",
  ];

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

  Widget button(BuildContext context, String text) {
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
        onPressed: () => {c(text)},
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
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
        itemBuilder: (context, index) => button(context, textsButtons[index]),
      ),
    );
  }
}
