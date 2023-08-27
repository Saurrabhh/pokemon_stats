import 'package:flutter/cupertino.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:pokemon_stats/common/providers/pokemon_details_controller.dart';
import 'package:pokemon_stats/models/pokemon/pokemon_detail_model.dart';
import 'package:provider/provider.dart';

class AddNewPokemonController extends ChangeNotifier {
  final TextEditingController nameController = TextEditingController();
  final TextEditingController heightController = TextEditingController();
  final TextEditingController weightController = TextEditingController();
  final TextEditingController baseExperienceController = TextEditingController();
  final TextEditingController typesController = TextEditingController();
  final TextEditingController abilitiesController = TextEditingController();
  final TextEditingController movesController = TextEditingController();
  final TextEditingController speciesController = TextEditingController();
  final TextEditingController spriteController = TextEditingController();

  bool validate() {
    if (nameController.text.isEmpty) {
      return false;
    }
    if (heightController.text.isEmpty) {
      return false;
    }
    if (weightController.text.isEmpty) {
      return false;
    }
    if (baseExperienceController.text.isEmpty) {
      return false;
    }
    if (typesController.text.isEmpty) {
      return false;
    }
    if (abilitiesController.text.isEmpty) {
      return false;
    }
    if (movesController.text.isEmpty) {
      return false;
    }
    if (speciesController.text.isEmpty) {
      return false;
    }
    if (spriteController.text.isEmpty) {
      return false;
    }
    return true;
  }

  void submit(BuildContext context) {
    if (!validate()) {
      Fluttertoast.showToast(msg: "Enter all details");
      return;
    }

    final newPokemon = PokemonDetailModel(
        id: 0,
        name: nameController.text,
        height: int.parse(heightController.text),
        weight: int.parse(weightController.text),
        baseExperience: int.parse(baseExperienceController.text),
        types: typesController.text,
        abilities: abilitiesController.text,
        moves: movesController.text,
        species: speciesController.text,
        sprite: spriteController.text);
    final pokemonController = Provider.of<PokemonDetailsController>(context, listen: false);
    pokemonController.addUserPokemon(newPokemon);
    Navigator.pop(context);
  }
}
