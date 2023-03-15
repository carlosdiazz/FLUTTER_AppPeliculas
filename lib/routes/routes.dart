import 'package:flutter/material.dart';
import 'package:flutter_peliculas/screens/screens.dart';

class AppRoute {
  static const initialRoute = 'home';
  static const detailsScreen = 'detailsScreen';

  static Map<String, Widget Function(BuildContext)> getAppRoutes() {
    Map<String, Widget Function(BuildContext)> appRoutess = {
      initialRoute: (_) => const HomeScreen(),
      detailsScreen: (_) => const DetailsScreen(),
    };
    return appRoutess;
  }
}
