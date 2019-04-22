import 'package:flutter/material.dart';

import 'package:http/http.dart' as http;
import 'package:bloc/bloc.dart';
import 'package:flutter_bloc/flutter_bloc.dart';


import './widgets/index.dart';
import '../common/weather_theme_bloc.dart';

import 'package:pxrepos/weather/index.dart';
import 'package:pxblocs/weather/index.dart';
import 'package:pxblocs/common/index.dart';

void main() {
  final WeatherRepository weatherRepository = WeatherRepository(
    weatherApiClient: WeatherApiClient(
      httpClient: http.Client(),
    ),
  );

  BlocSupervisor().delegate = SimpleBlocDelegate();
  runApp(App(weatherRepository: weatherRepository));
}

class App extends StatefulWidget {
  final WeatherRepository weatherRepository;

  App({Key key, @required this.weatherRepository})
      : assert(weatherRepository != null),
        super(key: key);

  @override
  State<App> createState() => _AppState();
}

class _AppState extends State<App> {
  ThemeBloc _themeBloc = ThemeBloc();
  SettingsBloc _settingsBloc = SettingsBloc();

  @override
  Widget build(BuildContext context) {
    return BlocProviderTree(
      blocProviders: [
        BlocProvider<ThemeBloc>(bloc: _themeBloc),
        BlocProvider<SettingsBloc>(bloc: _settingsBloc),
      ],
      child: BlocBuilder(
        bloc: _themeBloc,
        builder: (_, ThemeState themeState) {
          return MaterialApp(
            title: 'Flutter Weather',
            theme: themeState.theme,
            home: Weather(
              weatherRepository: widget.weatherRepository,
            ),
          );
        },
      ),
    );
  }

  @override
  void dispose() {
    _themeBloc.dispose();
    _settingsBloc.dispose();
    super.dispose();
  }
}