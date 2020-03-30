import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

void main() => runApp(CounterAndAssetsApp());

class CounterAndAssetsApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Counter And Assets',
      home: MyHomePage(),
    );
  }
}

class MyHomePage extends StatelessWidget {
  final String title = "Flutter Counter And Assets";

  MyHomePage({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.indigo,
      appBar: AppBar(
        title: Text(title),
      ),
      body: Center(
        child: Container(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Container(
                margin: EdgeInsets.only(bottom: 16.0),
                child: Text(
                  'Tap "-" to decrement',
                  style: TextStyle(
                      fontSize: 22,
                      fontFamily: "WaltographRegular",
                      color: Colors.white),
                ),
              ),
              CounterWidget(),
              Container(
                margin: EdgeInsets.only(top: 16.0),
                child: Text(
                  'Tap "+" to increment',
                  style: TextStyle(
                      fontSize: 22,
                      fontFamily: "WaltographRegular",
                      color: Colors.white),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class CounterWidget extends StatefulWidget {
  @override
  State createState() => _CounterWidgetState();
}

class _CounterWidgetState extends State<CounterWidget> {
  int _counter = 50;

  final double _btnWidth = 48;

  @override
  void initState() {
    super.initState();
  }

  void _incrementCounter() {
    setState(() {
      _counter++;
    });
  }

  void _decrementCounter() {
    setState(() {
      _counter--;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      color: Colors.white70,
      child: SizedBox(
        width: _btnWidth * 4,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            IconButton(
              icon: Icon(Icons.remove),
              iconSize: _btnWidth,
              onPressed: () {
                _decrementCounter();
              },
            ),
            Container(
              width: _btnWidth,
              child: Text(
                "$_counter",
                style: TextStyle(fontSize: 24),
                textAlign: TextAlign.center,
                textDirection: TextDirection.ltr,
                textWidthBasis: TextWidthBasis.parent,
              ),
            ),
            IconButton(
              icon: Icon(Icons.add),
              iconSize: _btnWidth,
              onPressed: () {
                _incrementCounter();
              },
            ),
          ],
        ),
      ),
    );
  }
}
