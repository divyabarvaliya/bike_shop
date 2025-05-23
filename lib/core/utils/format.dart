import 'package:intl/intl.dart';

class StringFormat {
  static String priceFormat(double val) {
    String formatted = '\$${NumberFormat("#,##0.00").format(val)}';
    return formatted;
  }
}
