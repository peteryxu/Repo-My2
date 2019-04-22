import 'dart:async';

import 'package:meta/meta.dart';
import 'package:rxdart/rxdart.dart';
import 'package:bloc/bloc.dart';

import './github_search_event.dart';
import './github_search_state.dart';
import 'package:pxrepos/githubsearch/index.dart';
import 'package:pxrepos/githubsearch/models/index.dart';


class GithubSearchBloc extends Bloc<GithubSearchEvent, GithubSearchState> {
  final GithubRepository githubRepository;

  GithubSearchBloc({@required this.githubRepository});

  @override
  Stream<GithubSearchState> transform(
    Stream<GithubSearchEvent> events,
    Stream<GithubSearchState> Function(GithubSearchEvent event) next,
  ) {
    return super.transform(
      (events as Observable<GithubSearchEvent>).debounce(
        Duration(milliseconds: 500),
      ),
      next,
    );
  }

  @override
  void onTransition(
    Transition<GithubSearchEvent, GithubSearchState> transition,
  ) {
    print(transition);
  }

  @override
  GithubSearchState get initialState => SearchStateEmpty();

  @override
  Stream<GithubSearchState> mapEventToState(GithubSearchEvent event) async* {
    if (event is TextChanged) {
      final String searchTerm = event.text;
      if (searchTerm.isEmpty) {
        yield SearchStateEmpty();
      } else {
        yield SearchStateLoading();
        try {
          final results = await githubRepository.search(searchTerm);
          yield SearchStateSuccess(results.items);
        } catch (error) {
          yield error is SearchResultError
              ? SearchStateError(error.message)
              : SearchStateError('something went wrong');
        }
      }
    }
  }
}
