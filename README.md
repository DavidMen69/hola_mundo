# 📱 Pokédex Flutter

Una aplicación Flutter que muestra una lista de Pokémon obtenidos desde la [PokeAPI](https://pokeapi.co/).  
Incluye scroll infinito, búsqueda, animaciones y detalles individuales de cada Pokémon.

---

## 🚀 Instalación y ejecución

1. **Clona el repositorio:**
   ```bash
   git clone https://github.com/DavidMen69/hola_mundo.git


2.Entra en el proyecto:
    cd pokedex-flutter

3.Instala las dependencias:
    flutter pub get

4.Ejecuta la app:
    flutter run


5. 🧪 Ejecución de pruebas  
    flutter test


6. 🧱 Estructura del proyecto
        lib/
    ├── data/
    │   └── models/              # Modelos de datos
    ├── domain/
    │   └── repositories/        # Lógica de negocio y acceso a datos
    ├── providers/               # Providers de Riverpod
    ├── ui/
    │   └── screens/             # Pantallas principales
    test/
    ├── pokemon_repository_test.dart
    └── pokemon_list_notifier_test.dart


7. ⚙️ Tecnologías y librerías utilizadas

    Flutter 3.x

    Riverpod → manejo de estado reactivo.

    CachedNetworkImage → carga optimizada de imágenes.

    PokeAPI → fuente de datos.

    SliverAppBar & Hero widgets → animaciones fluidas.

    AsyncNotifier → control asíncrono de listas con paginación.


8. 🧠 Decisiones técnicas

    Arquitectura modular:
    Separé el proyecto en capas (data, domain, ui) para mantener el código limpio y escalable.

    Uso de Riverpod:
    Elegido por su simplicidad y potencia en comparación con Provider o Bloc, ideal para manejar estados asíncronos (loading/error/data).

    Paginación infinita:
    Se implementó ScrollController y AsyncNotifier para cargar más Pokémon al llegar al final del scroll.

    SliverAppBar + Hero:
    Para lograr transiciones suaves y diseño tipo Pokédex real.

    Pruebas unitarias:
    Se incluyeron tests básicos de repositorio y lógica de estado para garantizar la estabilidad del código base.


9. 🧑‍💻 Autor

David Mendoza
📧 contacto: davidmenher17@gmail.com

💻 Desarrollador Flutter | Entusiasta de la PokeAPI