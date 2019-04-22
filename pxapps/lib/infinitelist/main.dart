import 'package:flutter/material.dart';
import 'package:bloc/bloc.dart';
import 'package:pxblocs/common/index.dart';

import 'package:pxapps/infinitelist/post_app.dart';


void main() {
  BlocSupervisor().delegate = SimpleBlocDelegate();
  runApp(InfiniteListApp());
}
