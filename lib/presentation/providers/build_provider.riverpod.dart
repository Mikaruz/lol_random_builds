import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:lol_random_builds/domain/entities/build.dart';
import 'package:lol_random_builds/domain/entities/champion.dart';
import 'package:lol_random_builds/domain/entities/item.dart';
import 'package:lol_random_builds/domain/entities/rune.dart';
import 'package:lol_random_builds/domain/entities/summoner.dart';
import 'package:lol_random_builds/domain/repositories/build_repository.dart';
import 'package:lol_random_builds/presentation/providers/build_repository_provider.riverpod.dart';

final buildProvider = StateNotifierProvider<BuildNotifier, Build>((ref) {
  final buildRepository = ref.watch(buildRepositoryProvider);

  return BuildNotifier(buildRepository);
});

class BuildNotifier extends StateNotifier<Build> {
  final BuildRepository buildRepository;

  String champion = 'Random';

  BuildNotifier(this.buildRepository)
      : super(
          Build(
            champion: Champion(
                id: 'Pyke',
                name: 'Pyke',
                title: 'Pyke',
                imageUrl: 'assets/images/champions/Pyke.jpg',
                canBuyBoots: true,
                rangeType: 'melee',
                resourceType: 'mana',
                hasImmobilizingEffects: true),
            role: "Mid",
            items: [
              Item(
                name: 'name',
                imageUrl: 'assets/images/items/3117.png',
                isStarter: false,
                isBoots: true,
                isLegendary: false,
                isAramMode: false,
              ),
              Item(
                name: 'name',
                imageUrl: 'assets/images/items/3117.png',
                isStarter: false,
                isBoots: true,
                isLegendary: false,
                isAramMode: false,
              ),
              Item(
                name: 'name',
                imageUrl: 'assets/images/items/3117.png',
                isStarter: false,
                isBoots: true,
                isLegendary: false,
                isAramMode: false,
              ),
              Item(
                name: 'name',
                imageUrl: 'assets/images/items/3117.png',
                isStarter: false,
                isBoots: true,
                isLegendary: false,
                isAramMode: false,
              ),
              Item(
                name: 'name',
                imageUrl: 'assets/images/items/3117.png',
                isStarter: false,
                isBoots: true,
                isLegendary: false,
                isAramMode: false,
              ),
              Item(
                name: 'name',
                imageUrl: 'assets/images/items/3117.png',
                isStarter: false,
                isBoots: true,
                isLegendary: false,
                isAramMode: false,
              ),
            ],
            firstSummoner: Summoner(
              name: 'Ignite',
              imageUrl: 'assets/images/summoners/Ignite.png',
              isAramMode: false,
            ),
            secondSummoner: Summoner(
              name: 'Flash',
              imageUrl: 'assets/images/summoners/Flash.png',
              isAramMode: false,
            ),
            rune: Rune(
                keyStone: 'Hail Of Blades',
                keyStoneImageUrl: 'assets/images/runes/HailOfBlades.png',
                primaryFirstRow: 'Cheapshot',
                primarySecondRow: 'Zombie Ward',
                primaryThirdRow: 'Ultimate Hunter',
                primaryFirstRowImageUrl: 'assets/images/runes/CheapShot.png',
                primarySecondRowImageUrl: 'assets/images/runes/ZombieWard.png',
                primaryThirdRowImageUrl:
                    'assets/images/runes/UltimateHunter.png',
                secondaryFirstRow: 'Magical Footwear',
                secondarySecondRow: 'Cosmic Insight',
                secondaryFirstRowImageUrl:
                    'assets/images/runes/MagicalFootwear.png',
                secondarySecondRowImageUrl:
                    'assets/images/runes/CosmicInsight.png',
                offenseStat: 'Adaptive Force',
                flexStat: 'Adaptive Force',
                defenseStat: 'Health Plus',
                offenseStatImageUrl: 'assets/images/stats/AdaptiveForce.png',
                flexStatImageUrl: 'assets/images/stats/AdaptiveForce.png',
                defenseStatImageUrl: 'assets/images/stats/HealthPlus.png'),
          ),
        );

  Future<void> updateBuild(isAram, championName, role) async {
    final Build build =
        await buildRepository.getRandomBuild(isAram, championName, role);
    state = build;
  }
}

final isAramModeProvider = StateProvider<bool>((ref) {
  return false;
});

final roleProvider = StateProvider<String>((ref) {
  return "Random";
});

final championNameProvider = StateProvider<String>((ref) {
  return "Random";
});
