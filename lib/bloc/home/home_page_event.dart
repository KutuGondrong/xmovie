import 'package:equatable/equatable.dart';

abstract class HomePageEvent extends Equatable {

  @override
  List<Object> get props => [];

}

class SearchMoviesEvent extends HomePageEvent {
  final String query;
  final bool isLoadMore;
  SearchMoviesEvent({required this.query, required this.isLoadMore});

}