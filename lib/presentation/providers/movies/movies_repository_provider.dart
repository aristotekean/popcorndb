import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:popcorndb/infrastructure/datasources/moviedb_datasource.dart';
import 'package:popcorndb/infrastructure/repositories/movie_repository_impl.dart';

// This provider is inmutable
final movieRepositoryProvider = Provider((ref) {
  return MovieRepositoryImpl(datasource: MovidedbDataSource());
});
