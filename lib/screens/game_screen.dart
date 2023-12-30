import 'package:flutter/material.dart';
import 'package:free_to_game/models/game_model.dart';
import 'package:free_to_game/providers/games_provider.dart';
import 'package:provider/provider.dart';

class GameScreen extends StatefulWidget {
  const GameScreen({super.key, required this.gameModel});
  final GameModel gameModel;
  @override
  State<GameScreen> createState() => _GameScreenState();
}

class _GameScreenState extends State<GameScreen> {
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Consumer<GamesProvider>(builder: (context, gamesConsumer, child) {
      return Scaffold(
        appBar: AppBar(),
        body: Center(
          child: Column(
            children: [
              Stack(
                children: [
                  Image.network(
                    widget.gameModel.thumbnail,
                    width: size.width,
                    fit: BoxFit.cover,
                  ),
                  Positioned(
                    bottom: 16,
                    right: 16,
                    child: GestureDetector(
                        child: Icon(
                          Icons.favorite,
                          color: Colors.orange,
                          size: 32,
                        ),
                        onTap: () {
                          Provider.of<GamesProvider>(context, listen: false)
                              .addToFavoriteOnFirebase(widget.gameModel);
                        }),
                  )
                ],
              ),
              Text(widget.gameModel.title),
            ],
          ),
        ),
      );
    });
  }
}
