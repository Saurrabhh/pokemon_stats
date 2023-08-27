import 'package:flutter/material.dart';
import 'package:pokemon_stats/models/pokemon/pokemon_detail_model.dart';

class FullPokemonDetailScreen extends StatelessWidget {
  const FullPokemonDetailScreen({
    super.key,
    required this.pokemon,
  });
  final PokemonDetailModel pokemon;

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          centerTitle: true,
          title: const Text("Full Pokemon Details Page"),
        ),
        body: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Center(
                    child: Text(
                      pokemon.name,
                      style: const TextStyle(fontSize: 25),
                    ),
                  ),
                ),
                Center(
                  child: Text(
                    "Base Exp: ${pokemon.baseExperience}",
                    style: const TextStyle(fontSize: 15),
                  ),
                ),
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
                    ),
                  ),
                Center(
                  child: Text(
                    "Species: ${pokemon.species}",
                    style: const TextStyle(fontSize: 18),
                  ),
                ),
                const SizedBox(height: 5),
                Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Expanded(child: LabelChip(label: "Height", data: pokemon.height.toString())),
                    Expanded(child: LabelChip(label: "Weight", data: pokemon.weight.toString())),
                  ],
                ),
                DataListWithHeading(
                  label: "Types",
                  data: pokemon.types,
                ),
                DataListWithHeading(
                  label: "Abilities",
                  data: pokemon.abilities,
                ),
                DataListWithHeading(
                  label: "Moves",
                  data: pokemon.moves,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class LabelChip extends StatelessWidget {
  const LabelChip({super.key, required this.label, required this.data});
  final String label;
  final String data;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        Text(
          "$label:",
          style: const TextStyle(fontSize: 18),
        ),
        const SizedBox(width: 10),
        Chip(label: Text(data)),
      ],
    );
  }
}

class DataListWithHeading extends StatelessWidget {
  const DataListWithHeading({super.key, required this.label, required this.data});
  final String label;
  final String data;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            "$label:",
            style: const TextStyle(fontSize: 23, fontWeight: FontWeight.bold),
          ),
          Wrap(
            children: data
                .split(", ")
                .map((e) => Card(
                        child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Text(e),
                    )))
                .toList(),
          )
        ],
      ),
    );
  }
}
