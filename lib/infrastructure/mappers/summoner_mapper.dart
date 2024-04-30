import 'package:lol_random_builds/domain/entities/summoner.dart';

class SummonerMapper {
  static jsonToEntity(Map<String, dynamic> json, bool isAramMode) => Summoner(
        name: json['name'],
        imageUrl: 'assets/images/summoners/${json['name']}.png',
        isAramMode: isAramMode,
      );
}
