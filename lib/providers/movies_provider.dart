import 'package:flutter/material.dart';
import 'package:flutter_peliculas/models/models.dart';
import 'package:http/http.dart' as http;

class MoviesProvider extends ChangeNotifier {
  final _apiKey = 'da25399c7ab7bcee46c4a0bfda74d227';
  final _baseUrl = 'api.themoviedb.org';
  final _languaje = 'es-Es';

  List<Movie> onDisplayMovies = [];
  List<Movie> popularMovies = [];

  MoviesProvider() {
    getOnDisplayMovies();
    getPopularMovies();
  }

  getOnDisplayMovies() async {
    var url = Uri.https(_baseUrl, '3/movie/now_playing',
        {"api_key": _apiKey, "lenguage": _languaje, "page": "1"});

    final response = await http.get(url);
    String body = response.body;
    final nowPlayingResponse = NowPlayingResponse.fromRawJson(body);

    //print(nowPlayingResponse.results[0].title);
    onDisplayMovies = nowPlayingResponse.results;
    notifyListeners();
  }

  getPopularMovies() async {
    var url = Uri.https(_baseUrl, '3/movie/popular',
        {"api_key": _apiKey, "lenguage": _languaje, "page": "1"});

    final response = await http.get(url);
    String body = response.body;
    final popularResponse = MoviesPopularResponse.fromRawJson(body);

    //print(nowPlayingResponse.results[0].title);
    popularMovies = [...popularMovies, ...popularResponse.results];
    notifyListeners();
  }
}
