import 'package:flutter/material.dart';
import './google_mlkit_page.dart';
import './document_frame_scanner.dart';

void main() {
  runApp(const MainApp());
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    var theme = ThemeData(
      colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepOrange),
    );
    return MaterialApp(
      title: "Scanner App",
      theme: theme,
      home: Scaffold(
        body: HomePage(),
        appBar: AppBar(
          elevation: 20,
          backgroundColor: theme.colorScheme.inversePrimary,
          title: Text("Scanner app"),
        )
      ),
    );
  }
}

class HomePage extends StatefulWidget {
  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  var selected = 0;

  @override
  Widget build(BuildContext context) {
    Widget page;
    switch (selected) {
      case 0:
        page = GoogleMLKit();
        break;
      case 1:
        page = DocumentScanner();
        break;
      default:
        throw UnimplementedError("Should not be able to select this page");
    }

    return LayoutBuilder(
      builder: (context, constraints) {
        return Scaffold(
          body: Row(
            children: [
              SafeArea(
                child: NavigationRail(
                  extended: constraints.maxWidth > 1000,
                  destinations: [
                    NavigationRailDestination(
                      icon: Icon(Icons.add_photo_alternate_rounded),
                      label: Text('Google MLKit'),
                    ),
                    NavigationRailDestination(
                      icon: Icon(Icons.add_photo_alternate_rounded),
                      label: Text('Document frame scanner'),
                    ),
                  ],
                  selectedIndex: selected,
                  onDestinationSelected: (value) {
                    setState(() {
                      selected = value;
                    });
                  },
                ),
              ),
              Expanded(
                child: Container(
                  color: Theme.of(context).colorScheme.primaryContainer,
                  child: page,
                ),
              ),
            ],
          ),
        );
      }
    );
  }
}