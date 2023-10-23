import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../main.dart';

class FavouritesPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    var theme = Theme.of(context);
    var appStatus = context.watch<AppState>();
    var favourites = appStatus.favourites;

    if (favourites.isEmpty) {
      return Center(child: Text("No favourites to display"));
    }

    return Center(
      child: ListView(
        children: [
          Padding(
            padding: const EdgeInsets.all(20),
            child: Text(
                "You have ${favourites.length} favourite${favourites.length == 1 ? "" : "s"}:"),
          ),
          for (var word in appStatus.favourites)
            ListTile(
              title: Text(word.asPascalCase),
              leading: IconButton(
                icon: Icon(Icons.delete, semanticLabel: "Delete"),
                color: theme.colorScheme.primary,
                onPressed: () => appStatus.removeFavourite(word),
              ),
            )
        ],
      ),
    );
  }
}