import 'package:flutter/material.dart';
import 'package:weather_app/bloc_layer/bloc.dart';

/// A [StatefulWidget] subclass.
class BLoCProvider<T extends BLoC> extends StatefulWidget {

  // FIELDS --------------------------------------------------------------------

  final Widget child;
  final T bloc;

  // CONSTRUCTORS --------------------------------------------------------------

  const BLoCProvider({Key key, @required this.bloc, @required this.child})
      : super(key: key);

  // METHODS -------------------------------------------------------------------

  @override
  _BLoCProviderState createState() => _BLoCProviderState();

  // -- BLoC --

  static T of<T extends BLoC>(BuildContext context) {
    final BLoCProvider<T> provider = context.findAncestorWidgetOfExactType<BLoCProvider<T>>();
    return provider.bloc;
  }
}

/// A [State] of [BLoCProvider] subclass.
class _BLoCProviderState extends State<BLoCProvider> {
  @override
  Widget build(BuildContext context) => widget.child;

  @override
  void dispose() {
    widget.bloc.dispose();
    super.dispose();
  }
}