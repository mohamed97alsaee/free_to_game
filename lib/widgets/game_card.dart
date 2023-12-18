import '../models/game_model.dart';
import 'package:flutter/material.dart';

class GameCard extends StatelessWidget {
  const GameCard({super.key, required this.gameModel});
  final GameModel gameModel;

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(12),
      child: GridTile(
        header: Container(
            color: Colors.black38,
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    gameModel.genre,
                    style: const TextStyle(
                        color: Colors.white, fontWeight: FontWeight.bold),
                  ),
                  Icon(
                    gameModel.platform.contains("PC")
                        ? Icons.computer
                        : Icons.web,
                    color: Colors.white,
                  )
                ],
              ),
            )),
        footer: Container(
            color: Colors.black38,
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text(
                gameModel.title,
                style: const TextStyle(
                    color: Colors.white, fontWeight: FontWeight.bold),
              ),
            )),
        child: Image.network(
          gameModel.thumbnail,
          fit: BoxFit.cover,
        ),
      ),
    );
  }
}
