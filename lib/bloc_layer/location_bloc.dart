import 'dart:async';
import 'package:location/location.dart';
import 'package:weather_app/bloc_layer/bloc.dart';
import 'package:weather_app/data_layer/geographic_coordinates.dart';

/// A {BLoC} subclass.
class LocationBLoC extends BLoC {

  // FIELDS --------------------------------------------------------------------

  final _location = Location();

  GeographicCoordinates _geographicCoordinates;
  GeographicCoordinates get currentLocation => _geographicCoordinates;

  final _controller = StreamController<GeographicCoordinates>();
  Stream<GeographicCoordinates> get locationStream => _controller.stream;

  // CONSTRUCTORS --------------------------------------------------------------

  LocationBLoC() {
    _configureUserLocation();
  }

  // METHODS -------------------------------------------------------------------

  // -- BLoC --

  @override
  void dispose() => _controller.close();

  // -- StreamController --

  void _setLocation(GeographicCoordinates location) {
    _geographicCoordinates = location;
    _controller.sink.add(location);
  }

  // -- Location --

  void _configureUserLocation() async {
    // Service enable
    bool serviceEnabled = await _location.serviceEnabled();
    if (!serviceEnabled) {
      serviceEnabled = await _location.requestService();
      if (!serviceEnabled) return;
    }

    // Location permission
    PermissionStatus permissionStatus = await _location.hasPermission();
    if (permissionStatus == PermissionStatus.denied) {
      permissionStatus = await _location.requestPermission();
      if (permissionStatus != PermissionStatus.granted) return;
    }

    _getFirstLocation();
    _generateContinuousCallbackOnLocation();
  }

  void _getFirstLocation() async {
    try {
      final location = await _location.getLocation();
      _setLocation(
          GeographicCoordinates(location.latitude, location.longitude));
    } catch(e) {
      print('error with first location: $e');
    }
  }

  void _generateContinuousCallbackOnLocation() {
    _location.onLocationChanged.listen((LocationData location) {
      // Same location
      if (location.latitude == _geographicCoordinates.latitude &&
          location.longitude == _geographicCoordinates.longitude) return;

      _setLocation(
          GeographicCoordinates(location.latitude, location.longitude));
    });
  }
}