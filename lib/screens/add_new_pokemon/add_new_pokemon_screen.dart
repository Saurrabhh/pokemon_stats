import 'package:flutter/material.dart';
import 'package:pokemon_stats/screens/add_new_pokemon/add_new_pokemon_controller.dart';
import 'package:pokemon_stats/screens/base_view.dart';

import '../../common/widgets/custom_textfield.dart';

class AddNewPokemonScreen extends StatefulWidget {
  const AddNewPokemonScreen({super.key});

  @override
  State<AddNewPokemonScreen> createState() => _AddNewPokemonScreenState();
}

class _AddNewPokemonScreenState extends State<AddNewPokemonScreen> {
  late final AddNewPokemonController controller;
  @override
  void initState() {
    controller = AddNewPokemonController();
    super.initState();
  }

  @override
  void dispose() {
    controller.nameController.dispose();
    controller.heightController.dispose();
    controller.weightController.dispose();
    controller.baseExperienceController.dispose();
    controller.typesController.dispose();
    controller.abilitiesController.dispose();
    controller.movesController.dispose();
    controller.speciesController.dispose();
    controller.spriteController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BaseView(
      controller: controller,
      builder: (context, controller, _) => Scaffold(
        appBar: AppBar(
          title: const Text("Add a new Pokemon"),
        ),
        body: SingleChildScrollView(
          child: Column(
            children: [
              CustomTextField(
                controller: controller.nameController,
                label: "Name",
              ),
              Row(
                children: [
                  Expanded(
                    child: CustomTextField(
                      controller: controller.heightController,
                      label: "Height",
                      keyboardType: TextInputType.number,
                    ),
                  ),
                  Expanded(
                    child: CustomTextField(
                      controller: controller.weightController,
                      label: "Weight",
                      keyboardType: TextInputType.number,
                    ),
                  ),
                ],
              ),
              CustomTextField(
                controller: controller.baseExperienceController,
                label: "Base Experience",
                keyboardType: TextInputType.number,
              ),
              CustomTextField(
                controller: controller.typesController,
                label: "Types",
              ),
              CustomTextField(
                controller: controller.abilitiesController,
                label: "Abilities",
              ),
              CustomTextField(
                controller: controller.movesController,
                label: "Moves",
              ),
              CustomTextField(
                controller: controller.speciesController,
                label: "Species",
              ),
              CustomTextField(
                controller: controller.spriteController,
                label: "Image Url",
              ),
              ElevatedButton(
                onPressed: () => controller.submit(context),
                child: const Text("Submit"),
              )
            ],
          ),
        ),
      ),
    );
  }
}
