import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:weather_app/bloc_layer/location_bloc.dart';
import 'package:weather_app/ui_layer/weather_screen.dart';

/// A {StatelessWidget} subclass.
class MainScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        title: 'Weather App',
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
            primarySwatch: Colors.deepPurple,
            visualDensity: VisualDensity.adaptivePlatformDensity),
        home: Provider<LocationBLoC>(
            create: (_) => LocationBLoC(),
            dispose: (_, LocationBLoC bloc) => bloc.dispose(),
            lazy: false,
            child: WeatherScreen(title: 'Weather')));
  }
}