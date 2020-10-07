import 'package:app_weather/models/weather.dart';
import 'package:app_weather/utils/images_small.dart';
import 'package:app_weather/utils/temperature_convert.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class DailySummaryView extends StatelessWidget {
  final Weather weather;

  DailySummaryView({Key key, @required this.weather})
      : assert(weather != null),
        super(key: key);

  @override
  Widget build(BuildContext context) {
    final dayOfWeek =
        toBeginningOfSentenceCase(DateFormat('EEE').format(this.weather.date));

    return Padding(
        padding: EdgeInsets.all(15),
        child: Row(
          children: [
            Column(mainAxisAlignment: MainAxisAlignment.spaceAround, children: [
              Text(
                dayOfWeek ?? '',
                textAlign: TextAlign.center,
                style: TextStyle(
                    fontSize: 18,
                    color: Colors.white,
                    fontWeight: FontWeight.w300),
              ),
              Text(
                "${TemperatureConvert.kelvinToCelsius(this.weather.temp).round().toString()}°",
                textAlign: TextAlign.center,
                style: TextStyle(
                    fontSize: 20,
                    color: Colors.white,
                    fontWeight: FontWeight.w500),
              ),
            ]),
            Padding(
                padding: EdgeInsets.only(left: 5),
                child: Container(
                    width: 42,
                    height: 42,
                    alignment: Alignment.center,
                    child: _mapWeatherConditionToImage(this.weather.condition)))
          ],
        ));
  }

  Widget _mapWeatherConditionToImage(WeatherCondition condition) {
    Image image;
    switch (condition) {
      case WeatherCondition.thunderstorm:
        image = Image.asset(ImagesSmall.thunderstorm);
        break;
      case WeatherCondition.heavyCloud:
        image = Image.asset(ImagesSmall.heavyCloud);
        break;
      case WeatherCondition.lightCloud:
        image = Image.asset(ImagesSmall.lightCloud);
        break;
      case WeatherCondition.drizzle:
      case WeatherCondition.mist:
        image = Image.asset(ImagesSmall.drizzle);
        break;
      case WeatherCondition.clear:
        image = Image.asset(ImagesSmall.clear);
        break;
      case WeatherCondition.fog:
        image = Image.asset('');
        break;
      case WeatherCondition.snow:
        image = Image.asset(ImagesSmall.fog);
        break;
      case WeatherCondition.rain:
        image = Image.asset(ImagesSmall.rain);
        break;
      case WeatherCondition.atmosphere:
        image = Image.asset(ImagesSmall.atmosphere);
        break;

      default:
        image = Image.asset(ImagesSmall.lightCloud);
    }

    return Padding(padding: const EdgeInsets.only(top: 5), child: image);
  }
}
