import 'package:flutter/material.dart';
import 'package:weather_app/repositories/weather_repository.dart';

// FIELDS ----------------------------------------------------------------------

const BASE_URL = 'https://api.openweathermap.org/data/2.5/weather?';

// METHODS ---------------------------------------------------------------------

String getWeatherUrlWithGeographicCoordinates({
  @required double latitude,
  @required double longitude,
  WeatherUnits units = WeatherUnits.METRIC,
  String lang = 'en',
  @required String key
}) =>
    BASE_URL +
    'lat=$latitude&' +
    'lon=$longitude&' +
    'units=${units.toString().split('.').last.toLowerCase()}&' +
    'lang=$lang&' +
    'appid=$key';

String getIconUrlFromNetwork(String iconName) =>
    'https://openweathermap.org/img/w/$iconName.png';