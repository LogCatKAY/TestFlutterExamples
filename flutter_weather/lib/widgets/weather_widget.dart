import 'package:flutter/material.dart';
import 'package:flutterweather/weather_network/pojo/weather_forecast.dart';
import 'package:flutterweather/weather_network/weather_api_client.dart';
import 'package:flutterweather/weather_network/weather_utils.dart';
import 'package:intl/intl.dart';

final String apiCall = 'https://www.metaweather.com/api/location/2122265/';

final String sampleAnswer = '''
{"consolidated_weather":[{"id":5752171498831872,"weather_state_name":"Heavy Rain","weather_state_abbr":"hr","wind_direction_compass":"SW","created":"2020-04-01T12:27:31.736709Z","applicable_date":"2020-04-01","min_temp":-3.27,"max_temp":2.01,"the_temp":2.11,"wind_speed":6.84764866201649,"wind_direction":235.34412982709168,"air_pressure":1006.5,"humidity":68,"visibility":14.248973494790423,"predictability":77},{"id":4754533978734592,"weather_state_name":"Heavy Rain","weather_state_abbr":"hr","wind_direction_compass":"WSW","created":"2020-04-01T12:27:33.954009Z","applicable_date":"2020-04-02","min_temp":0.635,"max_temp":4.0600000000000005,"the_temp":4.68,"wind_speed":6.66834161934834,"wind_direction":249.16256328730293,"air_pressure":1002.0,"humidity":75,"visibility":8.379501212916567,"predictability":77},{"id":5760918669492224,"weather_state_name":"Heavy Cloud","weather_state_abbr":"hc","wind_direction_compass":"SW","created":"2020-04-01T12:27:37.352039Z","applicable_date":"2020-04-03","min_temp":0.7549999999999999,"max_temp":7.465,"the_temp":7.57,"wind_speed":8.229367443778997,"wind_direction":221.66619627955163,"air_pressure":1003.0,"humidity":62,"visibility":13.477230474031655,"predictability":71},{"id":5436786077597696,"weather_state_name":"Heavy Cloud","weather_state_abbr":"hc","wind_direction_compass":"WSW","created":"2020-04-01T12:27:40.149432Z","applicable_date":"2020-04-04","min_temp":1.1099999999999999,"max_temp":7.234999999999999,"the_temp":7.49,"wind_speed":5.866026753328561,"wind_direction":251.16710657079534,"air_pressure":1012.0,"humidity":57,"visibility":12.572824703730214,"predictability":71},{"id":5781399053271040,"weather_state_name":"Hail","weather_state_abbr":"h","wind_direction_compass":"NW","created":"2020-04-01T12:27:43.509628Z","applicable_date":"2020-04-05","min_temp":-1.23,"max_temp":4.49,"the_temp":4.755,"wind_speed":7.037994175818553,"wind_direction":312.03334182965807,"air_pressure":1023.0,"humidity":57,"visibility":13.085145251729898,"predictability":82},{"id":6315121452253184,"weather_state_name":"Light Cloud","weather_state_abbr":"lc","wind_direction_compass":"NNW","created":"2020-04-01T12:27:46.108750Z","applicable_date":"2020-04-06","min_temp":-1.255,"max_temp":6.695,"the_temp":3.24,"wind_speed":8.366587329992843,"wind_direction":328.5,"air_pressure":1038.0,"humidity":53,"visibility":9.999726596675416,"predictability":70}],"time":"2020-04-01T17:14:41.134039+03:00","sun_rise":"2020-04-01T05:59:43.730122+03:00","sun_set":"2020-04-01T19:08:08.798872+03:00","timezone_name":"LMT","parent":{"title":"Russia","location_type":"Country","woeid":23424936,"latt_long":"59.453751,108.830719"},"sources":[{"title":"BBC","slug":"bbc","url":"http://www.bbc.co.uk/weather/","crawl_rate":360},{"title":"Forecast.io","slug":"forecast-io","url":"http://forecast.io/","crawl_rate":480},{"title":"HAMweather","slug":"hamweather","url":"http://www.hamweather.com/","crawl_rate":360},{"title":"Met Office","slug":"met-office","url":"http://www.metoffice.gov.uk/","crawl_rate":180},{"title":"OpenWeatherMap","slug":"openweathermap","url":"http://openweathermap.org/","crawl_rate":360},{"title":"Weather Underground","slug":"wunderground","url":"https://www.wunderground.com/?apiref=fc30dc3cd224e19b","crawl_rate":720},{"title":"World Weather Online","slug":"world-weather-online","url":"http://www.worldweatheronline.com/","crawl_rate":360}],"title":"Moscow","location_type":"City","woeid":2122265,"latt_long":"55.756950,37.614971","timezone":"Europe/Moscow"}
''';

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
