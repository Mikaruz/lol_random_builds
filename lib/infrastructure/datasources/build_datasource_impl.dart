import 'dart:convert';
import 'dart:math';
import 'package:flutter/services.dart';
import 'package:lol_random_builds/domain/datasources/build_datasource.dart';
import 'package:lol_random_builds/domain/entities/build.dart';
import 'package:lol_random_builds/domain/entities/champion.dart';
import 'package:lol_random_builds/domain/entities/item.dart';
import 'package:lol_random_builds/domain/entities/rune.dart';
import 'package:lol_random_builds/domain/entities/summoner.dart';
import 'package:lol_random_builds/infrastructure/mappers/item_mapper.dart';
import 'package:lol_random_builds/infrastructure/mappers/champion_mapper.dart';
import 'package:lol_random_builds/infrastructure/mappers/summoner_mapper.dart';

class BuildDatasourceImpl extends BuildDatasource {
  final random = Random();

  final String jsonChampionsFilePath = 'assets/data/champions.json';
  final String jsonItemsFilePath = 'assets/data/items.json';
  final String jsonBootsFilePath = 'assets/data/boots.json';
  final String jsonRunesFilePath = 'assets/data/runes.json';
  final String jsonStatsFilePath = 'assets/data/stats.json';
  final String jsonSummonersFilePath = 'assets/data/summoners.json';
  final String jsonAramSummonersFilePath = 'assets/data/aram_summoners.json';

  @override
  Future<Build> getRandomBuild(
      bool isAramMode, String championName, String role) async {
    final champion;

    if (championName == "Random") {
      champion = await getRandomChampion();
    } else {
      String jsonString = await rootBundle.loadString(jsonChampionsFilePath);
      List<dynamic> jsonData = json.decode(jsonString);

      final championData = jsonData.firstWhere(
        (champion) => champion['championName'] == championName,
        orElse: () => null,
      );
      champion = ChampionMapper.jsonToEntity(championData);
    }

    if (role == "Random") {
      role = await getRandomRole();
    }

    final items = await getRandomItems(champion);

    final summoners = await getRandomSummoners(role, isAramMode);
    final firstSummoner = summoners[0];
    final secondSummoner = summoners[1];

    final rune = await getRandomRune(champion, summoners, isAramMode);

    final build = Build(
      champion: champion,
      role: role,
      items: items,
      firstSummoner: firstSummoner,
      secondSummoner: secondSummoner,
      rune: rune,
    );

    return build;
  }

  Future<Champion> getRandomChampion() async {
    Map<String, dynamic> championData =
        await getRandomJsonData(jsonChampionsFilePath);
    final Champion champion = ChampionMapper.jsonToEntity(championData);

    return champion;
  }

  Future<String> getRandomRole() async {
    final roles = ['Top', 'Jungle', 'Mid', 'Support', 'ADC'];
    final index = random.nextInt(roles.length);

    return roles[index];
  }

