import 'package:app_weather/screens/home/home_screen.dart';
import 'package:app_weather/viewmodels/city_entry_viewmodel.dart';
import 'package:app_weather/viewmodels/forecast_viewmodel.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(MultiProvider(providers: [
    ChangeNotifierProvider<CityEntryViewModel>(
      create: (_) => CityEntryViewModel(),
    ),
    ChangeNotifierProvider<ForecastViewModel>(
      create: (_) => ForecastViewModel(),
    ),
  ], child: MyApp()));
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Weather Provider',
      home: HomeView(),
      debugShowCheckedModeBanner: false,
    );
  }
}
