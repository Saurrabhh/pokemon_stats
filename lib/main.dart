import 'package:flutter/material.dart';
import 'package:hive_flutter/adapters.dart';
import 'package:pokemon_stats/common/providers/pokemon_details_controller.dart';
import 'package:pokemon_stats/models/pokemon/pokemon_detail_model.dart';
import 'package:pokemon_stats/screens/main_dashboard/main_dashboard_screen.dart';
import 'package:provider/provider.dart';

Future<void> main() async {
  await Hive.initFlutter();
  Hive.registerAdapter(PokemonDetailModelAdapter());
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (_) => PokemonDetailsController(),
          lazy: false,
        ),
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Flutter Demo',
        theme: ThemeData(
          colorScheme: ColorScheme.fromSeed(seedColor: Colors.yellow),
          useMaterial3: true,
        ),
        home: const MainDashboardScreen(),
      ),
    );
  }
}
