import 'package:xmovie/data/response/movies.dart';

abstract class MovieRepository {

  Future<Movies>? searchMovie(String query, int page);

}