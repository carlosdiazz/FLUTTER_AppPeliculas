import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_peliculas/models/models.dart';
import 'package:http/http.dart' as http;

class MoviesProvider extends ChangeNotifier {
  String _apiKey = 'da25399c7ab7bcee46c4a0bfda74d227';
  String _baseUrl = 'api.themoviedb.org';
  String _languaje = 'es-Es';

  MoviesProvider() {
    getOnDisplayMovies();
  }

  getOnDisplayMovies() async {
    var url = Uri.https(_baseUrl, '3/movie/now_playing',
        {"api_key": _apiKey, "lenguage": _languaje, "page": "1"});

    final response = await http.get(url);
    String body = response.body;
    final nowPlayingResponse = NowPlayingResponse.fromRawJson(body);

    print(nowPlayingResponse.results[0].title);
  }
}
