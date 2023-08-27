import 'package:pokemon_stats/services/network/network_manager.dart';

class BaseNetworkService {
  NetworkManager get networkManager => NetworkManager.instance;
}
