import 'package:flutter/material.dart';

class ChooseMode extends StatelessWidget {
  const ChooseMode({super.key});

  @override
  Widget build(BuildContext context) {
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
}
