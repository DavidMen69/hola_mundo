import 'package:flutter/material.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../data/models/pokemon_model.dart';
import '../../providers/pokemon_providers.dart';

class PokemonDetailScreen extends ConsumerWidget {
  final String nameOrId;

  const PokemonDetailScreen({super.key, required this.nameOrId});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final repo = ref.read(pokemonRepoProvider);

    return FutureBuilder<Pokemon>(
      future: repo.getPokemonDetail(nameOrId),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Scaffold(
            body: Center(child: CircularProgressIndicator()),
          );
        }

        if (snapshot.hasError) {
          return Scaffold(
            body: Center(child: Text('Error: ${snapshot.error}')),
          );
        }

        final pokemon = snapshot.data!;
        final color = _typeColor(pokemon.types.first);

        return Scaffold(
          backgroundColor: color.withOpacity(0.2),
          body: CustomScrollView(
            slivers: [
              SliverAppBar(
                backgroundColor: color,
                pinned: true,
                expandedHeight: 300,
                flexibleSpace: FlexibleSpaceBar(
                  title: Text(
                    pokemon.name.toUpperCase(),
                    style: const TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  background: Hero(
                    tag: pokemon.name,
                    child: CachedNetworkImage(
                      imageUrl:
                          'https://raw.githubusercontent.com/PokeAPI/sprites/master/sprites/pokemon/other/official-artwork/${pokemon.id}.png',
                      fit: BoxFit.contain,
                    ),
                  ),
                ),
              ),
              SliverToBoxAdapter(
                child: Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Wrap(
                        spacing: 8,
                        children: pokemon.types
                            .map((t) => Chip(
                                  label: Text(
                                    t.toUpperCase(),
                                    style: const TextStyle(color: Colors.white),
                                  ),
                                  backgroundColor: _typeColor(t),
                                ))
                            .toList(),
                      ),
                      const SizedBox(height: 24),
                      Text(
                        'Base Stats',
                        style: Theme.of(context)
                            .textTheme
                            .titleLarge!
                            .copyWith(fontWeight: FontWeight.bold),
                      ),
                      const SizedBox(height: 12),
                      ...pokemon.stats.entries.map((entry) => _buildStatBar(entry.key, entry.value)),
                    ],
                  ),
                ),
              ),
            ],
          ),
        );
      },
    );
  }

  Widget _buildStatBar(String statName, int value) {
  final maxStat = 150;
  final percent = (value / maxStat).clamp(0.0, 1.0);
  final statColor = _statColor(statName);

  return Padding(
    padding: const EdgeInsets.symmetric(vertical: 8),
    child: Row(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        // 🟦 Nombre de la estadística (HP, Attack, etc.)
        SizedBox(
          width: 100,
          child: Text(
            statName.toUpperCase(),
            style: TextStyle(
              fontWeight: FontWeight.bold,
              color: statColor, // 💥 ahora el color del texto cambia por tipo de stat
              fontSize: 14,
              letterSpacing: 1.2,
              shadows: [
                Shadow(
                  color: Colors.black.withOpacity(0.3),
                  blurRadius: 2,
                  offset: const Offset(1, 1),
                ),
              ],
            ),
          ),
        ),

        // 🟩 Barra de progreso animada
        Expanded(
          child: Stack(
            children: [
              Container(
                height: 18,
                decoration: BoxDecoration(
                  color: Colors.grey.shade300,
                  borderRadius: BorderRadius.circular(10),
                ),
              ),
              AnimatedContainer(
                duration: const Duration(milliseconds: 600),
                height: 18,
                width: 200 * percent,
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    colors: [
                      statColor.withOpacity(0.8),
                      statColor,
                    ],
                  ),
                  borderRadius: BorderRadius.circular(10),
                  boxShadow: [
                    BoxShadow(
                      color: statColor.withOpacity(0.4),
                      blurRadius: 6,
                      offset: const Offset(0, 3),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),

        const SizedBox(width: 10),

        // 🔢 Valor numérico con color dinámico
        Text(
          value.toString(),
          style: TextStyle(
            fontWeight: FontWeight.bold,
            color: statColor,
            fontSize: 14,
          ),
        ),
      ],
    ),
  );
}


  Color _typeColor(String type) {
    switch (type) {
      case 'fire':
        return Colors.redAccent;
      case 'water':
        return Colors.blueAccent;
      case 'grass':
        return Colors.green;
      case 'electric':
        return Colors.amber;
      case 'psychic':
        return Colors.pinkAccent;
      case 'ice':
        return Colors.cyan;
      case 'dragon':
        return Colors.indigoAccent;
      case 'dark':
        return Colors.brown;
      case 'fairy':
        return Colors.pink;
      case 'ground':
        return Colors.orange;
      case 'rock':
        return Colors.grey;
      case 'bug':
        return Colors.lightGreen;
      case 'poison':
        return Colors.purpleAccent;
      default:
        return Colors.grey.shade600;
    }
  }

  Color _statColor(String statName) {
    switch (statName) {
      case 'hp':
        return Colors.redAccent;
      case 'attack':
        return Colors.orange;
      case 'defense':
        return Colors.yellow.shade700;
      case 'special-attack':
        return Colors.blueAccent;
      case 'special-defense':
        return Colors.greenAccent.shade700;
      case 'speed':
        return Colors.purpleAccent;
      default:
        return Colors.grey;
    }
  }
}
