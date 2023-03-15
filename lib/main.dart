import 'package:flutter/material.dart';
import 'package:flutter_peliculas/providers/movies_provider.dart';
import 'package:flutter_peliculas/routes/routes.dart';
import 'package:flutter_peliculas/theme/app_theme.dart';
import 'package:provider/provider.dart';

void main() => runApp(AppState());

class AppState extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (_) => MoviesProvider(),
          lazy: false,
        )
      ],
      child: const MyApp(),
    );
  }
}

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
