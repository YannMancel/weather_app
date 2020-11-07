import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:weather_app/data_layer/weather.dart';

// ENUMS -----------------------------------------------------------------------

enum WeatherUnits { STANDARD, METRIC, IMPERIAL }

// CLASSES ---------------------------------------------------------------------

abstract class WeatherRepository {

  // METHODS -------------------------------------------------------------------

  Future<Weather> getWeather({
    @required double latitude,
    @required double longitude,
    WeatherUnits units = WeatherUnits.METRIC,
    String lang = 'en',
    @required String key
  });
}