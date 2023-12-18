import 'dart:convert';

import 'package:flutter/foundation.dart';

import '../models/game_model.dart';
import 'dart:async';

import 'package:http/http.dart' as http;

class GamesProvider with ChangeNotifier {
  List<GameModel> games = [];

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

  fetchAllGamesFromApi() async {
    setLoading(true);
    var response =
        await http.get(Uri.parse("https://www.freetogame.com/api/games"));

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
    setLoading(true);

    var response = await http
        .get(Uri.parse("https://www.freetogame.com/api/games?platform=$p"));

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
}
