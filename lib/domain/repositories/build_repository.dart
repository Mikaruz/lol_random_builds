import 'package:lol_random_builds/domain/entities/build.dart';

abstract class BuildRepository {
  Future<Build> getRandomBuild(bool isAram, String champion, String role);
}
