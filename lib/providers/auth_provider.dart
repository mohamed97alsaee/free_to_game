import 'dart:async';
import 'dart:convert';

import 'package:flutter/foundation.dart';
import 'package:http/http.dart' as http;

class AuthProvider with ChangeNotifier {
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

  Future<List> login(Map sendedBody) async {
    setLoading(true);
    final response = await http.post(
        Uri.parse("https://api.ha-k.ly/api/v1/client/auth/login"),
        headers: {
          "Content-Type": "application/json",
          "Accept": "application/json"
        },
        body: json.encode(sendedBody));

    if (kDebugMode) {
      print("STATUS CODE${response.statusCode}");
      print("BODY :${response.body}");
    }

    if (response.statusCode == 201) {
      setLoading(false);
      setFailed(false);

      return [true, "Loged In Successfully"];
    } else {
      setLoading(false);
      setFailed(true);

      return [false, json.decode(response.body)['message']];
    }
  }
}
