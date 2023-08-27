import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:hive/hive.dart';
import 'package:pokemon_stats/screens/fullPokemonDetail/full_pokemon_detail_screen.dart';
import 'package:pokemon_stats/services/pokemon/pokemon_service.dart';

import '../../models/pokemon/pokemon_detail_model.dart';

class PokemonDetailsController extends ChangeNotifier {
  final List<PokemonDetailModel> _pokemonList = [];
  List<PokemonDetailModel> get pokemonList {
    return switch (currentTab) {
      0 => _userPokemonList + _pokemonList,
      1 => _userPokemonList,
      2 => (_userPokemonList + _pokemonList).where((element) => element.isFavourite).toList(),
      _ => _userPokemonList + _pokemonList,
    };
  }

  final List<PokemonDetailModel> _userPokemonList = [];

  int _offset = 0;
  int currentTab = 0;

  bool isLoading = false;

  final basicPokemonDetailsService = PokemonService.instance;

  PokemonDetailsController() {
    initialFetch();
  }

  void setLoading(bool newValue) {
    isLoading = newValue;
    notifyListeners();
  }

  initialFetch() async {
    await fetchBasicPokemonListFromCache();
    if (_pokemonList.isNotEmpty) {
      _offset = _pokemonList.last.id;
    }
    await fetchBasicPokemonListFromApi();
  }

  Future<void> fetchBasicPokemonListFromCache() async {
    setLoading(true);
    final pokemonBox = await Hive.openBox<PokemonDetailModel>("userPokemonBox");
    _userPokemonList.addAll(pokemonBox.values);
    final apiPokemonBox = await Hive.openBox<PokemonDetailModel>("apiPokemonBox");
    _pokemonList.addAll(apiPokemonBox.values);
    setLoading(false);
  }

  Future<void> fetchBasicPokemonListFromApi() async {
    setLoading(true);
    final response =
        await basicPokemonDetailsService.getPokemonList({'offset': _offset, 'limit': 10});
    setLoading(false);
    response.fold((l) => Fluttertoast.showToast(msg: l.errorMsg), (r) async {
      _pokemonList.addAll(r);
      final pokemonBox = await Hive.openBox<PokemonDetailModel>("apiPokemonBox");
      pokemonBox.addAll(r);
      for (int i = 0; i < r.length; i++) {
        var pokemon = r[i];
        fetchFullPokemonDetail(pokemon.id, i + _pokemonList.length - 10);
      }
      _offset += 10;
      notifyListeners();
    });
  }

  Future<void> fetchFullPokemonDetail(int id, int index) async {
    final pokemonBox = await Hive.openBox<PokemonDetailModel>("apiPokemonBox");
    final res = await basicPokemonDetailsService.getPokemonFromId(id);
    res.fold((l) => Fluttertoast.showToast(msg: l.errorMsg), (r) {
      _pokemonList[index] = r;
      pokemonBox.putAt(index, r);
    });
    notifyListeners();
  }

  Future<void> addUserPokemon(PokemonDetailModel pokemon) async {
    _userPokemonList.add(pokemon);
    final pokemonBox = await Hive.openBox<PokemonDetailModel>("userPokemonBox");
    await pokemonBox.add(pokemon);
    notifyListeners();
  }

  Future<void> setFavouritePokemon(PokemonDetailModel pokemon) async {
    pokemon.isFavourite = !pokemon.isFavourite;
    if (_pokemonList.contains(pokemon)) {
      final pokemonBox = await Hive.openBox<PokemonDetailModel>("apiPokemonBox");
      pokemonBox.putAt(_pokemonList.indexOf(pokemon), pokemon);
    } else {
      final pokemonBox = await Hive.openBox<PokemonDetailModel>("userPokemonBox");
      pokemonBox.putAt(_userPokemonList.indexOf(pokemon), pokemon);
    }

    notifyListeners();
  }

  void navigateToFullPokemonScreen(BuildContext context, PokemonDetailModel pokemon) {
    Navigator.push(
        context, MaterialPageRoute(builder: (_) => FullPokemonDetailScreen(pokemon: pokemon)));
  }

  void switchTabs(int i) {
    currentTab = i;
    notifyListeners();
  }
}
