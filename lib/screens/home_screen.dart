import 'package:flutter/material.dart';
import 'package:free_to_game/providers/auth_provider.dart';
import 'package:free_to_game/providers/dark_mode_provider.dart';
import 'package:free_to_game/providers/games_provider.dart';
import 'package:free_to_game/widgets/drawer_tile.dart';
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

    return Consumer<DarkModeProvider>(builder: (context, dmc, child) {
      return Consumer<GamesProvider>(builder: (context, gamesConsumer, child) {
        return Scaffold(
          drawer: Drawer(
            child: SafeArea(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Column(
                    children: [
                      DrawerTile(
                          text: "Language",
                          icon: Icons.translate,
                          onTap: () {}),
                      DrawerTile(
                          text: dmc.isDark ? "Light Mode" : "Dark Mode",
                          icon: dmc.isDark ? Icons.light_mode : Icons.dark_mode,
                          onTap: () {
                            Provider.of<DarkModeProvider>(context,
                                    listen: false)
                                .switchMode();
                          }),
                    ],
                  ),
                  DrawerTile(
                      showDivider: false,
                      text: "Logout",
                      icon: Icons.exit_to_app,
                      onTap: () {
                        Provider.of<AuthProvider>(context, listen: false)
                            .logout();
                      }),

                  // ListTile(
                  //   title: Text(
                  //     "Language",
                  //     style: TextStyle(
                  //         color: dmc.isDark ? Colors.white : Colors.black),
                  //   ),
                  // ),
                  // GestureDetector(
                  //   onTap: () {
                  // Provider.of<DarkModeProvider>(context, listen: false)
                  //     .switchMode();
                  //   },
                  //   child: ListTile(
                  //     title: Text(
                  //       dmc.isDark ? "Light Mode" : "Dark Mode",
                  //       style: TextStyle(
                  //           color: dmc.isDark ? Colors.white : Colors.black),
                  //     ),
                  //   ),
                  // ),
                  // GestureDetector(
                  //   onTap: () {
                  // Provider.of<AuthProvider>(context, listen: false)
                  //     .logout();
                  //   },
                  //   child: ListTile(
                  //     title: Text(
                  //       "Logout",
                  //       style: TextStyle(
                  //           color: dmc.isDark ? Colors.white : Colors.black),
                  //     ),
                  //   ),
                  // )
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
                    padding: const EdgeInsets.all(24),
                    gridDelegate:
                        const SliverGridDelegateWithFixedCrossAxisCount(
                            childAspectRatio: 1 / 1.5,
                            mainAxisSpacing: 24,
                            crossAxisSpacing: 24,
                            crossAxisCount: 2),
                    itemCount: gamesConsumer.isLoading
                        ? 10
                        : gamesConsumer.games.length,
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
    });
  }
}
