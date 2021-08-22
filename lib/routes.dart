import 'package:flutter/material.dart';

class Routes {
  Routes._();

  static const String home = '/';
  static const String detail = '/detail';

}

Route routeAnimation(StatefulWidget o) {
  return PageRouteBuilder(
    pageBuilder: (context, animation, secondaryAnimation) => o,
    transitionsBuilder: (context, animation, secondaryAnimation, child) {
      var begin = Offset(0.0, 1.0);
      var end = Offset.zero;
      var curve = Curves.ease;
      var tween = Tween(begin: begin, end: end).chain(CurveTween(curve: curve));
      return SlideTransition(
        position: animation.drive(tween),
        child: child,
      );
    },
  );
}