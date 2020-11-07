import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:weather_app/data_layer/weather.dart';
import 'package:weather_app/repositories/weather_repository.dart';
import 'package:weather_app/services/open_weather_map_service.dart';
import 'package:http/http.dart' as http;
import 'dart:convert' as convert;

/// A {WeatherRepository} subclass.
class OpenWeatherMapRepository extends WeatherRepository {

  // METHODS -------------------------------------------------------------------

  // -- WeatherRepository --

  @override
  Future<Weather> getWeather({
    @required double latitude,
    @required double longitude,
    WeatherUnits units = WeatherUnits.METRIC,
    String lang = 'en',
    @required String key
  }) async {
    final String url = getWeatherUrlWithGeographicCoordinates(
        latitude: latitude,
        longitude: longitude,
        units: units,
        lang: lang,
        key: key);

    final http.Response response = await http.get(url);

    switch(response.statusCode) {
      case 200: return Weather(convert.jsonDecode(response.body));
      default: return null;
    }
  }
}