import 'package:fpdart/fpdart.dart';
import 'package:pokemon_stats/models/failure.dart';
import 'package:pokemon_stats/models/network/network_response.dart';

typedef FutureEither<T> = Future<Either<Failure, T>>;
typedef FutureEitherVoid = FutureEither<void>;
typedef FutureEitherApiResponse = FutureEither<ApiSuccess>;