  Future<List<Item>> getRandomItems(Champion champion) async {
    List<Item> items = [];
    int itemCount = 0;

    if (champion.canBuyBoots) {
      Map<String, dynamic> bootsData =
          await getRandomJsonData(jsonBootsFilePath);

      final Item boots = ItemMapper.jsonToEntity(bootsData);
      items.add(boots);

      itemCount = 1;
    }

    do {
      bool isRepeated = false;
      bool hasConflicts = false;

      Map<String, dynamic> itemData =
          await getRandomJsonData(jsonItemsFilePath);
      final Item item = ItemMapper.jsonToEntity(itemData);

      if (item.name == "Runaan's Hurricane" && champion.rangeType == "melee") {
        hasConflicts = true;
      }

      for (int i = 0; i < itemCount; i++) {
        if (items[i].name == item.name) {
          isRepeated = true;
        }

        if (item.name == "Seraph's Embrace") {
          if (items[i].name == "Muramana") hasConflicts = true;
          if (items[i].name == "Fimbulwinter") hasConflicts = true;
          if (items[i].name == "Maw of Malmortius") hasConflicts = true;
          if (items[i].name == "Sterak's Gage") hasConflicts = true;
          if (items[i].name == "Immortal Shieldbow") hasConflicts = true;
        }

        if (item.name == "Muramana") {
          if (items[i].name == "Seraph's Embrace") hasConflicts = true;
          if (items[i].name == "Fimbulwinter") hasConflicts = true;
        }

        if (item.name == "Fimbulwinter") {
          if (items[i].name == "Seraph's Embrace") hasConflicts = true;
          if (items[i].name == "Muramana") hasConflicts = true;
        }

        if (item.name == "Lord Dominik's Regards") {
          if (items[i].name == "Serylda's Grudge") hasConflicts = true;
          if (items[i].name == "Mortal Reminder") hasConflicts = true;
          if (items[i].name == "Terminus") hasConflicts = true;
          if (items[i].name == "Black Cleaver") hasConflicts = true;
        }

        if (item.name == "Serylda's Grudge") {
          if (items[i].name == "Lord Dominik's Regards") hasConflicts = true;
          if (items[i].name == "Mortal Reminder") hasConflicts = true;
          if (items[i].name == "Terminus") hasConflicts = true;
          if (items[i].name == "Black Cleaver") hasConflicts = true;
        }

        if (item.name == "Mortal Reminder") {
          if (items[i].name == "Lord Dominik's Regards") hasConflicts = true;
          if (items[i].name == "Serylda's Grudge") hasConflicts = true;
          if (items[i].name == "Terminus") hasConflicts = true;
          if (items[i].name == "Black Cleaver") hasConflicts = true;
        }

        if (item.name == "Black Cleaver") {
          if (items[i].name == "Lord Dominik's Regards") hasConflicts = true;
          if (items[i].name == "Serylda's Grudge") hasConflicts = true;
          if (items[i].name == "Terminus") hasConflicts = true;
          if (items[i].name == "Mortal Reminder") hasConflicts = true;
        }

        if (item.name == "Terminus") {
          if (items[i].name == "Lord Dominik's Regards") hasConflicts = true;
          if (items[i].name == "Serylda's Grudge") hasConflicts = true;
          if (items[i].name == "Mortal Reminder") hasConflicts = true;
          if (items[i].name == "Black Cleaver") hasConflicts = true;
          if (items[i].name == "Void Staff") hasConflicts = true;
          if (items[i].name == "Cryptbloom") hasConflicts = true;
        }

        if (item.name == "Void Staff") {
          if (items[i].name == "Terminus") hasConflicts = true;
          if (items[i].name == "Cryptbloom") hasConflicts = true;
        }

        if (item.name == "Cryptbloom") {
          if (items[i].name == "Terminus") hasConflicts = true;
          if (items[i].name == "Void Staff") hasConflicts = true;
        }

        if (item.name == "Maw of Malmortius") {
          if (items[i].name == "Sterak's Gage") hasConflicts = true;
          if (items[i].name == "Seraph's Embrace") hasConflicts = true;
          if (items[i].name == "Immortal Shieldbow") hasConflicts = true;
        }

        if (item.name == "Sterak's Gage") {
          if (items[i].name == "Maw of Malmortius") hasConflicts = true;
          if (items[i].name == "Seraph's Embrace") hasConflicts = true;
          if (items[i].name == "Immortal Shieldbow") hasConflicts = true;
        }

        if (item.name == "Immortal Shieldbow") {
          if (items[i].name == "Maw of Malmortius") hasConflicts = true;
          if (items[i].name == "Seraph's Embrace") hasConflicts = true;
          if (items[i].name == "Sterak's Gage") hasConflicts = true;
        }

        if (item.name == "Titanic Hydra") {
          if (items[i].name == "Ravenous Hydra") hasConflicts = true;
          if (items[i].name == "Profane Hydra") hasConflicts = true;
        }

        if (item.name == "Ravenous Hydra") {
          if (items[i].name == "Titanic Hydra") hasConflicts = true;
          if (items[i].name == "Profane Hydra") hasConflicts = true;
        }

        if (item.name == "Profane Hydra") {
          if (items[i].name == "Ravenous Hydra") hasConflicts = true;
          if (items[i].name == "Titanic Hydra") hasConflicts = true;
        }

        if (item.name == "Infinity Edge") {
          if (items[i].name == "Navori Quickblades") hasConflicts = true;
        }

        if (item.name == "Navori Quickblades") {
          if (items[i].name == "Infinity Edge") hasConflicts = true;
        }

        if (item.name == "Trailblazer") {
          if (items[i].name == "Dead Man's Plate") hasConflicts = true;
        }

        if (item.name == "Dead Man's Plate") {
          if (items[i].name == "Trailblazer") hasConflicts = true;
        }

        if (item.name == "Sunfire Aegis") {
          if (items[i].name == "Hollow Radiance") hasConflicts = true;
        }

        if (item.name == "Hollow Radiance") {
          if (items[i].name == "Sunfire Aegis") hasConflicts = true;
        }

        if (item.name == "Edge of Night") {
          if (items[i].name == "Banshee's Veil") hasConflicts = true;
        }

        if (item.name == "Banshee's Veil") {
          if (items[i].name == "Edge of Night") hasConflicts = true;
        }

        if (item.name == "Essence Reaver") {
          if (items[i].name == "Trinity Force") hasConflicts = true;
          if (items[i].name == "Lich Bane") hasConflicts = true;
          if (items[i].name == "Iceborn Gauntlet") hasConflicts = true;
          if (items[i].name == "Bloodsong") hasConflicts = true;
        }

        if (item.name == "Trinity Force") {
          if (items[i].name == "Essence Reaver") hasConflicts = true;
          if (items[i].name == "Lich Bane") hasConflicts = true;
          if (items[i].name == "Iceborn Gauntlet") hasConflicts = true;
          if (items[i].name == "Bloodsong") hasConflicts = true;
        }

        if (item.name == "Lich Bane") {
          if (items[i].name == "Essence Reaver") hasConflicts = true;
          if (items[i].name == "Trinity Force") hasConflicts = true;
          if (items[i].name == "Iceborn Gauntlet") hasConflicts = true;
          if (items[i].name == "Bloodsong") hasConflicts = true;
        }

        if (item.name == "Bloodsong") {
          if (items[i].name == "Essence Reaver") hasConflicts = true;
          if (items[i].name == "Trinity Force") hasConflicts = true;
          if (items[i].name == "Iceborn Gauntlet") hasConflicts = true;
          if (items[i].name == "Lich Bane") hasConflicts = true;
          if (items[i].name == "Solstice Sleigh") hasConflicts = true;
          if (items[i].name == "Celestial Opposition") hasConflicts = true;
          if (items[i].name == "Zaz'Zak's Realmspike") hasConflicts = true;
          if (items[i].name == "Dream Maker") hasConflicts = true;
        }

        if (item.name == "Iceborn Gauntlet") {
          if (items[i].name == "Essence Reaver") hasConflicts = true;
          if (items[i].name == "Trinity Force") hasConflicts = true;
          if (items[i].name == "Lich Bane") hasConflicts = true;
          if (items[i].name == "Bloodsong") hasConflicts = true;
        }

        if (item.name == "Solstice Sleigh") {
          if (items[i].name == "Bloodsong") hasConflicts = true;
          if (items[i].name == "Celestial Opposition") hasConflicts = true;
          if (items[i].name == "Zaz'Zak's Realmspike") hasConflicts = true;
          if (items[i].name == "Dream Maker") hasConflicts = true;
        }

        if (item.name == "Celestial Opposition") {
          if (items[i].name == "Bloodsong") hasConflicts = true;
          if (items[i].name == "Solstice Sleigh") hasConflicts = true;
          if (items[i].name == "Zaz'Zak's Realmspike") hasConflicts = true;
          if (items[i].name == "Dream Maker") hasConflicts = true;
        }

        if (item.name == "Dream Maker") {
          if (items[i].name == "Bloodsong") hasConflicts = true;
          if (items[i].name == "Solstice Sleigh") hasConflicts = true;
          if (items[i].name == "Celestial Opposition") hasConflicts = true;
          if (items[i].name == "Zaz'Zak's Realmspike") hasConflicts = true;
        }
      }

      if (hasConflicts) print("HUBO ERROR ERROR ERROR CON: " + item.name);
      if (!isRepeated && !hasConflicts) {
        itemCount++;
        items.add(item);
      }
    } while (items.length < 6);

    return items;
  }

