import 'package:bloc_test/bloc_test.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:xmovie/bloc/home/home_page_bloc.dart';
import 'package:xmovie/bloc/home/home_page_event.dart';
import 'package:xmovie/bloc/home/home_page_state.dart';
import 'package:xmovie/data/repository/movie_repository.dart';
import 'package:xmovie/data/repository/movie_repository_impl.dart';
import 'package:xmovie/data/response/movie.dart';
import 'package:xmovie/data/response/movies.dart';

class MockMovieRepository extends Mock implements MovieRepositoryImpl {}

void main() {
  group('HomePageBloc', () {
    late MovieRepository movieRepository;
    late HomePageBloc homePageBloc;
    Movies fakeMovies = Movies([
      Movie(
          1 ,"title", "path", "releaseDate", "description"
      )
    ]);
    Exception fakeException = Exception("Error get Data");
    setUp(() {
      movieRepository = MockMovieRepository();
      homePageBloc = HomePageBloc(repository: movieRepository);
    });

    group('SearchMovie', () {
      blocTest(
          'emits [LoadingMoviesState, SuccessMoviesState] '
              'when success get data',
          build: () {
            when(movieRepository.searchMovie("superman", 1)).thenAnswer(
                (_) async =>
                Future.value(
                    fakeMovies
                )
            );
            return homePageBloc;
          },

          act: (HomePageBloc bloc) =>
              bloc.add(SearchMoviesEvent(query: "superman", isLoadMore: false)),
          expect: () =>
          [
            LoadingMoviesState(),
            SuccessMoviesState(
              movies: fakeMovies.movies
            ),
          ]
      );

      blocTest(
          'emits [LoadingMoviesState, ErrorMoviesState] '
              'when error get data',
          build: () {
            when(movieRepository.searchMovie("", 1)).thenThrow(
                fakeException
            );
            return homePageBloc;
          },

          act: (HomePageBloc bloc) {
            bloc.page = 1;
            bloc.add(SearchMoviesEvent(query: "", isLoadMore: false));
          },

          expect: () =>
          [
            LoadingMoviesState(),
            ErrorMoviesState(errorMessage: fakeException.toString()),
          ]
      );

      blocTest(
          'emits [LoadMoreLoadingMoviesState, SuccessMoviesState] '
              'when Load more data',
          build: () {
            when(movieRepository.searchMovie("searchLoadMore", 2)).thenAnswer(
                    (_) async =>
                    Future.value(
                        fakeMovies
                    )
            );
            return homePageBloc;
          },

          act: (HomePageBloc bloc) {
            bloc.page = 2;
            bloc.add(SearchMoviesEvent(query: "searchLoadMore", isLoadMore: true));
          },

          expect: () =>
          [
            LoadMoreLoadingMoviesState(),
            SuccessMoviesState(
                movies: fakeMovies.movies
            ),
          ]
      );

    });

  });
}