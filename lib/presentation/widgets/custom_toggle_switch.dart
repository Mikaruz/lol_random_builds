import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:lol_random_builds/presentation/providers/build_provider.riverpod.dart';
import 'package:toggle_switch/toggle_switch.dart';

class CustomToggleSwitch extends ConsumerWidget {
  const CustomToggleSwitch({
    super.key,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final isAramMode = ref.watch(isAramModeProvider);
    final initialLabel = isAramMode ? 1 : 0;

    return ToggleSwitch(
      minWidth: 200,
      minHeight: 50,
      cornerRadius: 18.0,
      activeBgColors: const [
        [Color(0xFF219DCC)],
        [Color(0xFF0BC6E3)],
      ],
      customTextStyles: const [
        TextStyle(
            fontFamily: 'Nunito',
            fontWeight: FontWeight.normal,
            fontSize: 16,
            color: Colors.white),
      ],
      activeFgColor: Colors.white,
      inactiveBgColor: Colors.grey,
      inactiveFgColor: Colors.white,
      initialLabelIndex: initialLabel,
      totalSwitches: 2,
      labels: const ['Normal', 'Aram'],
      radiusStyle: true,
      onToggle: (index) {
        ref.read(isAramModeProvider.notifier).update((state) => !state);
      },
    );
  }
}
