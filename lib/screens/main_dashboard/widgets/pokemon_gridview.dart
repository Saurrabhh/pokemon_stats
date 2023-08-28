import 'package:flutter/material.dart';
import 'package:pokemon_stats/common/providers/pokemon_details_controller.dart';
import 'package:pokemon_stats/screens/main_dashboard/widgets/pokemon_card.dart';
import 'package:provider/provider.dart';

class PokemonGridView extends StatelessWidget {
  const PokemonGridView({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Provider.of<PokemonDetailsController>(context);
    return Column(
      children: [
        GridView.builder(
          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 2,
            crossAxisSpacing: 8.0,
            mainAxisSpacing: 8.0,
            childAspectRatio: 3 / 4,
          ),
          physics: const NeverScrollableScrollPhysics(),
          itemCount: controller.pokemonList.length,
          shrinkWrap: true,
          itemBuilder: (context, index) => PokemonCard(
            pokemon: controller.pokemonList[index],
          ),
        ),
        const SizedBox(height: 10),
        if (controller.isLoading) const CircularProgressIndicator(),
      ],
    );
  }
}
