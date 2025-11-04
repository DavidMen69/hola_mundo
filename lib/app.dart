import 'package:flutter/material.dart';
import 'src/ui/screens/pokemon_list_screen.dart';

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Pokedex',
      theme: ThemeData(
        primarySwatch: Colors.red),
      home: const PokemonListScreen(), 
    );
  }
}