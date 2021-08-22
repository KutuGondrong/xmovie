import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';
import 'movie.dart';

part 'movies.g.dart';

@JsonSerializable()
class Movies extends Equatable{

  @JsonKey(name: 'results')
  final List<Movie> movies;

  const Movies([this.movies = const[]]);

  @override
  List<Object> get props => [movies];

  factory Movies.fromJson(Map<String, dynamic> json) => _$MoviesFromJson(json);

  Map<String, dynamic> toJson() => _$MoviesToJson(this);
}