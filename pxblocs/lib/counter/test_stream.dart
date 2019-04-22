// Copyright (c) 2015, the Dart project authors.
// Please see the AUTHORS file for details.
// All rights reserved. Use of this source code is governed
// by a BSD-style license that can be found in the LICENSE file.

import 'dart:async';

Future<int> subStream(Stream<int> stream) async {
  var sum = 0;
  await for (var value in stream) {
    print("###got stream data: $value");
    sum += value;
  }
  return sum;
}

Stream<int> pubStream(int to) async* {
  for (int i = 1; i <= to; i++) {
    await Future<void>.delayed(Duration(milliseconds: 1000));
    print("@@@pub stream data: $i");
    yield i;
  }
}

main(List<String> args) async {
  var stream = pubStream(int.tryParse(args[0]));
  var sum = await subStream(stream);
  print(sum); // 55
}
