import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:weather_app/ui_layer/main_screen.dart';

void main() {
  // Just in Portrait mode
  WidgetsFlutterBinding.ensureInitialized();
  SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]);

  runApp(MainScreen());
}