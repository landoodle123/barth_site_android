import 'package:flutter/material.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key, required this.title});

  final String title;

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final int MAX_COUNT = 2000000000;
  int count = 0;
  int amountGained = 1;
  int clickerCount = 0;
  int clickerCost = 100;
  int multiplierCost = 150;
  int clickerMultiplierCost = 1000;
  int clickerGain = 1;
  late int clickerInterval; // single interval for all clickers
  bool confirmReset = false;
  bool loaded = false;
  late int saveInterval;


  // functions for app logic
  void incrementCount() {
    if (count + amountGained <= MAX_COUNT) {
      setState(() {
        count += amountGained;
      });
    }
  }
  


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: Text(widget.title),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Text('You have pushed the button this many times:'),
            Text(
              '$count',
              style: Theme.of(context).textTheme.headlineMedium,
            ),
          ],
        ),
      ),
    );
  }
}
