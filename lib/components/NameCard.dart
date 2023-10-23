import 'package:english_words/english_words.dart';
import 'package:flutter/material.dart';

// Separate widget for separate logical parts of the UI which only requires
// a WordPair (so don't need to pass in the whole appState).
class NameCard extends StatelessWidget {
  const NameCard({super.key, required this.name});

  final WordPair name;

  @override
  Widget build(BuildContext context) {
    // Request the app's current theme
    final theme = Theme.of(context);

    // The ! symbol assures Dart that 'displayMedium' is definitely not null.
    final style = theme.textTheme.displayMedium!
        .copyWith(color: theme.colorScheme.onPrimary);

    return Card(
        color: theme.colorScheme.primary,
        elevation: 5,
        child: Padding(
            padding: const EdgeInsets.all(20),
            child: AnimatedSize(
              duration: Duration(milliseconds: 200),
              // Make sure that the compound word wraps correctly when the
              // window is too narrow.
              child: MergeSemantics(
                // Use 'semanticsLabel' for screen-readers (use spacing to make
                // made-up words easier to pronounce).
                child: Text(name.asPascalCase,
                    semanticsLabel: "${name.first} ${name.second}",
                    style: style),
              ),
            )));
  }
}