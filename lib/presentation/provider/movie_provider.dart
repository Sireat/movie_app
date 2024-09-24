import 'package:flutter/material.dart';
import '../../domain/entities/movie_entity.dart';
import '../../domain/usecases/get_movies.dart';

class MovieProvider with ChangeNotifier {
  List<MovieEntity> movies = [];
  bool isLoading = false;

  MovieProvider() {
    fetchMovies();
  }

  Future<void> fetchMovies() async {
    isLoading = true;
    notifyListeners();
    movies = await GetMovies().call();
    isLoading = false;
    notifyListeners();
  }
}
