import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';

part 'movie.g.dart';

@JsonSerializable()
class Movie extends Equatable{

  @JsonKey(name: 'id')
  final int id;

  @JsonKey(name: 'title')
  final String? title;

  @JsonKey(name: 'poster_path')
  final String? path;

  @JsonKey(name: 'release_date')
  final String? releaseDate;

  @JsonKey(name: 'overview')
  final String? description;

  Movie(this.id ,this.title, this.path, this.releaseDate, this.description);

  @override
  // TODO: implement props
  List<Object?> get props => [
    id,
    title,
    path,
    releaseDate,
    description
  ];

  factory Movie.fromJson(Map<String, dynamic> json) =>
      _$MovieFromJson(json);

  Map<String, dynamic> toJson() => _$MovieToJson(this);

}