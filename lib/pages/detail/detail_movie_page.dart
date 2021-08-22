import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:xmovie/data/response/movie.dart';
import 'package:xmovie/utils/common_ext.dart';
import 'package:xmovie/widgets/error_image.dart';
import 'package:xmovie/widgets/loading_indicator.dart';

class DetailMoviePage extends StatefulWidget {
  @override
  _DetailMoviePageState createState() => _DetailMoviePageState();
}

class _DetailMoviePageState extends State<DetailMoviePage> {
  @override
  Widget build(BuildContext context) {
    final Movie movie = ModalRoute.of(context)?.settings.arguments as Movie;
    return Scaffold(
        body: SingleChildScrollView(
      physics: ClampingScrollPhysics(),
      child: Column(
        children: <Widget>[
          Stack(
            children: [
              Padding(
                padding: EdgeInsets.only(bottom: MediaQuery.of(context).size.width / 3),
                child: Container(
                  width: MediaQuery.of(context).size.width,
                  height: MediaQuery.of(context).size.width / 1.8,
                  child: CachedNetworkImage(
                    fit: BoxFit.cover,
                    width: MediaQuery.of(context).size.width,
                    height: MediaQuery.of(context).size.width / 2,
                    imageUrl: movie.path.toString().toString().toUrlW92Image,
                    placeholder: (context, url) => LoadingIndicator(),
                    errorWidget: (context, url, error) => ErrorImage(),
                  ),
                ),
              ),
              Positioned(
                bottom: 0.0,
                left: 16.0,
                right: 16.0,
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Hero(
                      tag: '${movie.id}',
                      child: CachedNetworkImage(
                        height : MediaQuery.of(context).size.width / 2,
                        imageUrl: movie.path.toString().toUrlW92Image,
                        placeholder: (context, url) => LoadingIndicator(),
                        errorWidget: (context, url, error) => ErrorImage(),
                      ),
                    ),
                    SizedBox(width: 2.0),
                    Expanded(child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        SizedBox(height: 16.0),
                        Text(
                          movie.title.toString(),
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        SizedBox(
                          height: 4.0,
                        ),
                        Padding(
                          padding: const EdgeInsets.only(
                              bottom: 8.0, right: 8.0),
                          child: Text(
                            movie.releaseDate.toString().formatDateStyle1,
                            maxLines: 3,
                            overflow: TextOverflow.ellipsis,
                          ),
                        ),
                      ],
                    )),
                  ],
                ),
              ),
            ],
          ),
          Padding(
            padding: const EdgeInsets.all(12.0),
            child: Text(
              movie.description.toString(),
              textAlign: TextAlign.justify,
            ),
          ),
          Container(
            padding: EdgeInsets.symmetric(horizontal: 12.0),
            child: ElevatedButton.icon(
              onPressed: () {
                Navigator.pop(context);
              },
              label: Text('Back', style: TextStyle(color: Colors.white),),
              icon: Icon(
                Icons.arrow_back,
                color: Colors.white,
                size: 24.0,
              ),
            ),
          )
        ],
      ),
    ));
  }
}
