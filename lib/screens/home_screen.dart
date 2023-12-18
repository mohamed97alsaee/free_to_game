import 'package:flutter/material.dart';
import 'package:free_to_game/providers/games_provider.dart';
import 'package:free_to_game/widgets/game_card.dart';
import 'package:provider/provider.dart';
import 'package:shimmer/shimmer.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int seletedIndexbyUser = 1;

  @override
  void initState() {
    Provider.of<GamesProvider>(context, listen: false).fetchAllGamesFromApi();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Consumer<GamesProvider>(builder: (context, gamesConsumer, child) {
      return Scaffold(
        drawer: const Drawer(
          child: SafeArea(
            child: Column(
              children: [
                ListTile(
                  title: Text("Language"),
                ),
                ListTile(
                  title: Text("Dark Mode"),
                ),
                ListTile(
                  title: Text("Logout"),
                )
              ],
            ),
          ),
        ),
        appBar: AppBar(),
        body: Center(
          child: gamesConsumer.isFailed
              ? Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(
                      Icons.error_outline_outlined,
                      size: size.width * 0.33,
                      color: Colors.black38,
                    ),
                    const Text(
                      "Something went wrong!",
                      style: TextStyle(fontSize: 18, color: Colors.black38),
                    ),
                  ],
                )
              : GridView.builder(
                  padding: const EdgeInsets.symmetric(horizontal: 24),
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                      childAspectRatio: 1 / 1.5,
                      mainAxisSpacing: 24,
                      crossAxisSpacing: 24,
                      crossAxisCount: 2),
                  itemCount:
                      gamesConsumer.isLoading ? 10 : gamesConsumer.games.length,
                  shrinkWrap: true,
                  itemBuilder: (context, index) {
                    return gamesConsumer.isLoading
                        ? ClipRRect(
                            borderRadius: BorderRadius.circular(12),
                            child: Shimmer(
                                gradient: const LinearGradient(
                                    colors: [Colors.yellow, Colors.white10]),
                                child: Container(
                                  color: Colors.yellow,
                                )),
                          )
                        : GameCard(
                            gameModel: gamesConsumer.games[index],
                          );
                  }),
        ),
        bottomNavigationBar: BottomNavigationBar(
          currentIndex: seletedIndexbyUser,
          onTap: (index) {
            setState(() {
              seletedIndexbyUser = index;
            });

            if (seletedIndexbyUser == 0) {
              Provider.of<GamesProvider>(context, listen: false)
                  .fetchGamesByPlatform('browser');
            }
            if (seletedIndexbyUser == 1) {
              Provider.of<GamesProvider>(context, listen: false)
                  .fetchAllGamesFromApi();
            }

            if (seletedIndexbyUser == 2) {
              Provider.of<GamesProvider>(context, listen: false)
                  .fetchGamesByPlatform('pc');
            }
          },
          items: const [
            BottomNavigationBarItem(
                icon: Icon(Icons.web),
                label: "Browser",
                tooltip: "This tab show browser games."),
            BottomNavigationBarItem(
                icon: Icon(Icons.gamepad),
                label: "All",
                tooltip: "This tab show All games."),
            BottomNavigationBarItem(
                icon: Icon(Icons.computer),
                label: "PC",
                tooltip: "This tab show pc games."),
          ],
        ),
      );
    });
  }
}
