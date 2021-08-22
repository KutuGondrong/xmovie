import 'package:dio/dio.dart';

import 'movie_service.dart';

class MovieServiceClient {
  late Dio _dio;
  late MovieService _service;

  MovieServiceClient() {
    _dio = Dio();
    _dio.interceptors.add(LogInterceptor(requestBody: true, responseBody: true));
    _service = MovieService(_dio);
  }

  MovieService getService() {
    return _service;
  }

}