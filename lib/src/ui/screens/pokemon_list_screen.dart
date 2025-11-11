import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../providers/pokemon_list_notifier.dart';
import 'pokemon_detail_screen.dart';

class PokemonListScreen extends ConsumerWidget {
  const PokemonListScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final pokemonListAsync = ref.watch(pokemonListNotifierProvider);
    final notifier = ref.read(pokemonListNotifierProvider.notifier);

    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Pokédex',
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
        centerTitle: true,
        backgroundColor: Colors.redAccent,
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(12),
            child: TextField(
              onChanged: (query) => notifier.searchPokemon(query),
              decoration: InputDecoration(
                hintText: 'Buscar Pokémon...',
                prefixIcon: const Icon(Icons.search),
                filled: true,
                fillColor: Colors.white,
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(30),
                  borderSide: BorderSide.none,
                ),
              ),
            ),
          ),
          Expanded(
            child: pokemonListAsync.when(
              data: (pokemons) {
                if (pokemons.isEmpty) {
                  return const Center(child: Text('No se encontraron Pokémon.'));
                }
                return GridView.builder(
                  padding: const EdgeInsets.all(10),
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2,
                    mainAxisSpacing: 12,
                    crossAxisSpacing: 12,
                    childAspectRatio: 1.1,
                  ),
                  itemCount: pokemons.length,
                  itemBuilder: (context, index) {
                    final p = pokemons[index];
                    final id = p.id;
                    final imageUrl =
                        'https://raw.githubusercontent.com/PokeAPI/sprites/master/sprites/pokemon/$id.png';

                    return GestureDetector(
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (_) =>
                                PokemonDetailScreen(nameOrId: p.name),
                          ),
                        );
                      },
                      child: Card(
                        elevation: 4,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(16),
                        ),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Hero(
                              tag: 'pokemon_${p.name}',
                              child: Image.network(
                                imageUrl,
                                height: 90,
                                width: 90,
                                fit: BoxFit.contain,
                                errorBuilder: (context, _, __) => const Icon(
                                  Icons.broken_image,
                                  size: 70,
                                ),
                              ),
                            ),
                            const SizedBox(height: 8),
                            Text(
                              p.name[0].toUpperCase() + p.name.substring(1),
                              style: const TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                          ],
                        ),
                      ),
                    );
                  },
                );
              },
              loading: () => const Center(child: CircularProgressIndicator()),
              error: (e, _) => Center(child: Text('Error: $e')),
            ),
          ),
        ],
      ),
    );
  }
}
