import 'package:flutter_test/flutter_test.dart';
import 'package:hola_mundo/src/data/repositories/pokemon_repository_impl.dart';
import 'package:hola_mundo/src/data/api/poke_api_client.dart';

void main() {
  group('PokemonRepository Tests', () {
    final repo = PokemonRepositoryImpl(PokeApiClient());

    test('getPokemonPage() debería devolver una lista de Pokémon', () async {
      final pokemons = await repo.getPokemonPage(limit: 5, offset: 0);
      expect(pokemons, isNotEmpty);
      expect(pokemons.first.name, isNotNull);
    });
  });
}