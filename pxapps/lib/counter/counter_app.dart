import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

//import my pxblocs library 
import 'package:pxblocs/counter/index.dart';

//import packages in own package
import 'package:pxapps/common/index.dart';

import 'package:pxapps/counter/counter_pages.dart';

class CounterApp extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _CounterAppState();
}

class _CounterAppState extends State<CounterApp> {
  final CounterBloc _counterBloc = CounterBloc();
  final ThemeToggleBloc _themeBloc = ThemeToggleBloc();

  @override
  Widget build(BuildContext context) {
    return BlocProviderTree(
      blocProviders: [
        BlocProvider<CounterBloc>(bloc: _counterBloc),
        BlocProvider<ThemeToggleBloc>(bloc: _themeBloc)
      ],
      child: BlocBuilder(
        bloc: _themeBloc,
        builder: (_, ThemeData theme) {
          return MaterialApp(
            title: 'BloC-based Counter App',
            home: CounterPage(),
            theme: theme,
          );
        },
      ),
    );
  }

  @override
  void dispose() {
    _counterBloc.dispose();
    _themeBloc.dispose();
    super.dispose();
  }
}



