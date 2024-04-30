import 'package:lol_random_builds/domain/datasources/build_datasource.dart';
import 'package:lol_random_builds/domain/entities/build.dart';
import 'package:lol_random_builds/domain/repositories/build_repository.dart';

class BuildRepositoryImpl extends BuildRepository {
  final BuildDatasource datasource;

  BuildRepositoryImpl(this.datasource);

  @override
  Future<Build> getRandomBuild(
      bool isAram, String champion, String role) async {
    return datasource.getRandomBuild(isAram, champion, role);
  }
}
