import 'package:flutter/material.dart';
import 'package:flutter_peliculas/models/movie.dart';
import 'package:flutter_peliculas/routes/routes.dart';

class MovieSlider extends StatefulWidget {
  const MovieSlider(
      {super.key,
      this.titulo,
      required this.movies,
      required this.onNextPages});
  final List<Movie> movies;
  final String? titulo;
  final Function onNextPages;

  @override
  State<MovieSlider> createState() => _MovieSliderState();
}

class _MovieSliderState extends State<MovieSlider> {
  final ScrollController scrollController = ScrollController();
  bool isLoading = false;
  @override
  void initState() {
    super.initState();
    scrollController.addListener(() {
      if (scrollController.position.pixels.toInt() >=
          scrollController.position.maxScrollExtent - 500) {
        fecthData();
      }
      //print(scrollController.position.pixels);
      //print(scrollController.position.maxScrollExtent);
    });
  }

  Future fecthData() async {
    if (isLoading) return;
    isLoading = true;
    setState(() {});
    widget.onNextPages();
    await Future.delayed(const Duration(seconds: 2));
    isLoading = false;
    setState(() {});
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    if (widget.movies.isEmpty) {
      return SizedBox(
        width: double.infinity,
        height: 280,
        child: const Center(
          child: CircularProgressIndicator(),
        ),
      );
    }

    return Container(
      width: double.infinity,
      height: 280,
      child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
        if (widget.titulo != null)
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 20),
            child: Text(
              widget.titulo ?? '',
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.w800),
            ),
          ),
        SizedBox(
          height: 10,
        ),
        //ssss
        Expanded(
          child: ListView.builder(
              controller: scrollController,
              scrollDirection: Axis.horizontal,
              itemCount: widget.movies.length,
              itemBuilder: (_, int index) => _MoviePoster(
                    movie: widget.movies[index],
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
              arguments: movie),
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
