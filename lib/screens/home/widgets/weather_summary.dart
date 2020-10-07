import 'package:app_weather/models/weather.dart';
import 'package:app_weather/utils/images.dart';
import 'package:flutter/material.dart';

class WeatherSummary extends StatelessWidget {
  final WeatherCondition condition;
  final double temp;
  final double feelsLike;
  final bool isdayTime;

  WeatherSummary(
      {Key key,
      @required this.condition,
      @required this.temp,
      @required this.feelsLike,
      @required this.isdayTime})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Row(mainAxisAlignment: MainAxisAlignment.spaceAround, children: [
        Column(
          children: [
            Text(
              '${_formatTemperature(this.temp)}°ᶜ',
              style: TextStyle(
                fontSize: 50,
                color: Colors.white,
                fontWeight: FontWeight.w300,
              ),
            ),
            Text(
              'Feels like ${_formatTemperature(this.feelsLike)}°ᶜ',
              style: TextStyle(
                fontSize: 18,
                color: Colors.white,
                fontWeight: FontWeight.w300,
              ),
            ),
          ],
        ),
        _mapWeatherConditionToImage(this.condition, this.isdayTime),
      ]),
    );
  }

  String _formatTemperature(double t) {
    var temp = (t == null ? '' : t.round().toString());
    return temp;
  }

  Widget _mapWeatherConditionToImage(
      WeatherCondition condition, bool isDayTime) {
    Image image;
    switch (condition) {
      case WeatherCondition.thunderstorm:
        image = Image.asset(
          Images.thunderstorm,
          width: 80,
          height: 80,
        );
        break;
      case WeatherCondition.heavyCloud:
        image = Image.asset(
          Images.heavyCloud,
          width: 80,
          height: 80,
        );
        break;
      case WeatherCondition.lightCloud:
        isDayTime
            ? image = Image.asset(
                Images.lightCloud,
                width: 80,
                height: 80,
              )
            : image = Image.asset(
                Images.lightCloudNight,
                width: 80,
                height: 80,
              );
        break;
      case WeatherCondition.drizzle:
      case WeatherCondition.mist:
        image = Image.asset(
          Images.drizzle,
          width: 80,
          height: 80,
        );
        break;
      case WeatherCondition.clear:
        isDayTime
            ? image = Image.asset(
                Images.clear,
                width: 80,
                height: 80,
              )
            : image = Image.asset(
                Images.clearNight,
                width: 80,
                height: 80,
              );
        break;
      case WeatherCondition.fog:
        image = Image.asset(
          Images.fog,
          width: 80,
          height: 80,
        );
        break;
      case WeatherCondition.snow:
        image = Image.asset(
          Images.snow,
          width: 80,
          height: 80,
        );
        break;
      case WeatherCondition.rain:
        image = Image.asset(
          Images.rain,
          width: 80,
          height: 80,
        );
        break;
      case WeatherCondition.atmosphere:
        image = Image.asset(
          Images.fog,
          width: 80,
          height: 80,
        );
        break;

      default:
        image = Image.asset(
          Images.unknown,
          width: 80,
          height: 80,
        );
    }

    return Padding(padding: const EdgeInsets.only(top: 5), child: image);
  }
}
