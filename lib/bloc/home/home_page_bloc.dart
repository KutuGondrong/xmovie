import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:xmovie/data/repository/movie_repository.dart';
import 'package:xmovie/data/response/movies.dart';

import 'home_page_event.dart';
import 'home_page_state.dart';

class HomePageBloc
    extends Bloc<HomePageEvent, HomePageState> {
  final MovieRepository repository;
  int page = 1;
  bool isFetching = false;

  HomePageBloc({required this.repository})
      : super(InitialMoviesState());

  @override
  Stream<HomePageState> mapEventToState(HomePageEvent event) async* {
    if (event is SearchMoviesEvent) {
      try {
        if (event.isLoadMore) {
          yield LoadMoreLoadingMoviesState();
        } else {
          yield LoadingMoviesState();
        }
        Movies? response = await repository.searchMovie(event.query, page);
        if(response!.movies.isNotEmpty) {
          page++;
        }

        yield SuccessMoviesState(movies: response.movies);
      } catch (e) {
        yield ErrorMoviesState(errorMessage: e.toString());
      }
    }
  }
}
