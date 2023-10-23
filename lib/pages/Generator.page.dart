import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../components/NameCard.dart';
import '../main.dart';

class GeneratorPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    // Tracks changes to the app's current state using the 'watch' method.
    var appState = context.watch<AppState>();
    // Access a member of the state class - 'current' (which is a WordPair).
    var randomWord = appState.current;

    IconData icon;
    icon = appState.favourites.contains(randomWord)
        ? Icons.favorite
        : Icons.favorite_border;

    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          // This custom widget Text widget takes the WordPair member of state.
          NameCard(name: randomWord),
          // SizedBox widget just takes space and doesn't render anything by
          // itself - commonly used to create visual gaps.
          SizedBox(height: 10),
          Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              ElevatedButton.icon(
                onPressed: () => appState.toggleFavourite(),
                label: Text('Like'),
                icon: Icon(icon),
              ),
              SizedBox(width: 10),
              ElevatedButton(
                onPressed: () => appState.getNext(),
                child: Text('Next'),
              ),
            ],
          ),
        ],
      ),
    );
  }
}