import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:lol_random_builds/presentation/ads/custom_banner_ad.dart';
import 'package:lol_random_builds/presentation/providers/build_provider.riverpod.dart';
import 'package:lol_random_builds/presentation/widgets/widgets.dart';

class BuilRandomScreen extends ConsumerWidget {
  const BuilRandomScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final build = ref.watch(buildProvider);
    final championName = ref.watch(championNameProvider);
    final isAramMode = ref.watch(isAramModeProvider);
    final role = ref.watch(roleProvider);
    return Scaffold(
      appBar: AppBar(
        title: const Text(''),
      ),
      body: Column(
        children: [
          Expanded(
            child: ListView(
              children: [
                SizedBox(
                  width: double.maxFinite,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Text(
                        build.champion.name,
                        style: const TextStyle(
                          fontFamily: 'Nunito',
                          fontWeight: FontWeight.w600,
                          fontSize: 25,
                        ),
                      ),
                      Text(
                        isAramMode ? "ARAM" : build.role.toUpperCase(),
                        style: const TextStyle(
                          fontFamily: 'Nunito',
                          fontWeight: FontWeight.w400,
                          fontSize: 16,
                        ),
                      ),
                      const SizedBox(height: 10),
                      ClipRRect(
                        borderRadius: BorderRadius.circular(8),
                        child: Image.asset(
                          build.champion.imageUrl,
                          width: 370,
                          fit: BoxFit.cover,
                        ),
                      ),
                      const SizedBox(height: 20),
                      Container(
                        padding: const EdgeInsets.symmetric(horizontal: 40),
                        width: 370,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Column(
                              children: [
                                ClipRRect(
                                  borderRadius: BorderRadius.circular(8),
                                  child: Image.asset(
                                    build.firstSummoner.imageUrl,
                                    fit: BoxFit.cover,
                                  ),
                                ),
                                const SizedBox(height: 10),
                                ClipRRect(
                                  borderRadius: BorderRadius.circular(8),
                                  child: Image.asset(
                                    build.secondSummoner.imageUrl,
                                    fit: BoxFit.cover,
                                  ),
                                ),
                              ],
                            ),
                            Row(
                              children: [
                                Column(
                                  children: [
                                    ClipRRect(
                                      borderRadius: BorderRadius.circular(8),
                                      child: Image.asset(
                                        build.items[0].imageUrl,
                                        fit: BoxFit.cover,
                                      ),
                                    ),
                                    const SizedBox(height: 10),
                                    ClipRRect(
                                      borderRadius: BorderRadius.circular(8),
                                      child: Image.asset(
                                        build.items[1].imageUrl,
                                        fit: BoxFit.cover,
                                      ),
                                    ),
                                  ],
                                ),
                                const SizedBox(width: 10),
                                Column(
                                  children: [
                                    ClipRRect(
                                      borderRadius: BorderRadius.circular(8),
                                      child: Image.asset(
                                        build.items[2].imageUrl,
                                        fit: BoxFit.cover,
                                      ),
                                    ),
                                    const SizedBox(height: 10),
                                    ClipRRect(
                                      borderRadius: BorderRadius.circular(8),
                                      child: Image.asset(
                                        build.items[3].imageUrl,
                                        fit: BoxFit.cover,
                                      ),
                                    ),
                                  ],
                                ),
                                const SizedBox(width: 10),
                                Column(
                                  children: [
                                    ClipRRect(
                                      borderRadius: BorderRadius.circular(8),
                                      child: Image.asset(
                                        build.items[4].imageUrl,
                                        fit: BoxFit.cover,
                                      ),
                                    ),
                                    const SizedBox(height: 10),
                                    ClipRRect(
                                      borderRadius: BorderRadius.circular(8),
                                      child: Image.asset(
                                        build.items[5].imageUrl,
                                        fit: BoxFit.cover,
                                      ),
                                    ),
                                  ],
                                )
                              ],
                            )
                          ],
                        ),
                      ),
                      const SizedBox(height: 20),
                      SizedBox(
                        width: 370,
                        child: Column(
                          children: [
                            const SizedBox(
                              width: double.maxFinite,
                              child: Text(
                                "Runes",
                                style: TextStyle(
                                  fontFamily: 'Nunito',
                                  fontWeight: FontWeight.w500,
                                  fontSize: 20,
                                ),
                                textAlign: TextAlign.left,
                              ),
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Image.asset(
                                  build.rune.keyStoneImageUrl,
                                  height: 150,
                                ),
                                Column(
                                  children: [
                                    Image.asset(
                                      build.rune.primaryFirstRowImageUrl,
                                      height: 45,
                                    ),
                                    const SizedBox(height: 10),
                                    Image.asset(
                                      build.rune.primarySecondRowImageUrl,
                                      height: 45,
                                    ),
                                    const SizedBox(height: 10),
                                    Image.asset(
                                      build.rune.primaryThirdRowImageUrl,
                                      height: 45,
                                    ),
                                  ],
                                ),
                                const SizedBox(width: 10),
                                Column(
                                  children: [
                                    Image.asset(
                                      build.rune.secondaryFirstRowImageUrl,
                                      height: 45,
                                    ),
                                    const SizedBox(height: 10),
                                    Image.asset(
                                      build.rune.secondarySecondRowImageUrl,
                                      height: 45,
                                    ),
                                  ],
                                ),
                              ],
                            )
                          ],
                        ),
                      ),
                      const SizedBox(height: 20),
                    ],
                  ),
                ),
              ],
            ),
          ),
          const CustomBannerAd(),
          GradientButton(
            onPressed: () {
              ref
                  .read(buildProvider.notifier)
                  .updateBuild(isAramMode, championName, role);
            },
            child: const Text(
              'Reroll',
              style: TextStyle(
                fontFamily: 'Nunito',
                fontWeight: FontWeight.w500,
                fontSize: 16,
                color: Colors.black,
              ),
              textAlign: TextAlign.center,
            ),
          ),
          const SizedBox(height: 20),
        ],
      ),
    );
  }
}
