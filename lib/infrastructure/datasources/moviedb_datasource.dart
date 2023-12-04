import 'package:dio/dio.dart';
import 'package:popcorndb/config/constants/environment.dart';
import 'package:popcorndb/domain/datasources/movies_datasource.dart';
import 'package:popcorndb/domain/entities/movie.dart';
import 'package:popcorndb/infrastructure/mappers/movie_mapper.dart';
import 'package:popcorndb/infrastructure/models/movidedb_response.dart';

class MovidedbDataSource extends MoviesDataSource {
  final dio = Dio(BaseOptions(
      baseUrl: 'https://api.themoviedb.org/3',
      queryParameters: {'api_key': Environment.theMovieDbKey}));
  @override
  Future<List<Movie>> getNowPlaying({int page = 1}) async {
    final response = await dio.get('/movie/now/playing');
    final movidedbResponse = MovieDbResponse.fromJson(response.data);
    final List<Movie> movies = movidedbResponse.results.where((m) => m.posterPath != 'no-poster')
        .map((m) => MovieMapper.movieDBToEntity(m))
        .toList();
    return movies;
  }
}
