import 'package:lol_random_builds/domain/entities/champion.dart';

class ChampionMapper {
  static jsonToEntity(Map<String, dynamic> json) => Champion(
        id: json['championID'],
        name: json['championName'],
        title: json['championTitle'],
        imageUrl: 'assets/images/champions/${json['championID']}.jpg',
        canBuyBoots: json['canBuyBoots'],
        rangeType: json['rangeType'],
        resourceType: json['resourceType'],
        hasImmobilizingEffects: json['hasImmobilizingEffects'],
      );
}
