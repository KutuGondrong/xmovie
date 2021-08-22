import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:xmovie/data/response/movie.dart';
import 'package:xmovie/routes.dart';
import 'package:xmovie/utils/common_ext.dart';

import 'error_image.dart';
import 'loading_indicator.dart';

class MovieItemWidget extends StatelessWidget {
  final Movie movie;
  const MovieItemWidget({Key? key, required this.movie}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        Navigator.pushNamed(context, Routes.detail,
            arguments: movie);
      },
      child: Card(
        elevation: 4.0,
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Expanded(
              flex: 1,
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Hero(
                  tag: '${movie.id}',
                  child: CachedNetworkImage( imageUrl : "${movie.path.toString().toUrlW92Image}",
                    placeholder: (context, url) => Padding(
                      padding: const EdgeInsets.only(top: 8.0),
                      child: LoadingIndicator(),
                    ),
                    errorWidget: (context, url, error) => ErrorImage(),),
                ),
              ),
            ),
            Expanded(
              flex: 3,
              child: Column(
                mainAxisSize: MainAxisSize.max,
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.start,
                children: <Widget>[
                  Padding(
                    padding: const EdgeInsets.only(top: 8.0),
                    child: Text(
                      movie.title.toString(),
                      style: TextStyle(fontWeight: FontWeight.bold),
                    ),
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
                  Padding(
                    padding: const EdgeInsets.only(
                        bottom: 8.0, right: 8.0),
                    child: Text(
                      movie.description.toString(),
                      maxLines: 3,
                      overflow: TextOverflow.ellipsis,
                    ),
                  ),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
