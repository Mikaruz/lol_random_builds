import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:lol_random_builds/presentation/ads/custom_banner_ad.dart';
import 'package:lol_random_builds/presentation/providers/build_provider.riverpod.dart';
import 'package:lol_random_builds/presentation/widgets/widgets.dart';

const simpleTextStyles = TextStyle(
  fontFamily: 'Nunito',
  fontWeight: FontWeight.normal,
  fontSize: 16,
);

class WelcomeScreen extends ConsumerWidget {
  const WelcomeScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final championName = ref.watch(championNameProvider);
    final isAramMode = ref.watch(isAramModeProvider);
    final role = ref.watch(roleProvider);

    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Text(
              'Lol Random Builds',
              style: TextStyle(
                fontFamily: 'Nunito',
                fontWeight: FontWeight.w500,
                fontSize: 32,
              ),
              textAlign: TextAlign.center,
            ),
            const CustomBannerAd(),
            const SizedBox(height: 50),
            const _CustomInput(
              text: 'Select game mode:',
            ),
            const CustomToggleSwitch(),
            const _CustomInput(
              text: 'Select a campion:',
            ),
            const CustomAutoComplete(),
            const _CustomInput(
              text: 'Select a role:',
            ),
            const CustomDropdownButton(),
            const SizedBox(height: 50),
            GradientButton(
              onPressed: () {
                ref
                    .read(buildProvider.notifier)
                    .updateBuild(isAramMode, championName, role);
                context.push('/build-random');
              },
              child: const Text(
                'Generate Build',
                style: TextStyle(
                  fontFamily: 'Nunito',
                  fontWeight: FontWeight.w500,
                  fontSize: 16,
                  color: Colors.black,
                ),
                textAlign: TextAlign.center,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _CustomInput extends StatelessWidget {
  const _CustomInput({
    required this.text,
  });

  final String text;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(top: 20),
      padding: const EdgeInsets.symmetric(horizontal: 20),
      height: 35,
      width: double.maxFinite,
      child: Text(
        text,
        style: simpleTextStyles,
      ),
    );
  }
}
