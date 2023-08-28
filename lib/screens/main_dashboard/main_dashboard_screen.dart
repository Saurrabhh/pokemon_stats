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
  bool _isEditing = false;
  @override
  void initState() {
    controller = Provider.of<PokemonDetailsController>(context, listen: false);
    scrollController = ScrollController();
    scrollController.addListener(_scrollListener);
    super.initState();
  }

  void _scrollListener() {
    if (controller.currentTab != 0) {
      return;
    }
    if (scrollController.offset >= scrollController.position.maxScrollExtent &&
        !scrollController.position.outOfRange &&
        !controller.isLoading) {
      controller.fetchBasicPokemonListFromApi();
    }
  }

  void _toggleEditing() {
    setState(() {
      _isEditing = !_isEditing;
    });
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
          title: _isEditing
              ? TextField(
                  onSubmitted: (_) => _toggleEditing(),
                  autofocus: true,
                  onChanged: controller.onSearchChanged,
                )
              : const Text("Pokemon Catalogue"),
          actions: [
            IconButton(
              icon: const Icon(Icons.search),
              onPressed: _toggleEditing,
            ),
          ],
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
          child: const Padding(
            padding: EdgeInsets.all(10),
            child: PokemonGridView(),
          ),
        ),
      ),
    );
  }
}
