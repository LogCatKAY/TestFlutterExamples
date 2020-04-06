import 'package:flutter/material.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutterweather/screens/about_screen.dart';
import 'package:flutterweather/widgets/date_widget.dart';
import 'package:flutterweather/weather_network/cities_utils.dart';
import 'package:flutterweather/widgets/weather_widget.dart';

import 'generated/l10n.dart';

void main() => runApp(WeatherApp());

class WeatherApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      onGenerateRoute: (settings) {
        switch (settings.name) {
          case '/':
            return MaterialPageRoute(builder: (context) => MainScreen());
          case AboutScreen.ROUTE:
            String someText = settings.arguments;
            return MaterialPageRoute(
                builder: (context) => AboutScreen(someText));
        }
        return null;
      },
      localizationsDelegates: [
        S.delegate,
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
      ],
      supportedLocales: S.delegate.supportedLocales,
      home: MainScreen(),
    );
  }
}

class MainScreen extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Weather Demo",
          style: TextStyle(color: Colors.black87),
        ),
        backgroundColor: Colors.white,
        iconTheme: IconThemeData(color: Colors.black54),
        brightness: Brightness.light,
        actions: <Widget>[
          Builder(
            builder: (BuildContext context) {
              return
                IconButton(
                icon: Icon(Icons.settings),
                onPressed: () {
                  final snackBar = SnackBar(
                    content:
                    Text(S.of(context).feature_is_under_construction),
                  );
                  Scaffold.of(context).showSnackBar(snackBar);
                },
              );
            },
          ),
        ],
      ),
      drawer: Drawer(
        child: ListView(
          padding: EdgeInsets.zero,
          children: <Widget>[
            DrawerHeader(
              child: Text(''),
              decoration: BoxDecoration(color: Colors.grey),
            ),
            ListTile(
              title: Text(
                S.of(context).about_screen,
                style: TextStyle(fontSize: 16),
              ),
              onTap: () {
                String someText = S.of(context).you_are_on_about_screen;  //просто посмотреть, как передаются данные
                Navigator.pop(context);
                Navigator.pushNamed(context, AboutScreen.ROUTE, arguments: someText);
              },
            ),
          ],
        ),
      ),
      body: _buildBody(),
    );
  }
}

Widget _buildBody() {
  return SingleChildScrollView(
    child: Column(
      children: <Widget>[
        _headerImage(),
        SafeArea(
          child: Padding(
            padding: EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: <Widget>[
                _weatherDescription(),
                Divider(),
                WeatherWidget(CitiesUtils.getCityId(City.MOSCOW)),
              ],
            ),
          ),
        ),
      ],
    ),
  );
}

CachedNetworkImage _headerImage() {
  return CachedNetworkImage(
    placeholder: (context, url) => CircularProgressIndicator(),
    imageUrl: 'https://s1.1zoom.ru/b5050/186/381853-svetik_1366x768.jpg',
    fit: BoxFit.cover,
  );
}

Column _weatherDescription() {
  return Column(
    crossAxisAlignment: CrossAxisAlignment.center,
    children: <Widget>[
      DateWidget(
        addWeekday: true,
      ),
      Divider(),
      Text(
        'Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat.',
        style: TextStyle(color: Colors.black54),
      )
    ],
  );
}
