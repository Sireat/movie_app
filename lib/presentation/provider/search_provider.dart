import 'package:flutter/foundation.dart';
import '../../domain/entities/movie_entity.dart';
import '../../data/datasources/movie_datasource.dart';

class SearchProvider with ChangeNotifier {
  final MovieDataSource _dataSource = MovieDataSource();
  List<MovieEntity> _movies = [];
  bool _isLoading = false;
  String? _errorMessage; // Error message property
  String? _lastSearchTerm; // Store the last searched term

  List<MovieEntity> get movies => _movies; // Exposing movies list
  bool get isLoading => _isLoading; // Getter for isLoading
  String? get errorMessage => _errorMessage; // Getter for error message
  String? get lastSearchTerm => _lastSearchTerm; // Getter for the last search term

  // Method to search movies
  Future<void> searchMovies(String query) async {
    _isLoading = true; // Set loading to true
    _errorMessage = null; // Clear any previous error message
    _lastSearchTerm = query; // Store the current search term
    notifyListeners(); // Notify listeners

    try {
      _movies = await _dataSource.searchMovies(query);
    } catch (error) {
      _errorMessage = 'An error occurred while searching for movies.'; // Set error message
      _movies = []; // Clear the list if there's an error
    } finally {
      _isLoading = false; // Set loading to false
      notifyListeners(); // Notify listeners
    }
  }

  // Method to clear movies
  void clearMovies() {
    _movies.clear();
    _lastSearchTerm = null; // Clear the last search term
    notifyListeners(); // Notify listeners after clearing
  }
}
