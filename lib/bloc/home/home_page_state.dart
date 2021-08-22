import 'package:equatable/equatable.dart';
import 'package:xmovie/data/response/movie.dart';

abstract class HomePageState extends Equatable {
  const HomePageState();

  @override
  List<Object> get props => [];
}

class InitialMoviesState extends HomePageState {}

class LoadingMoviesState extends HomePageState {}

class LoadMoreLoadingMoviesState extends HomePageState {}

class ErrorMoviesState extends HomePageState {
  final String errorMessage;

  const ErrorMoviesState({this.errorMessage = "Unknown Error"});

  @override
  List<Object> get props => [errorMessage];

  @override
  String toString() =>
      'Error : $errorMessage';
}

class SuccessMoviesState extends HomePageState {
  final List<Movie> movies;

  const SuccessMoviesState({this.movies = const []});

  @override
  List<Object> get props => [movies];
}