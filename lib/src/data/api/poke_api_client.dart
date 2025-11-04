import 'dart:convert';
import 'package:http/http.dart' as http;
import '../models/pokemon_model.dart';

class PokeApiClient {
  final http.Client httpClient;
  static const baseUrl = 'https://pokeapi.co/api/v2';

  PokeApiClient({http.Client? httpClient})
    : httpClient = httpClient ?? http.Client();

  Future<Map<String, dynamic>> _getJson(Uri uri) async {
    final res = await httpClient.get(uri);
    if (res.statusCode != 200) {
      throw Exception('HTTP ${res.statusCode}');
    }
    return jsonDecode(res.body) as Map<String, dynamic>;
  }

  Future<List<PokemonListItem>> fetchPokemonPage({
    int limit = 20,
    int offset = 0,
  }) async {
    final uri = Uri.parse('$baseUrl/pokemon?limit=$limit&offset=$offset');
    final json = await _getJson(uri);
    final results = (json['results'] as List?) ?? [];
    return results
        .map((e) => PokemonListItem.fromJson(e as Map<String, dynamic>))
        .toList();
  }

  Future<Pokemon> fetchPokemonDetail(String nameOrId) async {
    final uri = Uri.parse('$baseUrl/pokemon/$nameOrId');
    final json = await _getJson(uri);
    return Pokemon.fromJson(json);
  }
}
