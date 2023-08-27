import 'package:flutter/material.dart';
import 'package:pokemon_stats/common/providers/pokemon_details_controller.dart';
import 'package:pokemon_stats/screens/add_new_pokemon/add_new_pokemon_screen.dart';
import 'package:pokemon_stats/screens/main_dashboard/widgets/pokemon_gridview.dart';
import 'package:provider/provider.dart';

class MainDashboardScreen extends StatefulWidget {
  const MainDashboardScreen({super.key});

  @override
  State<MainDashboardScreen> createState() => _MainDashboardScreenState();
}

class _MainDashboardScreenState extends State<MainDashboardScreen> {
  late ScrollController scrollController;
  late PokemonDetailsController controller;
  @override
  void initState() {
    controller = Provider.of<PokemonDetailsController>(context, listen: false);
    scrollController = ScrollController();
    scrollController.addListener(_scrollListener);
    super.initState();
  }

  void _scrollListener() {
    if (scrollController.offset >= scrollController.position.maxScrollExtent &&
        !scrollController.position.outOfRange &&
        !controller.isLoading) {
      controller.fetchBasicPokemonListFromApi();
    }
  }

  @override
  void dispose() {
    scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 3,
      child: Scaffold(
        appBar: AppBar(
          centerTitle: true,
          title: const Text("Pokemon Catalogue"),
          bottom: TabBar(
            onTap: controller.switchTabs,
            tabs: const [
              Tab(icon: Text("All")),
              Tab(icon: Text("You Added")),
              Tab(icon: Text("Favourites")),
            ],
          ),
        ),
        floatingActionButton: FloatingActionButton(
          onPressed: () {
            Navigator.push(context, MaterialPageRoute(builder: (_) => const AddNewPokemonScreen()));
          },
          child: const Icon(Icons.add),
        ),
        body: SingleChildScrollView(
          controller: scrollController,
          child: Padding(
            padding: const EdgeInsets.all(10),
            child: Column(
              children: [
                const PokemonGridView(),
                const SizedBox(height: 10),
                if (controller.isLoading) const CircularProgressIndicator(),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
