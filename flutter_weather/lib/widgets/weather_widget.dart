import 'package:flutter/material.dart';
import 'package:flutterweather/weather_network/pojo/weather_forecast.dart';
import 'package:flutterweather/weather_network/weather_api_client.dart';
import 'package:flutterweather/weather_network/weather_utils.dart';
import 'package:intl/intl.dart';


class WeatherWidget extends StatefulWidget {
  int _cityId;

  int get cityId => _cityId;

  WeatherWidget(this._cityId);

  @override
  State createState() => _WeatherWidgetState(cityId);
}

class _WeatherWidgetState extends State<WeatherWidget> {
  int _cityId;
  Future<WeatherForecast> _fiveDaysWeather;
  WeatherApiClient _api;

  _WeatherWidgetState(this._cityId) {
    this._api = WeatherApiClient(_cityId);
  }

  @override
  void initState() {
    super.initState();
    _fiveDaysWeather = _api
        .getWeatherForecast(); //если поместить в build, то может быть частый вызов
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<WeatherForecast>(
      future: _fiveDaysWeather,
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          List<AssetImage> weatherStates =
              WeatherUtils.getWeatherImagesFromWeather(snapshot.data);
          List<int> weatherTemperature =
              WeatherUtils.getForecastTemperature(snapshot.data);
          List<DateTime> dateTime =
              WeatherUtils.getDateTimeFromForecast(snapshot.data);
          String cityName = snapshot.data.title;

          if (weatherStates.length > 0 && weatherTemperature.length > 0) {
            return Column(
              children: <Widget>[
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        Image(
                          image: weatherStates[0],
                          width: 36,
                          height: 36,
                        ),
                      ],
                    ),
                    SizedBox(
                      width: 16.0,
                    ),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        Row(
                          children: <Widget>[
                            Text(
                              '${weatherTemperature[0]}° ${snapshot.data.consolidatedWeather[0].weatherStateName}',
                              style: TextStyle(color: Colors.deepPurple),
                            )
                          ],
                        ),
                        Row(
                          children: <Widget>[
                            Text(
                              cityName,
                              style: TextStyle(color: Colors.grey),
                            )
                          ],
                        ),
                      ],
                    ),
                  ],
                ),
                Divider(),
                _nextWeather(weatherStates, weatherTemperature, dateTime),
              ],
            );
          } else {
            return Text('Error parsing json');
          }
        } else if (snapshot.hasError) {
          return Text(snapshot.error.toString());
        } else {
          return CircularProgressIndicator();
        }
      },
    );
  }

  Wrap _nextWeather(List<AssetImage> assetImages, List<int> temperatures,
      List<DateTime> dateTime) {
    if (assetImages.length > 0) {
      assetImages.removeAt(0);                                      // первый элемент уже отображен
      if(assetImages.length > 0 && assetImages.length % 4 != 0) {   // просто для красоты
        while(assetImages.length % 4 != 0) {
          assetImages.removeLast();
        }
      }
    }
    if (temperatures.length > 0) {
      temperatures.removeAt(0);
      if(temperatures.length > 0 && temperatures.length % 4 != 0) {
        while(temperatures.length % 4 != 0) {
          temperatures.removeLast();
        }
      }
    }
    if (dateTime.length > 0) {
      dateTime.removeAt(0);
      if(dateTime.length > 0 && dateTime.length % 4 != 0) {
        while(dateTime.length % 4 != 0) {
          dateTime.removeLast();
        }
      }
    }
    if ((assetImages.length == temperatures.length) &&
        (assetImages.length == dateTime.length)) {
      return Wrap(
        spacing: 10.0,
        children: List.generate(assetImages.length, (int index) {
          return Column(
            children: <Widget>[
              Text('${DateFormat.MMM().add_d().format(dateTime[index])}'),
              Chip(
                avatar: ImageIcon(assetImages[index]),
                label: Text(
                  '${temperatures[index]}°',
                  style: TextStyle(fontSize: 15.0),
                ),
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(4.0),
                    side: BorderSide(color: Colors.grey)),
                backgroundColor: Colors.grey.shade100,
              )
            ],
          );
        }),
      );
    } else {
      return Wrap(
        spacing: 1.0,
        children: <Widget>[
          Text('images.length != temp.length'),
        ],
      );
    }
  }
}
