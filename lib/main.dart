import 'package:english_words/english_words.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'pages/Favourites.page.dart';
import 'pages/Generator.page.dart';

// Tells Flutter to run the app (defined in the App class).
void main() {
  runApp(App());
}

// The App class extends StatelessWidget so the app itself is a widget.
// The code here sets up the whole app. It creates the app-wide state,
// names the app, defines the visual theme, and sets the 'Home' widget.
class App extends StatelessWidget {
  const App({super.key});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => AppState(),
      child: MaterialApp(
        title: 'Namer App',
        home: HomePage(),
        theme: ThemeData(
          useMaterial3: true,
          colorScheme: ColorScheme.fromSeed(seedColor: Colors.cyan),
        ),
      ),
    );
  }
}

// This defines the app's state - any widget in the app can get hold of this state.
// It extends ChangeNotifier so it can notify others about its own changes.
class AppState extends ChangeNotifier {
  var current = WordPair.random();

  // This method reassigns 'current' with a new random WordPair and calls
  // 'notifyListeners()' (a method of ChangeNotifier) to ensure that anyone
  // watching AppState is notified.
  void getNext() {
    current = WordPair.random();
    notifyListeners();
  }

  // This property is initialized with an empty list: [].
  // Using generics means the list can only ever contain word pairs.
  var favourites = <WordPair>[];

  void toggleFavourite() {
    if (favourites.contains(current)) {
      favourites.remove(current);
    } else {
      favourites.add(current);
    }
    notifyListeners();
  }

  void removeFavourite(WordPair pair) {
    favourites.remove(pair);
    notifyListeners();
  }
}

// The HomePage has its own separate state for navigation
class HomePage extends StatefulWidget {
  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  var selectedIndex = 0;

  @override
  // Every widget defines a 'build()' method that's automatically called every
  // time the widget's circumstances change, so that the widget is always
  // up to date.
  Widget build(BuildContext context) {
    // Get colour theme from App and use it to style the title text
    final theme = Theme.of(context);
    final titleStyle = theme.textTheme.headlineSmall!
        .copyWith(color: theme.colorScheme.onPrimary);

    Widget page;
    switch (selectedIndex) {
      case 0:
        page = GeneratorPage();
        break;
      case 1:
        page = FavouritesPage();
        break;
      default:
        throw UnimplementedError('No widget for $selectedIndex');
    }

    // Every 'build' method must return a widget or a nested tree of widgets.
    return LayoutBuilder(builder: (context, constraints) {
      return Scaffold(
        appBar: AppBar(
          title: Text("Random Name Generator", style: titleStyle),
          backgroundColor: theme.colorScheme.primary,
        ),
        body: Row(
          children: [
            SafeArea(
              child: NavigationRail(
                  // Nav bar will only extend at a certain width
                  extended: constraints.maxWidth >= 600,
                  selectedIndex: selectedIndex,
                  destinations: [
                    NavigationRailDestination(
                      icon: Icon(Icons.home),
                      label: Text("Home"),
                    ),
                    NavigationRailDestination(
                      icon: Icon(Icons.favorite),
                      label: Text("Favourites"),
                    ),
                  ],
                  // setState is similar to notifyListeners() — makes sure that the UI updates.
                  onDestinationSelected: (value) =>
                      setState(() => selectedIndex = value)),
            ),
            // Expanded is 'greedy' and takes up any space it can (similar to flex)
            Expanded(
              child: Container(
                color: Theme.of(context).colorScheme.primaryContainer,
                child: page,
              ),
            ),
          ],
        ),
      );
    });
  }
}