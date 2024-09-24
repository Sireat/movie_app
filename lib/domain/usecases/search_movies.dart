import '../../data/datasources/movie_datasource.dart';
import '../entities/movie_entity.dart';

class SearchMovies {
  Future<List<MovieEntity>> call(String query) async {
    return await MovieDataSource().searchMovies(query);
  }
}
