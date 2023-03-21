import 'package:flutter/material.dart';
import 'package:flutter_peliculas/models/movie.dart';
import 'package:flutter_peliculas/providers/movies_provider.dart';
import 'package:flutter_peliculas/routes/routes.dart';
import 'package:provider/provider.dart';

class MovieSearchDelegate extends SearchDelegate {
  @override
  String? get searchFieldLabel => 'Buscar';

  @override
  List<Widget>? buildActions(BuildContext context) {
    return [
      IconButton(onPressed: () => query = '', icon: const Icon(Icons.clear))
    ];
  }

  @override
  Widget? buildLeading(BuildContext context) {
    return IconButton(
        onPressed: () {
          close(context, null);
        },
        icon: Icon(Icons.arrow_back));
  }

  @override
  Widget buildResults(BuildContext context) {
    return Text('buildResults');
  }

  Widget _emptyContainer() {
    return Container(
      child: Center(
        child: Icon(
          Icons.movie_creation_outlined,
          color: Colors.black38,
          size: 200,
        ),
      ),
    );
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    if (query.isEmpty) {
      return _emptyContainer();
    }
    print('http requesty');
    final moviesProvider = Provider.of<MoviesProvider>(context, listen: false);
    moviesProvider.getSuggestionsByQuey(query);
    return StreamBuilder(
      builder: (_, snapshot) {
        if (!snapshot.hasData) return _emptyContainer();

        final movies = snapshot.data!;

        return ListView.builder(
          itemBuilder: (_, index) => _MovieItem(movie: movies[index]),
          itemCount: movies.length,
        );
      },
      stream: moviesProvider.suggestionStream,
    );
  }
}

class _MovieItem extends StatelessWidget {
  const _MovieItem({super.key, required this.movie});
  final Movie movie;
  @override
  Widget build(BuildContext context) {
    movie.heroId = 'search-${movie.id}';
    return ListTile(
      leading: Hero(
        tag: movie.heroId!,
        child: FadeInImage(
          placeholder: AssetImage('assets/no-image.jpg'),
          image: NetworkImage(
            movie.getPosterImg,
          ),
          width: 100,
          fit: BoxFit.contain,
        ),
      ),
      title: Text(movie.title),
      subtitle: Text(movie.originalTitle),
      onTap: () {
        Navigator.pushNamed(context, AppRoute.detailsScreen, arguments: movie);
      },
    );
  }
}
