import 'package:app_weather/models/forecast.dart';
import 'package:app_weather/models/location.dart';

abstract class WeatherApi {
  Future<Forecast> getWeather(Location location);
  Future<Location> getLocation(String city);
}