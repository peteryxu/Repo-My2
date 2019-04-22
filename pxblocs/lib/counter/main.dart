import 'dart:async';
import 'package:bloc/bloc.dart';
import 'package:pxblocs/common/util.dart';
import 'index.dart';

void main() {
  BlocSupervisor().delegate = SimpleBlocDelegate();

  final counterBloc = CounterBloc();
  var sum = subStream(counterBloc.state);

  counterBloc.dispatch(CounterEvent.increment);
  counterBloc.dispatch(CounterEvent.increment);
  counterBloc.dispatch(CounterEvent.increment);

  counterBloc.dispatch(CounterEvent.decrement);
  counterBloc.dispatch(CounterEvent.decrement);
  counterBloc.dispatch(CounterEvent.decrement);

  counterBloc.dispatch(null); // Triggers Exception
  // The exception triggers `SimpleBlocDelegate.onError` but does not impact bloc functionality.
  counterBloc.dispatch(CounterEvent.increment);
  counterBloc.dispatch(CounterEvent.decrement);
  
  
}

Future<int> subStream(Stream<int> stream) async {
  var sum = 0;
  await for (var value in stream) {
    print("###got current stream data: $value");
    sum += value;
  }
  print(sum);
  return sum;
}