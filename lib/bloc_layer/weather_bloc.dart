import 'dart:async';
import 'package:flutter/widgets.dart';
import 'package:weather_app/api_key/secret_key_loader.dart';
import 'package:weather_app/bloc_layer/bloc.dart';
import 'package:weather_app/data_layer/geographic_coordinates.dart';
import 'package:weather_app/data_layer/weather.dart';
import 'package:weather_app/repositories/open_weather_map_repository.dart';
import 'package:weather_app/repositories/weather_repository.dart';

/// A {BLoC} subclass.
class WeatherBLoC implements BLoC {

  // FIELDS --------------------------------------------------------------------

  final WeatherRepository _repository = OpenWeatherMapRepository();

  Weather _weather;
  Weather get lastWeather => _weather;

  final _controller = StreamController<Weather>();
  Stream<Weather> get weatherStream => _controller.stream;

  // METHODS -------------------------------------------------------------------

  // -- BLoC --

  @override
  void dispose() => _controller.close();

  // -- StreamController --

  void submitQueryToWeather(
    GeographicCoordinates location, BuildContext context
  ) async {
    final weather = await _repository.getWeather(
        latitude: location.latitude,
        longitude: location.longitude,
        lang: Localizations.localeOf(context).languageCode,
        key: await getKeyFromAssets(
            'assets/secrets.json', 'open_weather_map_api_key'));

    _controller.sink.add(weather);
  }
}