import 'package:flutter/material.dart';
import 'package:cached_network_image/cached_network_image.dart';
import '../../providers/pokemon_providers.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class PokemonDetailScreen extends ConsumerWidget {
  final String nameOrId;

  const PokemonDetailScreen({
    super.key,
    required this.nameOrId,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final detailAsync = ref.watch(pokemonDetailProvider(nameOrId));

    return Scaffold(
      appBar: AppBar(
        title: Text(nameOrId.toUpperCase()),
        backgroundColor: Colors.red.shade400,
      ),
      body: detailAsync.when(
        loading: () => const Center(child: CircularProgressIndicator()),
        error: (e, _) => Center(
          child: Text('Error al cargar Pokémon: $e'),
        ),
        data: (pokemon) => SingleChildScrollView(
          padding: const EdgeInsets.all(16),
          child: Column(
            children: [
              // Imagen del Pokémon
              Hero(
                tag: pokemon.name,
                child: CachedNetworkImage(
                  imageUrl: pokemon.spriteUrl ?? '',
                  height: 150,
                  fit: BoxFit.contain,
                  placeholder: (context, _) => const CircularProgressIndicator(),
                  errorWidget: (context, _, __) => const Icon(Icons.error, size: 50),
                ),
              ),

              // Nombre
              Text(
                pokemon.name.toUpperCase(),
                style: const TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 8),

              // Tipos
              Wrap(
                alignment: WrapAlignment.center,
                spacing: 8,
                children: pokemon.types
                    .map((t) => Chip(
                          label: Text(t),
                          backgroundColor: Colors.red.shade100,
                        ))
                    .toList(),
              ),
              const SizedBox(height: 16),

              // Habilidades
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    'Habilidades:',
                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.w600),
                  ),
                  const SizedBox(height: 4),
                  ...pokemon.abilities.map((a) => Text('• $a')).toList(),
                ],
              ),
              const SizedBox(height: 16),

              // Estadísticas
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    'Estadísticas:',
                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.w600),
                  ),
                  const SizedBox(height: 4),
                  ...pokemon.stats.entries.map((e) => Padding(
                        padding: const EdgeInsets.symmetric(vertical: 2),
                        child: Row(
                          children: [
                            Expanded(flex: 2, child: Text(e.key)),
                            Expanded(
                              flex: 3,
                              child: LinearProgressIndicator(
                                value: e.value / 100,
                                backgroundColor: Colors.grey.shade200,
                                color: Colors.red.shade400,
                              ),
                            ),
                            const SizedBox(width: 8),
                            Text('${e.value}'),
                          ],
                        ),
                      )),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}