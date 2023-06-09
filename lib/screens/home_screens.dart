import 'package:flutter/material.dart';
import 'package:flutter_peliculas/providers/movies_provider.dart';
import 'package:flutter_peliculas/search/search_delegate.dart';
import 'package:flutter_peliculas/widgets/widgets.dart';
import 'package:provider/provider.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    //Ve a el arbol de widgets, ahi buscame la isntancia de movieProvider
    final moviesProvider = Provider.of<MoviesProvider>(context);

    return Scaffold(
        appBar: AppBar(
          title: const Center(child: Text('DizzPeli')),
          actions: [
            IconButton(
                onPressed: () => showSearch(
                    context: context, delegate: MovieSearchDelegate()),
                icon: const Icon(Icons.search))
          ],
        ),
        body: SingleChildScrollView(
          child: Column(
            children: [
              //Tarjertas Principla
              CardSwiper(movies: moviesProvider.onDisplayMovies),

              //Slider de peliculas
              MovieSlider(
                movies: moviesProvider.popularMovies,
                titulo: "Populares",
                onNextPages: () => moviesProvider.getPopularMovies(),
              ),
            ],
          ),
        ));
  }
}
