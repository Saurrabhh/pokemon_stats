import 'package:fpdart/fpdart.dart';
import 'package:pokemon_stats/constants/api_constants.dart';
import 'package:pokemon_stats/constants/typedefs.dart';
import 'package:pokemon_stats/models/network/network_request.dart';
import 'package:pokemon_stats/models/pokemon/pokemon_detail_model.dart';
import 'package:pokemon_stats/services/network/base_network_service.dart';

class PokemonService extends BaseNetworkService {
  static PokemonService instance = PokemonService();
  FutureEither<List<PokemonDetailModel>> getPokemonList(Map<String, dynamic> queryParams) async {
    final request = NetworkRequest(
        url: pokemonEndpoint, requestMethod: RequestMethod.get, queryParams: queryParams);

    final response = await networkManager.perform(request);

    return response.fold((l) => Either.left(l), (r) {
      final jsonList = r.data['results'] as List;
      return Either.right(
          List.generate(jsonList.length, (index) => PokemonDetailModel.fromJson(jsonList[index])));
    });
  }

  FutureEither<PokemonDetailModel> getPokemonFromId(int id) async {
    final request = NetworkRequest(
      url: "$pokemonEndpoint/$id",
      requestMethod: RequestMethod.get,
    );

    final response = await networkManager.perform(request);

    return response.fold(
        (l) => Either.left(l), (r) => Either.right(PokemonDetailModel.fromJson(r.data)));
  }
}
