import 'package:lol_random_builds/domain/entities/champion.dart';
import 'package:lol_random_builds/domain/entities/item.dart';
import 'package:lol_random_builds/domain/entities/rune.dart';
import 'package:lol_random_builds/domain/entities/summoner.dart';

class Build {
  Champion champion;
  String role;

  List<Item> items;
  Summoner firstSummoner;
  Summoner secondSummoner;

  Rune rune;

  Build({
    required this.champion,
    required this.role,
    required this.items,
    required this.firstSummoner,
    required this.secondSummoner,
    required this.rune,
  });
}
/* 
class Build {
  Champion champion;
  String role;
  List<Item> starterItems;
  Item boots;
  List<Item> legendaryItems;
  Rune principalRune;
  Rune secondaryRune;

  Build({
    required this.champion,
    required this.role,
    required this.starterItems,
    required this.boots,
    required this.legendaryItems,
    required this.principalRune,
    required this.secondaryRune,
  });
}
 */