  Future<List<Summoner>> getRandomSummoners(
      String role, bool isAramMode) async {
    Map<String, dynamic> firstSummonerData, secondSummonerData;
//isAram = true;
    do {
      if (isAramMode) {
        firstSummonerData = await getRandomJsonData(jsonAramSummonersFilePath);
        secondSummonerData = await getRandomJsonData(jsonAramSummonersFilePath);
      } else {
        firstSummonerData = await getRandomJsonData(jsonSummonersFilePath);
        secondSummonerData = await getRandomJsonData(jsonSummonersFilePath);
      }
    } while (firstSummonerData['name'] == secondSummonerData['name']);

    if (role == 'Jungle' &&
        !isAramMode &&
        (firstSummonerData['name'] != 'Smite' &&
            secondSummonerData['name'] != 'Smite')) {
      final indexToReplace = random.nextInt(2);

      if (indexToReplace == 0) {
        firstSummonerData['name'] = "Smite";
        firstSummonerData['isAramMode'] = false;
      } else {
        secondSummonerData['name'] = "Smite";
        secondSummonerData['isAramMode'] = false;
      }
    }

    final Summoner firstSummoner =
        SummonerMapper.jsonToEntity(firstSummonerData, isAramMode);

    final Summoner secondSummoner =
        SummonerMapper.jsonToEntity(secondSummonerData, isAramMode);

    return [firstSummoner, secondSummoner];
  }

