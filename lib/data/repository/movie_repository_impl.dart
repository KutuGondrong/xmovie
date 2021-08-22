import 'package:xmovie/data/remote/movie_service.dart';
import 'package:xmovie/data/remote/movie_service_client.dart';
import 'package:xmovie/data/response/movies.dart';

import 'movie_repository.dart';

class MovieRepositoryImpl extends MovieRepository {

  late MovieService _service;
  var apiKey = "6753d9119b9627493ae129f3c3c99151";

  MovieRepositoryImpl() {
    _service = MovieServiceClient().getService();
  }

  @override
  Future<Movies>? searchMovie(String query, int page) {
    return _service.searchMovie(apiKey, query, page);
  }

}