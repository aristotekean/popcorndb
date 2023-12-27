import 'package:dio/dio.dart';
import 'package:popcorndb/config/constants/environment.dart';
import 'package:popcorndb/domain/datasources/movies_datasource.dart';
import 'package:popcorndb/domain/entities/movie.dart';
import 'package:popcorndb/infrastructure/mappers/movie_mapper.dart';
import 'package:popcorndb/infrastructure/models/movidedb_response.dart';
import 'package:popcorndb/infrastructure/models/movie_details.dart';

class MovidedbDataSource extends MoviesDataSource {
  final dio = Dio(BaseOptions(
      baseUrl: 'https://api.themoviedb.org/3',
      queryParameters: {'api_key': Environment.theMovieDbKey}));

  List<Movie> _jsonToMovies(Map<String, dynamic> json) {
    final movidedbResponse = MovieDbResponse.fromJson(json);
    final List<Movie> movies = movidedbResponse.results
        .where((m) => m.posterPath != 'no-poster')
        .map((m) => MovieMapper.movieDBToEntity(m))
        .toList();
    return movies;
  }

  @override
  Future<List<Movie>> getNowPlaying({int page = 1}) async {
    final response =
        await dio.get('/movie/now_playing', queryParameters: {'page': page});
    return _jsonToMovies(response.data);
  }

  @override
  Future<List<Movie>> getPopular({int page = 1}) async {
    final response =
        await dio.get('/movie/popular', queryParameters: {'page': page});
    return _jsonToMovies(response.data);
  }

  @override
  Future<List<Movie>> getTopRated({int page = 1}) async {
    final response =
        await dio.get('/movie/top_rated', queryParameters: {'page': page});
    return _jsonToMovies(response.data);
  }

  @override
  Future<List<Movie>> getUpcoming({int page = 1}) async {
    final response =
        await dio.get('/movie/upcoming', queryParameters: {'page': page});
    return _jsonToMovies(response.data);
  }

  @override
  Future<Movie> getMovieById(String id) async {
    final response = await dio.get('/movie/$id');
    if (response.statusCode != 200) {
      throw Exception('The Movie with $id not found');
    }
    final movieDetails = MovieDetails.fromJson(response.data);
    final Movie movie = MovieMapper.movieDetailToEntity(movieDetails);
    return movie;
  }
}
