import 'dart:async';
import 'package:bloc/bloc.dart';
import 'index.dart';
import 'package:pxrepos/todos/corerepo/index.dart';

class TabBloc extends Bloc<TabEvent, AppTab> {
  @override
  AppTab get initialState => AppTab.todos;

  @override
  Stream<AppTab> mapEventToState(TabEvent event) async* {
    if (event is UpdateTab) {
      yield event.tab;
    }
  }
}
