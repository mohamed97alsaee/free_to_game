import 'dart:convert';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/foundation.dart';
import 'package:free_to_game/services/api.dart';

import '../models/game_model.dart';
import 'dart:async';

class GamesProvider with ChangeNotifier {
  List<GameModel> games = [];
  List<GameModel> filteredGames = [];
  List<GameModel> favoriteGames = [];

  Api api = Api();
  bool isFailed = false;
  bool isLoading = true;

  setLoading(bool value) {
    Timer(const Duration(milliseconds: 50), () {
      isLoading = value;
      notifyListeners();
    });
  }

  setFailed(bool value) {
    Timer(const Duration(milliseconds: 50), () {
      isFailed = value;
      notifyListeners();
    });
  }

  searchByTitle(String title) {
    filteredGames = games
        .where((element) =>
            element.title.toLowerCase().contains(title.toLowerCase()))
        .toList();

    notifyListeners();
  }

  fetchAllGamesFromApi() async {
    getFavoriteGamesFromFirebase();
    setLoading(true);
    var response = await api.get("https://www.freetogame.com/api/games", {});

    if (kDebugMode) {
      print("STATUS CODE : ${response.statusCode.toString()}");
      print("BODY : ${response.body}");
    }

    if (response.statusCode == 200) {
      setFailed(false);
      games.clear();
      var decodedData = json.decode(response.body);

      for (var x in decodedData) {
        games.add(GameModel.fromJson(x));
      }
      // setState(() {});
      notifyListeners();
    } else {
      setFailed(true);
    }
    setLoading(false);
  }

  fetchGamesByPlatform(String p) async {
    getFavoriteGamesFromFirebase();

    setLoading(true);

    var response =
        await api.get("https://www.freetogame.com/api/games?platform=$p", {});
    // http
    //     .get(Uri.parse("https://www.freetogame.com/api/games?platform=$p"));

    if (kDebugMode) {
      print("STATUS CODE : ${response.statusCode.toString()}");
      print("BODY : ${response.body}");
    }

    if (response.statusCode == 200) {
      setFailed(false);

      games.clear();
      var decodedData = json.decode(response.body);

      for (var x in decodedData) {
        games.add(GameModel.fromJson(x));
      }
      // setState(() {});
      notifyListeners();
    } else {
      setFailed(true);
    }
    setLoading(false);
  }

  addToFavoriteOnFirebase(GameModel gm) async {
    FirebaseFirestore firebaseStorage = FirebaseFirestore.instance;

    if (!favoriteGames.contains(gm) || favoriteGames.isEmpty) {
      firebaseStorage.collection("mygames").add(gm.toJson());
    }

    notifyListeners();
  }

  getFavoriteGamesFromFirebase() async {
    setLoading(true);

    FirebaseFirestore firebaseStorage = FirebaseFirestore.instance;

    await firebaseStorage.collection("mygames").get().then((response) {
      if (kDebugMode) {
        print("mygames Collection is : ${response.docs.first.data()}");
      }

      favoriteGames.clear();
      for (var x in response.docs) {
        favoriteGames.add(GameModel.fromJson(x.data()));
      }
    });
    setLoading(false);
  }
}
