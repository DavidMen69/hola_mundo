import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../data/api/poke_api_client.dart';
import '../data/repositories/pokemon_repository_impl.dart';


final pokeApiClientProvider = Provider((ref) => PokeApiClient());
final pokemonRepoProvider = Provider((ref) => PokemonRepositoryImpl(ref.read(pokeApiClientProvider)));

final pokemonDetailProvider = FutureProvider.family((ref, String nameOrId) async {
  final repo = ref.read(pokemonRepoProvider);
  return repo.getPokemonDetail(nameOrId);
});