import '../../data/datasources/movie_datasource.dart';
import '../entities/movie_entity.dart';

class GetMovies {
  Future<List<MovieEntity>> call() async {
    return await MovieDataSource().getMovies();
  }
}
