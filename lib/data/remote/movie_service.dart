import 'package:dio/dio.dart';
import 'package:retrofit/retrofit.dart';
import 'package:xmovie/data/response/movies.dart';

part 'movie_service.g.dart';

@RestApi(baseUrl : "http://api.themoviedb.org/3/")
abstract class MovieService {
  factory MovieService(Dio dio, {String baseUrl}) = _MovieService;

  @GET("search/movie")
  Future<Movies> searchMovie(@Query("api_key") String apiKey,
      @Query("query") String query,
      @Query("page") int page);

}