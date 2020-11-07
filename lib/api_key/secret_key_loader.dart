import 'dart:convert' as convert;
import 'package:flutter/services.dart' show rootBundle;

/*
    assets/secrets.json:
    {
      "open_weather_map_api_key": "API_KEY"
    }
 */
Future<String> getKeyFromAssets(String secretPath, String keyName) async {
  return rootBundle.loadStructuredData<String>(
      secretPath,
      (String json) async {
        final Map<String, dynamic> mapFromJson = convert.jsonDecode(json);
        return mapFromJson[keyName];
      });
}