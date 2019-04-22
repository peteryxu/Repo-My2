import 'dart:async';
import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';
import 'package:bloc/bloc.dart';


class Ticker {
  Stream<int> tick() {
    return Stream.periodic(Duration(seconds: 1), (x) => x).take(10);
  } 
}

@immutable
abstract class TickerState extends Equatable {
  TickerState([List props = const []]) : super(props);
}

class Initial extends TickerState {}

class Update extends TickerState {
  final int count;

  Update(this.count) : super([count]);
}

@immutable
abstract class TickerEvent extends Equatable {
  TickerEvent([List props = const []]) : super(props);
}

class StartTicker extends TickerEvent {}

class Tick extends TickerEvent {
  final int tickCount;

  Tick(this.tickCount) : super([tickCount]);

  @override
  String toString() => 'Tick $tickCount';
}

class TickerBloc extends Bloc<TickerEvent, TickerState> {
  final Ticker ticker;
  StreamSubscription subscription;

  TickerBloc(this.ticker);

  @override
  TickerState get initialState => Initial();

  @override
  Stream<TickerState> mapEventToState(TickerEvent event) async* {
    if (event is StartTicker) {
      subscription?.cancel();
      subscription = ticker.tick().listen((tick) => dispatch(Tick(tick)));
    }
    if (event is Tick) {
      yield Update(event.tickCount);
    }
  }

  @override
  void dispose() {
    subscription.cancel();
    super.dispose();
  }
}



