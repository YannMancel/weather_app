import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:weather_app/ui_layer/main_screen.dart';

void main() {
  // To avoid an error with the package:location
  WidgetsFlutterBinding.ensureInitialized();

  // Just in Portrait mode
  SystemChrome.setPreferredOrientations(
      [DeviceOrientation.portraitUp, DeviceOrientation.portraitDown]);

  runApp(MainScreen());
}