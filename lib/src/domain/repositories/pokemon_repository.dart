import '../../data/models/pokemon_model.dart';

abstract class PokemonRepository {
  Future<List<PokemonListItem>> getPokemonPage({int limit = 20, int offset = 0});
  Future<Pokemon> getPokemonDetail(String nameOrId);
}