  Future<Rune> getRandomRune(
      Champion champion, List<Summoner> summoners, bool isAram) async {
    Map<String, dynamic> primaryRuneData, secondaryRuneData;

    do {
      primaryRuneData = await getRandomJsonData(jsonRunesFilePath);
      secondaryRuneData = await getRandomJsonData(jsonRunesFilePath);
    } while (primaryRuneData['rune'] == secondaryRuneData['rune']);

    String secondaryFirstData, secondarySecondData;
    int secondaryFirstRandomIndex, secondarySecondRandomIndex;

    do {
      secondaryFirstRandomIndex = random.nextInt(3) + 1;
      secondarySecondRandomIndex = random.nextInt(3) + 1;
    } while (secondaryFirstRandomIndex == secondarySecondRandomIndex);

    Map<String, dynamic> keystone = getRandomData(primaryRuneData, 'keystones');

    Map<String, dynamic> primaryFirstRow =
        getRandomData(primaryRuneData, 'firstRow');

    Map<String, dynamic> primarySecondRow =
        getRandomData(primaryRuneData, 'secondRow');

    Map<String, dynamic> primaryThirdRow =
        getRandomData(primaryRuneData, 'thirdRow');

    secondaryFirstData =
        ['firstRow', 'secondRow', 'thirdRow'][secondaryFirstRandomIndex - 1];
    secondarySecondData =
        ['firstRow', 'secondRow', 'thirdRow'][secondarySecondRandomIndex - 1];

    Map<String, dynamic> secondaryFirstRow =
        getRandomData(secondaryRuneData, secondaryFirstData);

    Map<String, dynamic> secondarySecondRow =
        getRandomData(secondaryRuneData, secondarySecondData);

    if (isAram) {
      if (primaryThirdRow['id'] == 'Waterwalking') {
        primaryThirdRow['id'] == 'Scorch';
        primaryThirdRow['name'] == 'Scorch';
      }

      if (secondaryFirstRow['id'] == 'Waterwalking') {
        secondaryFirstRow['id'] == 'Scorch';
        secondaryFirstRow['name'] == 'Scorch';
      }

      if (secondarySecondRow['id'] == 'Waterwalking') {
        secondarySecondRow['id'] == 'Scorch';
        secondarySecondRow['name'] == 'Scorch';
      }

      if (primarySecondRow['id'] == 'ZombieWard' ||
          primarySecondRow['id'] == "GhostPoro") {
        primarySecondRow['id'] == 'EyeballCollection';
        primarySecondRow['name'] == 'Eyeball Collection';
      }

      if (secondaryFirstRow['id'] == 'ZombieWard' ||
          secondaryFirstRow['id'] == "GhostPoro") {
        secondaryFirstRow['id'] == 'EyeballCollection';
        secondaryFirstRow['name'] == 'Eyeball Collection';
      }

      if (secondarySecondRow['id'] == 'ZombieWard' ||
          secondarySecondRow['id'] == "GhostPoro") {
        secondarySecondRow['id'] == 'EyeballCollection';
        secondarySecondRow['name'] == 'Eyeball Collection';
      }
    }

    if (champion.resourceType != 'mana') {
      if (primarySecondRow['id'] == 'ManaflowBand') {
        primarySecondRow['id'] == 'NullifyingOrb';
        primarySecondRow['name'] == 'Nullifying Orb';
      }

      if (secondaryFirstRow['id'] == 'ManaflowBand') {
        secondaryFirstRow['id'] == 'NullifyingOrb';
        secondaryFirstRow['name'] == 'Nullifying Orb';
      }

      if (secondarySecondRow['id'] == 'ManaflowBand') {
        secondarySecondRow['id'] == 'NullifyingOrb';
        secondarySecondRow['name'] == 'Nullifying Orb';
      }
    }

    if (champion.resourceType != 'mana' || champion.resourceType != 'enery') {
      if (primarySecondRow['id'] == 'PresenceofMind') {
        primarySecondRow['id'] == 'Triumph';
        primarySecondRow['name'] == 'Triumph';
      }

      if (secondaryFirstRow['id'] == 'PresenceofMind') {
        secondaryFirstRow['id'] == 'Triumph';
        secondaryFirstRow['name'] == 'Triumph';
      }

      if (secondarySecondRow['id'] == 'PresenceofMind') {
        secondarySecondRow['id'] == 'Triumph';
        secondarySecondRow['name'] == 'Triumph';
      }
    }

    if (!champion.canBuyBoots) {
      if (keystone['id'] == 'Predator') {
        keystone['id'] == 'Electrocute';
        keystone['name'] == 'Electrocute';
      }

      if (primarySecondRow['id'] == 'MagicalFootwear') {
        primarySecondRow['id'] == 'TripleTonic';
        primarySecondRow['name'] == 'Triple Tonic';
      }

      if (secondaryFirstRow['id'] == 'MagicalFootwear') {
        secondaryFirstRow['id'] == 'TripleTonic';
        secondaryFirstRow['name'] == 'Triple Tonic';
      }

      if (secondarySecondRow['id'] == 'MagicalFootwear') {
        secondarySecondRow['id'] == 'TripleTonic';
        secondarySecondRow['name'] == 'Triple Tonic';
      }
    }

    if (!champion.hasImmobilizingEffects &&
        (champion.id != 'Corki' && champion.id != 'Yorick')) {
      if (keystone['id'] == 'Aftershock') {
        keystone['id'] == 'GraspOfTheUndying';
        keystone['name'] == 'Grasp Of The Undying';
      }

      if (keystone['id'] == 'GlacialAugment') {
        keystone['id'] == 'FirstStrike';
        keystone['name'] == 'First Strike';
      }
    }

    if (summoners[0].name != "Flash" || summoners[1].name != "Flash") {
      if (primaryFirstRow['id'] == 'HextechFlashtraption') {
        primaryFirstRow['id'] == 'TripleTonic';
        primaryFirstRow['name'] == 'Triple Tonic';
      }

      if (secondaryFirstRow['id'] == 'HextechFlashtraption') {
        secondaryFirstRow['id'] == 'TripleTonic';
        secondaryFirstRow['name'] == 'Triple Tonic';
      }

      if (secondarySecondRow['id'] == 'HextechFlashtraption') {
        secondarySecondRow['id'] == 'TripleTonic';
        secondarySecondRow['name'] == 'Triple Tonic';
      }
    }

    if (champion.id == "Corki") {
      if (primarySecondRow['id'] == 'FontOfLife') {
        primarySecondRow['id'] == 'Demolish';
        primarySecondRow['name'] == 'Demolish';
      }

      if (secondaryFirstRow['id'] == 'FontOfLife') {
        secondaryFirstRow['id'] == 'Demolish';
        secondaryFirstRow['name'] == 'Demolish';
      }

      if (secondarySecondRow['id'] == 'FontOfLife') {
        secondarySecondRow['id'] == 'Demolish';
        secondarySecondRow['name'] == 'Demolish';
      }
    }

    if (champion.id == "Belveth" ||
        champion.id == "Shyvana" ||
        champion.id == "Udyr") {
      if (primaryThirdRow['id'] == 'UltimateHunter') {
        primaryThirdRow['id'] == 'RelentlessHunter';
        primaryThirdRow['name'] == 'Relentless Hunter';
      }

      if (secondaryFirstRow['id'] == 'UltimateHunter') {
        secondaryFirstRow['id'] == 'RelentlessHunter';
        secondaryFirstRow['name'] == 'Relentless Hunter';
      }

      if (secondarySecondRow['id'] == 'UltimateHunter') {
        secondarySecondRow['id'] == 'RelentlessHunter';
        secondarySecondRow['name'] == 'Relentless Hunter';
      }
    }

    if (champion.id == "Samira") {
      if (primaryThirdRow['id'] == 'UltimateHunter') {
        primaryThirdRow['id'] == 'TreasureHunter';
        primaryThirdRow['name'] == 'Treasure Hunter';
      }

      if (secondaryFirstRow['id'] == 'UltimateHunter') {
        secondaryFirstRow['id'] == 'TreasureHunter';
        secondaryFirstRow['name'] == 'Treasure Hunter';
      }

      if (secondarySecondRow['id'] == 'UltimateHunter') {
        secondarySecondRow['id'] == 'TreasureHunter';
        secondarySecondRow['name'] == 'Treasure Hunter';
      }
    }

    Map<String, Map<String, dynamic>> stats = await getRandomStats();
    Map<String, dynamic>? offenseStat = stats['firstStat'];
    Map<String, dynamic>? flexStat = stats['secondStat'];
    Map<String, dynamic>? defenseStat = stats['thirdStat'];

    return Rune(
        keyStone: keystone['name'],
        keyStoneImageUrl: 'assets/images/runes/${keystone['id']}.png',
        primaryFirstRow: primaryFirstRow['name'],
        primarySecondRow: primarySecondRow['name'],
        primaryThirdRow: primaryThirdRow['name'],
        primaryFirstRowImageUrl:
            'assets/images/runes/${primaryFirstRow['id']}.png',
        primarySecondRowImageUrl:
            'assets/images/runes/${primarySecondRow['id']}.png',
        primaryThirdRowImageUrl:
            'assets/images/runes/${primaryThirdRow['id']}.png',
        secondaryFirstRow: secondaryFirstRow['name'],
        secondarySecondRow: secondarySecondRow['name'],
        secondaryFirstRowImageUrl:
            'assets/images/runes/${secondaryFirstRow['id']}.png',
        secondarySecondRowImageUrl:
            'assets/images/runes/${secondarySecondRow['id']}.png',
        offenseStat: offenseStat!['name'],
        flexStat: flexStat!['name'],
        defenseStat: defenseStat!['name'],
        offenseStatImageUrl: 'assets/images/stats/${offenseStat['id']}.png',
        flexStatImageUrl: 'assets/images/stats/${flexStat['id']}.png',
        defenseStatImageUrl: 'assets/images/stats/${defenseStat['id']}.png');
  }

