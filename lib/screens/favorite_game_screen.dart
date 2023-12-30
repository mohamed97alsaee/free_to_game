import 'package:flutter/material.dart';
import 'package:free_to_game/providers/games_provider.dart';
import 'package:free_to_game/widgets/game_card.dart';
import 'package:provider/provider.dart';
import 'package:shimmer/shimmer.dart';

class FavoriteGamesSCreen extends StatefulWidget {
  const FavoriteGamesSCreen({super.key});

  @override
  State<FavoriteGamesSCreen> createState() => _FavoriteGamesSCreenState();
}

class _FavoriteGamesSCreenState extends State<FavoriteGamesSCreen> {
  @override
  void initState() {
    Provider.of<GamesProvider>(context, listen: false)
        .getFavoriteGamesFromFirebase();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<GamesProvider>(builder: (context, gamesConsumer, child) {
      return Scaffold(
        appBar: AppBar(),
        body: GridView.builder(
            padding: const EdgeInsets.all(24),
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                childAspectRatio: 1 / 1.5,
                mainAxisSpacing: 24,
                crossAxisSpacing: 24,
                crossAxisCount: 2),
            itemCount: gamesConsumer.isLoading
                ? 10
                : gamesConsumer.favoriteGames.length,
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
                      gameModel: gamesConsumer.favoriteGames[index],
                    );
            }),
      );
    });
  }
}
