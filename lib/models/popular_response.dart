// To parse this JSON data, do
//
//     final moviesPopularResponse = moviesPopularResponseFromJson(jsonString);

import 'dart:convert';

import 'package:flutter_peliculas/models/movie.dart';

class MoviesPopularResponse {
  MoviesPopularResponse({
    required this.page,
    required this.results,
    required this.totalPages,
    required this.totalResults,
  });

  int page;
  List<Movie> results;
  int totalPages;
  int totalResults;

  factory MoviesPopularResponse.fromRawJson(String str) =>
      MoviesPopularResponse.fromJson(json.decode(str));

  factory MoviesPopularResponse.fromJson(Map<String, dynamic> json) =>
      MoviesPopularResponse(
        page: json["page"],
        results:
            List<Movie>.from(json["results"].map((x) => Movie.fromJson(x))),
        totalPages: json["total_pages"],
        totalResults: json["total_results"],
      );
}
