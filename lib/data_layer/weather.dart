import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:weather_app/icons/icon_manager.dart';

class Weather {

  // FIELDS --------------------------------------------------------------------

  String name;
  String mainWeather;
  String descriptionWeather;
  Widget iconWeather;
  var temperature;
  var pressure;
  var humidity;

  // CONSTRUCTORS --------------------------------------------------------------

  Weather(Map<String, dynamic> mapFromJson) {
    // Name
    name = mapFromJson['name'];

    // Main Weather
    final Map<String, dynamic> weather =
        (mapFromJson['weather'] as List<dynamic>).first;
    mainWeather = weather['main'];
    descriptionWeather = weather['description'];
    iconWeather = _getIcon(weather['icon']);

    // Temperature, Pressure & Humidity
    final Map<String, dynamic> conditions = mapFromJson['main'];
    temperature = conditions['temp'];
    pressure = conditions['pressure'];
    humidity = conditions['humidity'];
  }

  // METHODS -------------------------------------------------------------------

  Widget _getIcon(
    String iconName,
    {Color color = Colors.deepPurple, double size = 200.0}
  ) {
    IconData icon;
    switch (iconName) {
    // Clear sky
      case '01d':
        icon = IconManager.sun;
        break;
      case '01n':
        icon = IconManager.moon;
        break;

    // Few clouds
      case '02d':
      case '02n':
        icon = IconManager.cloud_sun;
        break;

    // Scattered clouds & Broken clouds
      case '03d':
      case '03n':
      case '04d':
      case '04n':
        icon = IconManager.cloud;
        break;

    // Shower rain
      case '09d':
      case '09n':
        icon = IconManager.rain;
        break;

    // Rain
      case '10d':
      case '10n':
        icon = IconManager.drizzle;
        break;

    // Thunderstorm
      case '11d':
      case '11n':
        icon = IconManager.cloud_flash;
        break;

    // Snow
      case '13d':
      case '13n':
        icon = IconManager.snow;
        break;

    // Mist
      case '50d':
      case '50n':
        icon = IconManager.cloud_wind;
        break;

      default: icon = Icons.autorenew;
    }

    return Icon(icon, color: color, size: size);
  }
}