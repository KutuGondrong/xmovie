import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:xmovie/bloc/home/home_page_bloc.dart';
import 'package:xmovie/bloc/home/home_page_event.dart';
import 'package:xmovie/bloc/home/home_page_state.dart';
import 'package:xmovie/data/response/movie.dart';
import 'package:xmovie/widgets/loading_indicator.dart';
import 'package:xmovie/widgets/movie_item_widget.dart';

class Body extends StatelessWidget {
  final List<Movie> _movies = [];
  final ScrollController _scrollController = ScrollController();

  @override
  Widget build(BuildContext context) {
    searchMoviesByQuery(context);
    return Center(
      child: BlocConsumer<HomePageBloc, HomePageState>(
        listener: (context, state) {
          if (state is ErrorMoviesState) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                content:Text(state.errorMessage),
                duration: Duration(seconds: 2),
              ),
            );
            context.read<HomePageBloc>().isFetching = false;
          }
          return;
        },
        builder: (context, state) {
          if (state is InitialMoviesState ||
              state is LoadingMoviesState && _movies.isEmpty) {
            return CircularProgressIndicator();
          } else if (state is SuccessMoviesState) {
            _movies.addAll(state.movies);
            context.read<HomePageBloc>().isFetching = false;
          } else if (state is ErrorMoviesState && _movies.isEmpty) {
            return Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                IconButton(
                  onPressed: () {
                    searchMoviesByQuery(context, isFetching: true);
                  },
                  icon: Icon(Icons.refresh),
                ),
                const SizedBox(height: 15),
                Text(state.errorMessage, textAlign: TextAlign.center),
              ],
            );
          }
          return ListView.separated(
            controller: _scrollController
              ..addListener(() {
                if (_scrollController.offset ==
                    _scrollController.position.maxScrollExtent &&
                    !context.read<HomePageBloc>().isFetching) {
                  searchMoviesByQuery(context, isFetching: true, isLoadMore: true);
                }
              }),
            itemBuilder: (context, index) {
              if (index == _movies.length) {
                return (context.read<HomePageBloc>().isFetching  && _movies.isNotEmpty)
                    ? LoadingIndicator() : SizedBox(height: 1,);
              }
              return MovieItemWidget(movie: _movies[index]);
            },
            separatorBuilder: (context, index) => const SizedBox(height: 20),
            itemCount: _movies.length+1,
          );
        },
      ),
    );
  }

  void searchMoviesByQuery(BuildContext context, {String query = "superman" ,
    bool isLoadMore = false, bool isFetching = false}) {
    BlocProvider.of<HomePageBloc>(context)..isFetching = isFetching
      ..add(SearchMoviesEvent(query: query, isLoadMore: isLoadMore));
  }

}