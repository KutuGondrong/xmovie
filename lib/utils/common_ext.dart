import 'package:intl/intl.dart';

extension StringExtension on String{

  String get toUrlW92Image {
    return 'http://image.tmdb.org/t/p/w92/$this';
  }

  String get formatDateStyle1 {
    try {
      var inputFormat = DateFormat('yyyy-mm-dd');
      var inputDate = inputFormat.parse(this);

      var outputFormat = DateFormat('MM/dd/yyyy');
      var outputDate = outputFormat.format(inputDate);
      return outputDate;
    } catch (e) {
      return this;
    }
  }
}