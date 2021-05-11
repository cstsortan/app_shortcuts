import 'package:flutter/material.dart';
import 'dart:async';

import 'package:flutter/services.dart';
import 'package:app_shortcuts/app_shortcuts.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  void initState() {
    super.initState();
  }

  // Platform messages are asynchronous, so we initialize in an async method.
  Future<void> _createShortcut() async {
    return AppShortcuts.createShortcut(
      title: "Pub.dev",
      link: 'https://pub.dev/',
      id: 'pub.dev',
      description: "Add pub.dev to your home screen",
      imageUrl:
          'https://flutter.dev/images/favicon.png',
    );
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: const Text('Plugin example app'),
        ),
        body: Center(
          child: Text('Click the FAB to add a shortcut to pub.dev'),
        ),
        floatingActionButton: FloatingActionButton(
          child: Icon(Icons.add),
          onPressed: _createShortcut,
        ),
      ),
    );
  }
}
