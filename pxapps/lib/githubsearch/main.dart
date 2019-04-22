import 'package:flutter/material.dart';

import 'package:meta/meta.dart';
import 'package:pxrepos/githubsearch/index.dart';
import './search_form.dart';

void main() {
  final GithubRepository _githubRepository = GithubRepository(
    GithubCache(),
    GithubClient(),
  );

  runApp(App(githubRepository: _githubRepository));
}

class App extends StatelessWidget {
  final GithubRepository githubRepository;

  const App({
    Key key,
    @required this.githubRepository,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Github Search',
      home: Scaffold(
        appBar: AppBar(title: Text('Github Search')),
        body: SearchForm(
          githubRepository: githubRepository,
        ),
      ),
    );
  }
}
