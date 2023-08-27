import 'package:flutter/material.dart';
import 'package:pokemon_stats/common/providers/pokemon_details_controller.dart';
import 'package:pokemon_stats/models/pokemon/pokemon_detail_model.dart';
import 'package:provider/provider.dart';

class PokemonCard extends StatelessWidget {
  const PokemonCard({super.key, required this.pokemon});
  final PokemonDetailModel pokemon;

  @override
  Widget build(BuildContext context) {
    final controller = Provider.of<PokemonDetailsController>(context, listen: false);
    return GestureDetector(
      onTap: () => controller.navigateToFullPokemonScreen(context, pokemon),
      child: Card(
        elevation: 10,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(8.0),
        ),
        child: Padding(
          padding: const EdgeInsets.all(10),
          child: Stack(
            fit: StackFit.expand,
            alignment: AlignmentDirectional.center,
            children: [
              if (pokemon.sprite.isNotEmpty && pokemon.sprite.contains("http"))
                ClipRRect(
                    borderRadius: const BorderRadius.all(Radius.circular(8.0)),
                    child: Hero(
                      tag: pokemon.id.toString() + pokemon.name,
                      child: Image.network(
                        pokemon.sprite,
                        width: double.infinity,
                        fit: BoxFit.contain,
                        errorBuilder: (context, err, _) => const SizedBox(
                          child: Center(child: Text("No Image")),
                        ),
                        loadingBuilder: (_, child, loadingProgress) {
                          return loadingProgress == null ? child : Image.network(pokemon.sprite);
                        },
                      ),
                    ))
              else
                const SizedBox(
                  child: Center(
                    child: Text("No Image"),
                  ),
                ),
              Positioned(
                bottom: 10,
                child: Text(
                  pokemon.name,
                  style: const TextStyle(fontSize: 20),
                ),
              ),
              Positioned(
                top: 0,
                right: 0,
                child: IconButton(
                  onPressed: () => controller.setFavouritePokemon(pokemon),
                  icon: Icon(
                    Icons.catching_pokemon,
                    size: 30,
                    color: pokemon.isFavourite ? Colors.red : Colors.black,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
