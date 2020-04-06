import 'package:http/http.dart' as http;

class WeatherApi {
  String _baseUrl = 'https://www.metaweather.com';
  String _locationRoute = '/api/location/';

  Future<http.Response> getWeatherForecastData(int cityId) async {
    return http.get('$_baseUrl' '$_locationRoute' '$cityId');
  }
}