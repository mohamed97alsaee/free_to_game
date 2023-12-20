import 'package:flutter/foundation.dart';
import 'package:shared_preferences/shared_preferences.dart';

class DarkModeProvider with ChangeNotifier {
  bool isDark = false;

  switchMode() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    isDark = !isDark;
    prefs.setBool("isDark", isDark);
    getMode();
  }

  getMode() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();

    bool? storedDark = prefs.getBool("isDark");

    if (storedDark == null) {
      isDark = false;
    } else {
      isDark = storedDark;
    }
    if (kDebugMode) {
      print("STORED ISDARK IS : $storedDark");
    }
    notifyListeners();
  }
}
