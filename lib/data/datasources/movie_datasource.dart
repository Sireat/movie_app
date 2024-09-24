import 'dart:convert';
import 'package:http/http.dart' as http;
import '../../domain/entities/movie_entity.dart';

class MovieDataSource {
  // Fetches all movies
  Future<List<MovieEntity>> getMovies() async {
    try {
      final response = await http.get(Uri.parse('https://api.tvmaze.com/search/shows?q=all'));

      // Check if the response is successful
      if (response.statusCode == 200) {
        final List data = json.decode(response.body);
        return data.map((json) => MovieEntity(
          title: json['show']['name'],
          summary: _removeHtmlTags(json['show']['summary'] ?? 'No summary available'), // Remove HTML tags
          image: json['show']['image'] != null ? json['show']['image']['medium'] : 'https://via.placeholder.com/150',
          premiered: json['show']['premiered'] ?? 'N/A',
          status: json['show']['status'] ?? 'N/A',
          averageRating: json['show']['rating']?['average']?.toString() ?? 'N/A',
          genres: List<String>.from(json['show']['genres'] ?? []),
          officialSite: json['show']['officialSite'] ?? '',
        )).toList();
      } else {
        throw Exception('Failed to load movies');
      }
    } catch (error) {
      throw Exception('Error fetching movies: $error');
    }
  }

  // Searches for movies based on the query
  Future<List<MovieEntity>> searchMovies(String query) async {
    try {
      final response = await http.get(Uri.parse('https://api.tvmaze.com/search/shows?q=$query'));

      // Check if the response is successful
      if (response.statusCode == 200) {
        final List data = json.decode(response.body);
        return data.map((json) => MovieEntity(
          title: json['show']['name'],
          summary: _removeHtmlTags(json['show']['summary'] ?? 'No summary available'), // Remove HTML tags
          image: json['show']['image'] != null ? json['show']['image']['medium'] : 'https://via.placeholder.com/150',
          premiered: json['show']['premiered'] ?? 'N/A',
          status: json['show']['status'] ?? 'N/A',
          averageRating: json['show']['rating']?['average']?.toString() ?? 'N/A',
          genres: List<String>.from(json['show']['genres'] ?? []),
          officialSite: json['show']['officialSite'] ?? '',
        )).toList();
      } else {
        throw Exception('Failed to search movies');
      }
    } catch (error) {
      throw Exception('Error searching movies: $error');
    }
  }

  // Helper function to remove HTML tags
  String _removeHtmlTags(String htmlString) {
    final RegExp exp = RegExp(r"<[^>]*>", multiLine: true, caseSensitive: true);
    return htmlString.replaceAll(exp, '').trim();
  }
}
