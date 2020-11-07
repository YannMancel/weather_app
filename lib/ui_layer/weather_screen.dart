import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:weather_app/bloc_layer/location_bloc.dart';
import 'package:weather_app/bloc_layer/weather_bloc.dart';
import 'package:weather_app/data_layer/geographic_coordinates.dart';
import 'package:weather_app/data_layer/weather.dart';

/// A {StatelessWidget} subclass.
class WeatherScreen extends StatefulWidget {
  final String title;

  WeatherScreen({Key key, this.title}) : super(key: key);

  @override
  _WeatherScreenState createState() => _WeatherScreenState();
}

/// A {State<WeatherScreen>} subclass.
class _WeatherScreenState extends State<WeatherScreen> {

  // -- METHODS ----------------------------------------------------------------

  // -- StatelessWidget --

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(title: Text(widget.title)),
        drawer: _getDrawer(),
        body: Provider<WeatherBLoC>(
            create: (_) => WeatherBLoC(),
            dispose: (_, WeatherBLoC bloc) => bloc.dispose(),
            child: Center(
                child: _buildWidgetAccordingToLocation())));
  }

  // -- UI --

  Widget _getDrawer() {
    return Drawer(
        child: ListView(padding: EdgeInsets.zero, children: [
          const DrawerHeader(
              decoration: const BoxDecoration(
                  gradient: const LinearGradient(
                      colors: [Colors.deepPurple, Colors.purpleAccent])),
              child: Center(
                  child: const Text('WEATHER',
                      style: TextStyle(color: Colors.white, fontSize: 20.0)))),
          ListTile(
              leading: const Icon(Icons.wb_cloudy),
              title: const Text('Weather'),
              onTap: () => Navigator.pop(context))
       ]));
  }

  Widget _buildWidgetAccordingToLocation() {
    return Consumer<LocationBLoC>(builder: (_, locationBLoC, __) =>
        StreamBuilder<GeographicCoordinates> (
            stream: locationBLoC.locationStream,
            builder: (context, snapshot) {
              if (snapshot.hasData) {
                final currentLocation = snapshot.data;
                final weatherBLoC = Provider.of<WeatherBLoC>(context);
                weatherBLoC.submitQueryToWeather(currentLocation, context);
                return _buildWidgetAccordingToWeather();
              }
              return const Text('No data of location');
            }
        ));
  }

  Widget _buildWidgetAccordingToWeather() {
    return Consumer<WeatherBLoC>(builder: (_, weatherBLoC, __) =>
        StreamBuilder<Weather> (
            stream: weatherBLoC.weatherStream,
            builder: (_, snapshot) {
              if (snapshot.hasData) {
                final weather = snapshot.data;
                return Column(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      _getTextWithStyle(weather.name, fontSize: 20.0),
                      weather.iconWeather,
                      _getTextWithStyle(
                          '${weather.temperature.toString()}°C',
                          fontSize: 30.0)
                    ]);
              }
              return const Text('No data of weather');
            }
        ));
  }

  Widget _getTextWithStyle(String data, {double fontSize = 12.0}) =>
    Text(data, style: TextStyle(fontSize: fontSize));
}