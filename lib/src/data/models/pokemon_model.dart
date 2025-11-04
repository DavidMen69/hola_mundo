class PokemonListItem{
  final String name;
  final String url;
  PokemonListItem({required this.name, required this.url});

  factory PokemonListItem.fromJson(Map<String, dynamic> json) {
    return PokemonListItem(
      name: json['name'] as String? ?? 'unknown',
      url: json['url'] as String? ?? '',
    );
}

String get id {
    final parts = url.split('/');
    return parts.length >= 2 ? parts[parts.length - 2] : '';
  }
}


class Pokemon {
  final int id;
  final String name;
  final String? spriteUrl;
  final List<String> types;
  final List<String> abilities;
  final Map<String, int> stats;

  Pokemon({
    required this.id,
    required this.name,
    this.spriteUrl,
    required this.types,
    required this.abilities,
    required this.stats,
  });

factory Pokemon.fromJson(Map<String, dynamic> json) {
    String? sprite;
    try {
      sprite = (json['sprites'] as Map?)?['front_default'] as String?;
    } catch (_) {
      sprite = null;
    }

    final types = (json['types'] as List?)
            ?.map((t) => (t as Map)['type']['name'] as String)
            .toList() ?? [];

    final abilities = (json['abilities'] as List?)
            ?.map((a) => (a as Map)['ability']['name'] as String)
            .toList() ?? [];

    final statsMap = <String, int>{};
    (json['stats'] as List? ?? []).forEach((s) {
      final m = s as Map;
      final name = (m['stat'] as Map)['name'] as String;
      final value = m['base_stat'] as int;
      statsMap[name] = value;
    });

    return Pokemon(
      id: json['id'] as int? ?? 0,
      name: json['name'] as String? ?? 'unknown',
      spriteUrl: sprite,
      types: types,
      abilities: abilities,
      stats: statsMap,
    );
  }
}