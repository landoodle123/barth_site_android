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

  void reset() {
    count = 0;
    clickerCount = 0;
    clickerCost = 100;
    multiplierCost = 150;
    clickerMultiplierCost = 1000;
    clickerGain = 1;
    amountGained = 1;
    //TODO: clearAllClickers
    //TODO: startAllClickers
    //TODO: saveState
  }

  void buyClicker() {
    if (count >= clickerCost) {
      setState(() {
        count -= clickerCost;
        clickerCount += 1;
        clickerCost = (clickerCost * 2.5).toInt();
      });
    }
    else {
      showDialog<bool>(
  context: context,
  builder: (BuildContext context) => AlertDialog(
    title: const Text('Not enough clicks!'),
    content: const Text('You do not have enough clicks to buy this item.'),
    actions: [
      ElevatedButton(
        style: ElevatedButton.styleFrom(backgroundColor: Colors.white),
        child: const Text(
          'Okay',
          style: TextStyle(color: Colors.black),
        ),
        onPressed: () => Navigator.pop(context, true),
      ),
    ],
  ),
);
    }
  }
  void buyMultiplier() {
    if (count >= multiplierCost) {
      setState(() {
        count -= multiplierCost;
        amountGained = amountGained * 2;
        multiplierCost = (multiplierCost * 3).toInt();
      });
    }
    else {
      showDialog<bool>(
  context: context,
  builder: (BuildContext context) => AlertDialog(
    title: const Text('Not enough clicks!'),
    content: const Text('You do not have enough clicks to buy this item.'),
    actions: [
      ElevatedButton(
        style: ElevatedButton.styleFrom(backgroundColor: Colors.white),
        child: const Text(
          'Okay',
          style: TextStyle(color: Colors.black),
        ),
        onPressed: () => Navigator.pop(context, true),
      ),
    ],
  ),
);
    }
  }
  void buyClickerMultiplier() {
    if (count >= clickerMultiplierCost) {
      setState(() {
        count -= clickerMultiplierCost;
        clickerGain += 1;
        clickerMultiplierCost = (clickerMultiplierCost * 2.5).toInt();
      });
    }
    else {
      showDialog<bool>(
  context: context,
  builder: (BuildContext context) => AlertDialog(
    title: const Text('Not enough clicks!'),
    content: const Text('You do not have enough clicks to buy this item.'),
    actions: [
      ElevatedButton(
        style: ElevatedButton.styleFrom(backgroundColor: Colors.white),
        child: const Text(
          'Okay',
          style: TextStyle(color: Colors.black),
        ),
        onPressed: () => Navigator.pop(context, true),
      ),
    ],
  ),
);
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
