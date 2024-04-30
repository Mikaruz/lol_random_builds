import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:lol_random_builds/presentation/providers/build_provider.riverpod.dart';

class CustomDropdownButton extends ConsumerStatefulWidget {
  const CustomDropdownButton({super.key});

  @override
  CustomDropdownButtonState createState() => CustomDropdownButtonState();
}

class CustomDropdownButtonState extends ConsumerState<CustomDropdownButton> {
  String valueChoose = 'Random';
  List<String> listItem = <String>[
    'Random',
    'Top',
    'Jungle',
    'Mid',
    'ADC',
    'Support',
  ];

  @override
  Widget build(BuildContext context) {
    final isAramMode = ref.watch(isAramModeProvider);
    return Container(
      width: 370,
      padding: const EdgeInsets.symmetric(horizontal: 8),
      decoration: BoxDecoration(
        border: Border.all(width: 1, color: const Color(0xFF858585)),
        borderRadius: BorderRadius.circular(8.0),
      ),
      child: DropdownButton<String>(
        hint: const Text('Select a role'),
        isExpanded: true,
        value: valueChoose,
        icon: const Icon(Icons.keyboard_arrow_down),
        elevation: 16,
        underline: const SizedBox(),
        onChanged: !isAramMode
            ? (String? newValue) {
                setState(() {
                  valueChoose = newValue!;
                  ref
                      .read(roleProvider.notifier)
                      .update((state) => valueChoose);
                });
              }
            : null,
        items: listItem.map((String valueItem) {
          return DropdownMenuItem<String>(
            value: valueItem,
            child: Text(valueItem),
          );
        }).toList(),
      ),
    );
  }
}
