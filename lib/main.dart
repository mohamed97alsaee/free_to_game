import 'package:flutter/material.dart';
import 'package:free_to_game/providers/games_provider.dart';
import 'package:free_to_game/screens/splash_screen.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider<GamesProvider>(
            create: (context) => GamesProvider())
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
            colorScheme: ColorScheme.fromSeed(
                seedColor: Colors.orangeAccent, primary: Colors.orange),
            useMaterial3: false,
            bottomNavigationBarTheme: const BottomNavigationBarThemeData(
              selectedItemColor: Colors.orange,
              unselectedItemColor: Colors.grey,
            )),
        home: const SplashScreen(),
      ),
    );
  }
}
