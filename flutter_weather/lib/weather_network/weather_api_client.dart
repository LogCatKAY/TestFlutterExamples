import 'dart:convert';

import 'package:flutterweather/weather_network/pojo/weather_forecast.dart';
import 'package:flutterweather/weather_network/weather_api.dart';

class WeatherApiClient {

  int _cityId;
  int get cityId => _cityId;

  final WeatherApi _api = WeatherApi();

  WeatherApiClient(this._cityId);

  Future<WeatherForecast> getWeatherForecast() async {
    var response = await _api.getWeatherForecastData(_cityId);

    if(response.statusCode == 200) {
      return WeatherForecast.fromJson(json.decode(response.body));
    } else {
      throw Exception('Error: ${response.reasonPhrase}');
    }
  }
}