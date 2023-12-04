import 'package:popcorndb/domain/datasources/movies_datasource.dart';
import 'package:popcorndb/domain/entities/movie.dart';
import 'package:popcorndb/domain/repositories/movies_repository.dart';

class MovieRepositoryImpl extends MoviesRepository {
  final MoviesDataSource datasource;
  MovieRepositoryImpl({required this.datasource});

  @override
  Future<List<Movie>> getNowPlaying({int page = 1}) {
    return datasource.getNowPlaying(page: page);
  }
}
