import 'package:flutter/material.dart';
import 'package:flutter_peliculas/routes/routes.dart';
import 'package:flutter_peliculas/screens/screens.dart';
import 'package:flutter_peliculas/theme/app_theme.dart';

void main() => runApp(const MyApp());

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Material App',
        theme: AppTheme.darkTheme,
        initialRoute: AppRoute.initialRoute,
        routes: AppRoute.getAppRoutes());
  }
}