  Future<Map<String, Map<String, dynamic>>> getRandomStats() async {
    String statsJsonString = await rootBundle.loadString(jsonStatsFilePath);
    List<dynamic> statsJsonData = json.decode(statsJsonString);

    Map<String, dynamic> firstStatData = statsJsonData[0];
    Map<String, dynamic> randomFirstStat =
        getRandomData(firstStatData, 'firstRow');

    Map<String, dynamic> secondStatData = statsJsonData[1];
    Map<String, dynamic> randomSecondStat =
        getRandomData(secondStatData, 'secondRow');

    Map<String, dynamic> thirdStatData = statsJsonData[2];
    Map<String, dynamic> randomThirdStat =
        getRandomData(thirdStatData, 'thirdRow');

    return {
      'firstStat': randomFirstStat,
      'secondStat': randomSecondStat,
      'thirdStat': randomThirdStat,
    };
  }

  Future<Map<String, dynamic>> getRandomJsonData(String jsonFilePath) async {
    String jsonString = await rootBundle.loadString(jsonFilePath);
    List<dynamic> jsonData = json.decode(jsonString);
    int randomIndex = Random().nextInt(jsonData.length);
    return jsonData[randomIndex];
  }

  Map<String, dynamic> getRandomData(
      Map<String, dynamic> jsonData, String data) {
    List<dynamic> row = jsonData[data];
    int randomIndex = Random().nextInt(row.length);
    return row[randomIndex];
  }
}
