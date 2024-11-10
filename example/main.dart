import 'package:flutter/material.dart';
import 'package:error_overlay/error_overlay.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      home: ErrorOverlay(child: MyHomePage()),
    );
  }
}

class MyHomePage extends StatelessWidget {
  const MyHomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        // Wrap your prefer widget with ShowErrorOverlay to enable monitoring
        title: const ShowErrorOverlay(child: Text("Log Monitor")),
      ),
      body: Center(
        child: TextButton(
          child: const Text("Throw Exception"),
          onPressed: () {
            throw Exception("Test Exception");
          },
        ),
      ),
    );
  }
}
