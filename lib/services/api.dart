import 'dart:convert';

import 'package:flutter/foundation.dart';
import 'package:http/http.dart' as http;
import 'package:http/http.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Api {
  Future<Response> get(String url, Map body) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    final response = await http.get(
      Uri.parse(url),
      headers: {
        "Content-Type": "application/json",
        "Accept": "application/json",
        "Authorization": prefs.getString("token")!
      },
    );

    if (kDebugMode) {
      print("GET REQ ON $url");
      print("STATUS CODE : ${response.statusCode}");
      print("RES BODY : ${response.body}");
    }
    return response;
  }

  Future<Response> post(String url, Map body) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();

    final response = await http.post(
      Uri.parse(url),
      body: jsonEncode(body),
      headers: {
        "Content-Type": "application/json",
        "Accept": "application/json",
        "Authorization": prefs.getString("token")!
      },
    );

    if (kDebugMode) {
      print("POST REQ ON $url");
      print("BODY POST REQ $body");
      print("STATUS CODE : ${response.statusCode}");
      print("RES BODY : ${response.body}");
    }
    return response;
  }

  Future<Response> put(String url, Map body) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();

    final response = await http.put(
      Uri.parse(url),
      body: jsonEncode(body),
      headers: {
        "Content-Type": "application/json",
        "Accept": "application/json",
        "Authorization": prefs.getString("token")!
      },
    );

    if (kDebugMode) {
      print("PUT REQ ON $url");
      print("BODY PUT REQ $body");
      print("STATUS CODE : ${response.statusCode}");
      print("RES BODY : ${response.body}");
    }
    return response;
  }

  Future<Response> delete(String url, Map body) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();

    final response = await http.delete(
      Uri.parse(url),
      body: jsonEncode(body),
      headers: {
        "Content-Type": "application/json",
        "Accept": "application/json",
        "Authorization": prefs.getString("token")!
      },
    );

    if (kDebugMode) {
      print("DELETE REQ ON $url");
      print("DELETE BODY REQ  $body");
      print("STATUS CODE : ${response.statusCode}");
      print("RES BODY : ${response.body}");
    }
    return response;
  }
}
