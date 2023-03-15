import 'package:flutter/material.dart';

class AppTheme {
  static Color primary = Colors.green;

  static final ThemeData darkTheme = ThemeData.dark()
      .copyWith(appBarTheme: AppBarTheme(backgroundColor: primary));
}
