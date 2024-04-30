import 'package:lol_random_builds/domain/entities/item.dart';

class ItemMapper {
  static jsonToEntity(Map<String, dynamic> json) => Item(
        name: json['itemName'],
        imageUrl: 'assets/images/items/${json['icon']}',
        isStarter: json['isStarter'],
        isBoots: json['isBoots'],
        isLegendary: json['isLegendary'],
        isAramMode: json['isAramMode'],
      );
}
