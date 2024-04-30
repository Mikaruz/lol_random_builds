class Champion {
  String id;
  String name;
  String title;
  String imageUrl;
  bool canBuyBoots;
  String rangeType;
  String resourceType;
  bool hasImmobilizingEffects;

  Champion({
    required this.id,
    required this.name,
    required this.title,
    required this.imageUrl,
    required this.canBuyBoots,
    required this.rangeType,
    required this.resourceType,
    required this.hasImmobilizingEffects,
  });
}
