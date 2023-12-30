import 'package:flutter/cupertino.dart';
import 'package:free_to_game/providers/dark_mode_provider.dart';
import 'package:free_to_game/screens/game_screen.dart';
import 'package:provider/provider.dart';

import '../models/game_model.dart';
import 'package:flutter/material.dart';

class GameCard extends StatelessWidget {
  const GameCard({super.key, required this.gameModel});
  final GameModel gameModel;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.push(
            context,
            CupertinoPageRoute(
                builder: (context) => GameScreen(gameModel: gameModel)));
      },
      child: Consumer<DarkModeProvider>(
          builder: (context, darkModeConsumer, child) {
        return ClipRRect(
          borderRadius: BorderRadius.circular(12),
          child: GridTile(
            header: Container(
                color:
                    darkModeConsumer.isDark ? Colors.white30 : Colors.black38,
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        gameModel.genre,
                        style: TextStyle(
                            color: darkModeConsumer.isDark
                                ? Colors.black
                                : Colors.white,
                            fontWeight: FontWeight.bold),
                      ),
                      Icon(
                        gameModel.platform.contains("PC")
                            ? Icons.computer
                            : Icons.web,
                        color: darkModeConsumer.isDark
                            ? Colors.black
                            : Colors.white,
                      )
                    ],
                  ),
                )),
            footer: Container(
                color:
                    darkModeConsumer.isDark ? Colors.white30 : Colors.black38,
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Text(
                    gameModel.title,
                    style: TextStyle(
                        color: darkModeConsumer.isDark
                            ? Colors.black
                            : Colors.white,
                        fontWeight: FontWeight.bold),
                  ),
                )),
            child: Image.network(
              gameModel.thumbnail,
              fit: BoxFit.cover,
            ),
          ),
        );
      }),
    );
  }
}
