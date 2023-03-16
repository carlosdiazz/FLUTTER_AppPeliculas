import 'package:flutter/material.dart';
import 'package:flutter_peliculas/models/movie.dart';
import 'package:flutter_peliculas/routes/routes.dart';

class MovieSlider extends StatelessWidget {
  const MovieSlider({super.key, required this.movies, this.titulo});
  final List<Movie> movies;
  final String? titulo;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      height: 280,
      child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
        if (titulo != null)
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 20),
            child: Text(
              titulo ?? '',
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.w800),
            ),
          ),
        SizedBox(
          height: 10,
        ),
        Expanded(
          child: ListView.builder(
              scrollDirection: Axis.horizontal,
              itemCount: 20,
              itemBuilder: (_, int index) => _MoviePoster(
                    movie: movies[index],
                  )),
        ),
      ]),
    );
  }
}

class _MoviePoster extends StatelessWidget {
  const _MoviePoster({super.key, required this.movie});
  final Movie movie;
  @override
  Widget build(BuildContext context) {
    return Container(
      width: 130,
      //height: 200,
      //color: Colors.green,
      margin: EdgeInsets.symmetric(horizontal: 10),
      child: Column(children: [
        GestureDetector(
          onTap: () => Navigator.pushNamed(context, AppRoute.detailsScreen,
              arguments: 'movie'),
          child: ClipRRect(
            borderRadius: BorderRadius.circular(20),
            child: FadeInImage(
              placeholder: AssetImage('assets/no-image.jpg'),
              image: NetworkImage(movie.getPosterImg),
              width: 130,
              height: 190,
              fit: BoxFit.cover,
            ),
          ),
        ),
        SizedBox(
          height: 10,
        ),
        Text(
          movie.title,
          overflow: TextOverflow.ellipsis,
          maxLines: 2,
        )
      ]),
    );
  }
}
