import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_peliculas/helpers/debouncer.dart';
import 'package:flutter_peliculas/models/models.dart';
import 'package:flutter_peliculas/models/search_response.dart';
import 'package:http/http.dart' as http;

class MoviesProvider extends ChangeNotifier {
  final _apiKey = 'da25399c7ab7bcee46c4a0bfda74d227';
  final _baseUrl = 'api.themoviedb.org';
  final _languaje = 'es-Es';

  List<Movie> onDisplayMovies = [];
  List<Movie> popularMovies = [];

  Map<int, List<Cast>> moviesCast = {};

  int _popularPage = 0;

  final debouncer = Debouncer(
    duration: const Duration(milliseconds: 500),
  );

  final StreamController<List<Movie>> _suggetionStreamController =
      StreamController.broadcast();

  Stream<List<Movie>> get suggestionStream => _suggetionStreamController.stream;

  //Ejecutio esta funciones al construir
  MoviesProvider() {
    getOnDisplayMovies();
    getPopularMovies();
  }

  Future<String> _getJsonData(String endpoint, [int page = 1]) async {
    final url = Uri.https(_baseUrl, endpoint,
        {"api_key": _apiKey, "lenguage": _languaje, "page": "$page"});

    final response = await http.get(url);
    return response.body;
  }

  getOnDisplayMovies() async {
    final jsonData = await _getJsonData('3/movie/now_playing');
    final nowPlayingResponse = NowPlayingResponse.fromRawJson(jsonData);
    onDisplayMovies = nowPlayingResponse.results;
    notifyListeners();
  }

  getPopularMovies() async {
    _popularPage++;
    final jsonData = await _getJsonData('3/movie/popular', _popularPage);
    final popularResponse = MoviesPopularResponse.fromRawJson(jsonData);
    popularMovies = [...popularMovies, ...popularResponse.results];
    notifyListeners();
  }

  Future<List<Cast>> getMoviesCast(int movieId) async {
    if (moviesCast.containsKey(movieId)) return moviesCast[movieId]!;
    final jsonData = await _getJsonData(
      '3/movie/$movieId/credits',
    );
    final creditsResponse = CreditsResponse.fromRawJson(jsonData);
    moviesCast[movieId] = creditsResponse.cast;
    return creditsResponse.cast;
  }

  Future<List<Movie>> searchMovies(String query) async {
    final url = Uri.https(_baseUrl, '3/search/movie',
        {"api_key": _apiKey, "lenguage": _languaje, "query": query});
    final response = await http.get(url);
    final searchResponse = SearchResponse.fromRawJson(response.body);
    return searchResponse.results;
  }

  void getSuggestionsByQuey(String searchTerm) {
    debouncer.value = '';
    debouncer.onValue = (value) async {
      final results = await searchMovies(value);
      _suggetionStreamController.add(results);
    };
    final timer = Timer.periodic(const Duration(milliseconds: 300), (_) {
      debouncer.value = searchTerm;
    });

    Future.delayed(const Duration(milliseconds: 301))
        .then((value) => timer.cancel());
  }
}
