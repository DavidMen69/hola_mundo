import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../api/poke_api_client.dart';
import '../models/pokemon_model.dart';
import '../../domain/repositories/pokemon_repository.dart';
import 'package:dio/dio.dart';

class PokemonRepositoryImpl implements PokemonRepository {
  final PokeApiClient client;
  PokemonRepositoryImpl(this.client);

  @override
  Future<List<PokemonListItem>> getPokemonPage({
    int limit = 20,
    int offset = 0,
  }) =>
      client.fetchPokemonPage(limit: limit, offset: offset);

  @override
  Future<Pokemon> getPokemonDetail(String nameOrId) async {
    try {
      final response = await Dio().get(
        'https://pokeapi.co/api/v2/pokemon/$nameOrId',
      );
      return Pokemon.fromJson(response.data);
    } catch (e) {
      throw Exception('Error al obtener el detalle del Pokémon: $e');
    }
  }

  /// Carga sin paginacion
  Future<List<PokemonListItem>> fetchAllPokemons({int limit = 1000}) async {
    final dio = Dio();
    try {
      final response = await dio.get('https://pokeapi.co/api/v2/pokemon?limit=$limit');
      final results = response.data['results'] as List;
      return results.map((e) => PokemonListItem.fromJson(e)).toList();
    } catch (e) {
      throw Exception('Error al obtener todos los Pokémon: $e');
    }
  }
}

/// Provider para usar con Riverpod
final pokemonRepositoryImplProvider = Provider<PokemonRepositoryImpl>((ref) {
  final apiClient = PokeApiClient();
  return PokemonRepositoryImpl(apiClient);
});
