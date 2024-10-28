import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:pokeman_cg_sdk/pokeman_cg_sdk.dart';
import 'package:http/http.dart' as http;

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await dotenv.load(fileName: ".env");
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Pokemon TCG',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: const HomeScreen(
        title: 'Pokemon TCG',
      ),
    );
  }
}

class HomeScreen extends StatefulWidget {
  final String title;
  const HomeScreen({
    super.key,
    required this.title,
  });

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final api = PokemonTcgApi(
      apiKey: dotenv.get('POKEMON_TCG_API_KEY'), client: http.Client());
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: FutureBuilder<List<PokemonCard>>(
          future: api.getCards(),
          builder: (_, snapshot) {
            if (snapshot.hasData) {
              return GridView.builder(
                padding:
                    const EdgeInsets.symmetric(horizontal: 14, vertical: 10),
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisSpacing: 15,
                    mainAxisSpacing: 10,
                    childAspectRatio: .63,
                    crossAxisCount: 2),
                itemCount: snapshot.data!.length,
                itemBuilder: (_, i) {
                  PokemonCard pokemon = snapshot.data![i];
                  return CachedNetworkImage(
                    imageUrl: pokemon.images.large,
                    imageBuilder: (context, imageProvider) => Container(
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10),
                        image: DecorationImage(
                          image: imageProvider,
                          fit: BoxFit.fill,
                        ),
                      ),
                    ),
                    placeholder: (context, url) =>
                        const Center(child: CircularProgressIndicator()),
                    errorWidget: (context, url, error) =>
                        const Center(child: Icon(Icons.error)),
                  );
                },
              );
            }
            if (snapshot.hasError) {
              return Text(snapshot.error.toString());
            }
            return const Center(child: CircularProgressIndicator());
          }),
    );
  }
}
