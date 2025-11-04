import 'package:flutter_test/flutter_test.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:hola_mundo/src/providers/pokemon_list_notifier.dart';

void main() {
  test('PokemonListNotifier carga pokemones correctamente', () async {
    final container = ProviderContainer();
    final notifier = container.read(pokemonListNotifierProvider.notifier);

    // Ejecuta build()
    final pokemons = await notifier.build();

    expect(pokemons, isNotEmpty);
    expect(pokemons.first.name, isNotEmpty);
  });
}