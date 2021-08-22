import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:xmovie/bloc/home/home_page_bloc.dart';
import 'package:xmovie/data/repository/movie_repository_impl.dart';
import 'package:xmovie/pages/detail/detail_movie_page.dart';
import 'package:xmovie/pages/home/home_page.dart';

import '../routes.dart';

class App extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (context) => HomePageBloc(repository: MovieRepositoryImpl()),
        ),
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: true,
        title: 'Xmovie',
        theme: ThemeData(
          primarySwatch: Colors.blue,
        ),
        routes: {
          Routes.detail: (context) => DetailMoviePage()
        },
        home: HomePage(),
      ),
    );
  }
}