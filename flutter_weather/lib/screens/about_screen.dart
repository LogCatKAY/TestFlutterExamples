import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutterweather/generated/l10n.dart';

class AboutScreen extends StatelessWidget {
  static const String ROUTE = "/about_screen";

  final String text;

  AboutScreen(this.text);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        iconTheme: IconThemeData(
          color: Colors.black, //change your color here
        ),
        title: Text(
          S.of(context).about_screen,
          style: TextStyle(color: Colors.black87),
        ),
        backgroundColor: Colors.white,
        brightness: Brightness.light,
      ),
      body: Builder(
        builder: (context) => _createBody(context),
      ),
    );
  }

  Widget _createBody(BuildContext context) {
    _showSnackbar(context);
    return Container(
      padding: EdgeInsets.all(16.0),
      alignment: Alignment.center,
      child: Text(
        S.of(context).copyright,
        style: TextStyle(fontSize: 16.0),
      ),
    );
  }

  void _showSnackbar(BuildContext context) {
    const time = Duration(milliseconds: 300);
    Timer(time, () {
      if (text.isNotEmpty) {
        final snackbar = SnackBar(
          content: Text(text),
        );
        Scaffold.of(context).showSnackBar(snackbar);
      }
    });
  }
}
