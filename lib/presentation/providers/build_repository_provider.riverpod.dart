import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:lol_random_builds/infrastructure/datasources/build_datasource_impl.dart';
import 'package:lol_random_builds/infrastructure/repositories/build_repository_impl.dart';

final buildRepositoryProvider = Provider((ref) {
  return BuildRepositoryImpl(BuildDatasourceImpl());
});
