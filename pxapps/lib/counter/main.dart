import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';

import 'package:pxblocs/common/index.dart';
import 'package:pxapps/counter/counter_app.dart';

void main() {
  BlocSupervisor().delegate = SimpleBlocDelegate();
  runApp(CounterApp());
}