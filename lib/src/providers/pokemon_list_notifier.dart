import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../data/models/pokemon_model.dart';
import 'pokemon_providers.dart';

class PokemonListNotifier extends AsyncNotifier<List<PokemonListItem>> {
  final int _limit = 20;
  int _offset = 0;
  bool _isLoading = false;
  String _searchQuery = '';

  @override
  Future<List<PokemonListItem>> build() async {
    final repo = ref.read(pokemonRepoProvider);
    final pokemons = await repo.getPokemonPage(limit: _limit, offset: _offset);
    _offset += _limit;
    return pokemons;
  }

  Future<void> loadMore() async {
    if (_isLoading || _searchQuery.isNotEmpty) return;
    _isLoading = true;

    try {
      final repo = ref.read(pokemonRepoProvider);
      final newPokemons = await repo.getPokemonPage(limit: _limit, offset: _offset);
      final currentList = state.value ?? [];
      _offset += _limit;
      state = AsyncValue.data([...currentList, ...newPokemons]);
    } catch (e, st) {
      state = AsyncValue.error(e, st);
    } finally {
      _isLoading = false;
    }
  }

  void refreshList() {
    _offset = 0;
    ref.invalidateSelf();
    _searchQuery = '';
  }
  void searchPokemon(String query) {
    _searchQuery = query.toLowerCase();
    final allPokemons = state.value ?? [];
    if (query.isEmpty) {
      refreshList();
    } else {
      final filtered = allPokemons
          .where((p) => p.name.toLowerCase().contains(_searchQuery))
          .toList();
      state = AsyncValue.data(filtered);
    }
  }
}

final pokemonListNotifierProvider =
    AsyncNotifierProvider<PokemonListNotifier, List<PokemonListItem>>(
  () => PokemonListNotifier(),
);