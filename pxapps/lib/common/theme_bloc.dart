import 'package:flutter/material.dart';
import 'package:bloc/bloc.dart';

enum ThemeToggleEvent { toggle }

class ThemeToggleBloc extends Bloc<ThemeToggleEvent, ThemeData> {
  @override
  ThemeData get initialState => ThemeData.light();

  @override
 Stream<ThemeData> mapEventToState( ThemeToggleEvent event) async* {
    switch (event) {
      case ThemeToggleEvent.toggle:
        yield currentState == ThemeData.dark()
            ? ThemeData.light()
            : ThemeData.dark();
        break;
    }
  }


  

}
