import 'dart:core';

import 'package:app_weather/api/openweathermap_weather_api.dart';
import 'package:app_weather/models/forecast.dart';
import 'package:app_weather/models/weather.dart';
import 'package:app_weather/services/forecast_service.dart';
import 'package:app_weather/utils/weather_app_utils_strings.dart';
import 'package:app_weather/utils/weather_app_utils_temperature_convert.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';

class ForecastViewModel with ChangeNotifier {
  bool isRequestPending = false;
  bool isWeatherLoaded = false;
  bool isRequestError = false;

  WeatherCondition _condition;
  String _description = "";
  double _minTemp = 0.0;
  double _maxTemp = 0.0;
  double _temp = 0.0;
  double _feelsLike = 0.0;
  int _locationId = 0;
  DateTime _lastUpdated = new DateTime(2020);
  String _city = "";
  double _latitude = 0.0;
  double _longitude = 0.0;
  List<Weather> _daily = [];
  bool _isDayTime = false;

  WeatherCondition get condition => _condition;
  String get description => _description;
  double get minTemp => _minTemp;
  double get maxTemp => _maxTemp;
  double get temp => _temp;
  double get feelsLike => _feelsLike;
  int get locationId => _locationId;
  DateTime get lastUpdated => _lastUpdated;
  String get city => _city;
  double get longitude => _longitude;
  double get latitide => _latitude;
  bool get isDaytime => _isDayTime;
  List<Weather> get daily => _daily;

  ForecastService forecastService;

  ForecastViewModel() {
    forecastService = ForecastService(OpenWeatherMapWeatherApi());
  }

  Future<Forecast> getLatestWeather(String city) async {
    setRequestPendingState(true);
    this.isRequestError = false;

    Forecast latest;
    try {
      await Future.delayed(Duration(seconds: 1), () => {});

      latest = await forecastService
          .getWeather(city)
          .catchError((onError) => this.isRequestError = true);
    } catch (e) {
      this.isRequestError = true;
    }

    this.isWeatherLoaded = true;
    updateModel(latest, city);
    setRequestPendingState(false);
    notifyListeners();
    return latest;
  }

  void setRequestPendingState(bool isPending) {
    this.isRequestPending = isPending;
    notifyListeners();
  }

  void updateModel(Forecast forecast, String city) {
    if (isRequestError) return;

    _condition = forecast.current.condition;
    _city = Strings.toTitleCase(city);
    _description = Strings.toTitleCase(forecast.current.description);
    _lastUpdated = forecast.lastUpdated;
    _temp = TemperatureConvert.kelvinToCelsius(forecast.current.temp);
    _feelsLike =
        TemperatureConvert.kelvinToCelsius(forecast.current.feelLikeTemp);
    _longitude = forecast.longitude;
    _latitude = forecast.latitude;
    _daily = forecast.daily;
    _isDayTime = forecast.isDayTime;
  }
}
