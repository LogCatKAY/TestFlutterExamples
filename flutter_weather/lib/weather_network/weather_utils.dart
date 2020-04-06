import 'package:flutter/material.dart';
import 'package:flutterweather/weather_network/pojo/weather_forecast.dart';

class WeatherUtils {
  static AssetImage getWeatherImageFromJsonField(String jsonField) {
    String assetName = jsonField.replaceAll(' ', '_').toLowerCase();
    return AssetImage("assets/images/weather_states/$assetName.png");
  }

  static List<AssetImage> getWeatherImagesFromWeather(
      WeatherForecast fiveDaysWeather) {
    return fiveDaysWeather.consolidatedWeather
        .map(
            (weather) => getWeatherImageFromJsonField(weather.weatherStateName))
        .toList();
  }

  static int getWeatherTempFromConsolidatedWeather(
      ConsolidatedWeather consolidatedWeather) {
    double min = consolidatedWeather.minTemp;
    double max = consolidatedWeather.maxTemp;
    return ((min + max) / 2).round();
  }

  static List<int> getForecastTemperature(WeatherForecast weatherForecast) {
    return weatherForecast.consolidatedWeather
        .map((weather) => getWeatherTempFromConsolidatedWeather(weather))
        .toList();
  }

  static List<DateTime> getDateTimeFromForecast(
      WeatherForecast weatherForecast) {
    return weatherForecast.consolidatedWeather
        .map((weather) => DateTime.parse(weather.applicableDate))
        .toList();
  }
}
