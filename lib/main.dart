import 'package:flutter/material.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        body: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            CounterStateless(),
            SizedBox(
              height: 20,
            ),
            CounterStateful(),
          ],
        ),
      ),
    );
  }
}

class CounterStateless extends StatelessWidget {
  int _counter = 0;

  void _incrementCounter() {
    _counter++;
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        children: [
          Text('StatelessWidget'),
          Text(
            'Contagem:',
            style: TextStyle(fontSize: 26),
          ),
          ElevatedButton(
            onPressed: _incrementCounter,
            child: Text('Incrementar'),
          ),
        ],
      ),
    );
  }
}

class CounterStateful extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _CounterStateful();
  }
}

class _CounterStateful extends State<CounterStateful> {
  int _counter = 0;

  void _incrementCounter() {
    setState(() {
      _counter++;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        children: [
          Text('StatefulWidget'),
          Text(
            'Contagem: $_counter',
            style: TextStyle(fontSize: 26),
          ),
          ElevatedButton(
            onPressed: _incrementCounter,
            child: Text('Incrementar'),
          ),
        ],
      ),
    );
  }
}
