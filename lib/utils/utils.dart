import 'package:intl/intl.dart';

getFormatDate(String date, String format, String formatNew) {
  var formatter = DateFormat(format).parse(date);
  var format2 = DateFormat(formatNew).format(formatter);
  return format2;
}
