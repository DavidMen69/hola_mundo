import '../api/poke_api_client.dart';
import '../models/pokemon_model.dart';
import '../../domain/repositories/pokemon_repository.dart';

class PokemonRepositoryImpl implements PokemonRepository {
  final PokeApiClient client;
  PokemonRepositoryImpl(this.client);

  @override
  Future<List<PokemonListItem>> getPokemonPage({ int limit = 20, int offset = 0 }) =>
    client.fetchPokemonPage(limit: limit, offset: offset);
  

  @override
  Future<Pokemon> getPokemonDetail(String nameOrId) =>
      client.fetchPokemonDetail(nameOrId);
}
