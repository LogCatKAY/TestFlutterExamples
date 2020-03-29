import 'dart:async';

import 'package:flutter/material.dart';

void main() => runApp(MyFirstFlutterApp());

class MyFirstFlutterApp extends StatefulWidget {
  @override
  State createState() {
    return _MyFirstFlutterAppState();
  }
}

class _MyFirstFlutterAppState extends State<MyFirstFlutterApp> {

  bool _isDownload;
  double _progressValue;

  @override
  void initState() {
    _isDownload = false;
    _progressValue = 0.0;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        backgroundColor: Colors.indigo,
        appBar: AppBar(
          title: Text("My First Flutter App"),
          centerTitle: false,
        ),
        body: Center(
          child: Container(
            padding: EdgeInsets.all(16),
            child: _isDownload
                ? Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                LinearProgressIndicator(
                  value: _progressValue,
                ),
                Text(
                  "${(_progressValue * 100).round()} %",
                  style: TextStyle(color: Colors.white, fontSize: 20),
                ),
              ],
            )
                : Text(
              "Press FAB button to download",
              style: TextStyle(color: Colors.white, fontSize: 20),
            ),
          ),
        ),
        floatingActionButton: FloatingActionButton(
          onPressed: () {
            setState(() {
              _isDownload = !_isDownload;
              _updateProgress();
            });
          },
          child: Icon(Icons.cloud_download),
        ),
      ),
    );
  }

  void _updateProgress() {
    const oneSec = Duration(seconds: 1);
    Timer.periodic(oneSec, (Timer timer) {
      setState(() {

        if(!_isDownload) {
          timer.cancel();
          return;
        }

        _progressValue += 0.1;

        debugPrint("onTimer: download = $_isDownload, progress = $_progressValue");

        if(_progressValue >= 1.0) {
          _isDownload = false;
          timer.cancel();
          _progressValue = 0.0;
          return;
        }
      });
    });
  }
}
