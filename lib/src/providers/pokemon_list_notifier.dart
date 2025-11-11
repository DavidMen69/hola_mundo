import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../data/models/pokemon_model.dart';
import '../data/repositories/pokemon_repository_impl.dart';

/// Notifier que maneja la lista completa de Pokémon y la búsqueda
class PokemonListNotifier extends AsyncNotifier<List<PokemonListItem>> {
  List<PokemonListItem> _allPokemons = [];

  @override
  Future<List<PokemonListItem>> build() async {
    final repository = ref.watch(pokemonRepositoryImplProvider);
    _allPokemons = await repository.fetchAllPokemons();
    return _allPokemons;
  }



  /// 🔍 Búsqueda instantánea sin depender del scroll
  void searchPokemon(String query) {
    if (query.isEmpty) {
      state = AsyncData(_allPokemons);
    } else {
      final filtered = _allPokemons
          .where((p) => p.name.toLowerCase().contains(query.toLowerCase()))
          .toList();
      state = AsyncData(filtered);
    }
  }

  /// 🔄 Refrescar lista completa
  Future<void> refreshList() async {
    state = const AsyncLoading();
    ref.invalidateSelf();
  }

  /// (Compatibilidad) — ya no usamos scroll infinito
  void loadMore() {
    // Nada aquí — toda la lista se carga de una vez
  }
}

/// Provider de Riverpod
final pokemonListNotifierProvider =
    AsyncNotifierProvider<PokemonListNotifier, List<PokemonListItem>>(
  () => PokemonListNotifier(),
);
