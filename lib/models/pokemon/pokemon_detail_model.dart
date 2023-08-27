import 'package:hive/hive.dart';

part 'pokemon_detail_model.g.dart';

@HiveType(typeId: 1)
class PokemonDetailModel {
  @HiveField(0)
  final int id;

  @HiveField(1)
  final String name;

  @HiveField(2)
  final int height;

  @HiveField(3)
  final int weight;

  @HiveField(4)
  final int baseExperience;

  @HiveField(5)
  final String types;

  @HiveField(6)
  final String abilities;

  @HiveField(7)
  final String moves;

  @HiveField(8)
  final String species;

  @HiveField(9)
  final String sprite;

  @HiveField(10)
  bool isFavourite = false;

  PokemonDetailModel({
    required this.id,
    required this.name,
    required this.height,
    required this.weight,
    required this.baseExperience,
    required this.types,
    required this.abilities,
    required this.moves,
    required this.species,
    required this.sprite,
  });

  factory PokemonDetailModel.fromJson(Map<String, dynamic> json) => PokemonDetailModel(
        id: json["id"] ?? getIDFromUrl(json['url']),
        name: json["name"],
        height: json["height"] ?? 0,
        weight: json["weight"] ?? 0,
        baseExperience: json["base_experience"] ?? 0,
        types: _getTypes(json['types']),
        abilities: _getAbilities(json['abilities']),
        moves: _getMoves(json['moves']),
        species: json['species']?['name'] ?? "",
        sprite: json['sprites']?['front_default'] ?? "",
      );

  static int getIDFromUrl(String url) {
    List temp = url.split("/")..removeLast();
    return int.parse(temp.last.toString());
  }

  static String _getTypes(List? types) {
    if (types == null) return "";
    if (types.isEmpty) return "";
    return types.map((x) => (x["type"]?["name"] ?? "").toString()).toList().join(", ");
  }

  static String _getAbilities(List? abilities) {
    if (abilities == null) return "";
    if (abilities.isEmpty) return "";
    return abilities.map((x) => (x["ability"]?["name"] ?? "").toString()).toList().join(", ");
  }

  static String _getMoves(List? moves) {
    if (moves == null) return "";
    if (moves.isEmpty) return "";
    return moves.map((x) => (x["move"]?["name"] ?? "").toString()).toList().join(", ");
  }
}
