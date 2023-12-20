import 'package:flutter/material.dart';
import 'package:free_to_game/providers/auth_provider.dart';
import 'package:free_to_game/providers/dark_mode_provider.dart';
import 'package:free_to_game/providers/games_provider.dart';
import 'package:free_to_game/screens/login_screen.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider<GamesProvider>(
            create: (context) => GamesProvider()),
        ChangeNotifierProvider<DarkModeProvider>(
            create: (context) => DarkModeProvider()),
        ChangeNotifierProvider<AuthProvider>(
            create: (context) => AuthProvider())
      ],
      child: Consumer<DarkModeProvider>(
          builder: (context, darkModeConsumer, child) {
        return MaterialApp(
          debugShowCheckedModeBanner: false,
          theme: ThemeData(
              inputDecorationTheme: const InputDecorationTheme(
                  border: OutlineInputBorder(
                      borderRadius: BorderRadius.all(Radius.circular(20)))),
              appBarTheme: AppBarTheme(
                  iconTheme: IconThemeData(
                      color: darkModeConsumer.isDark
                          ? Colors.black
                          : Colors.white)),
              scaffoldBackgroundColor:
                  darkModeConsumer.isDark ? Colors.black : Colors.white,
              colorScheme: ColorScheme.fromSeed(
                  seedColor: Colors.orangeAccent, primary: Colors.orange),
              useMaterial3: false,
              bottomNavigationBarTheme: BottomNavigationBarThemeData(
                backgroundColor:
                    darkModeConsumer.isDark ? Colors.black : Colors.white,
                selectedItemColor: Colors.orange,
                unselectedItemColor: Colors.grey,
              )),
          home: const ScreenRouter(),
        );
      }),
    );
  }
}

class ScreenRouter extends StatefulWidget {
  const ScreenRouter({super.key});

  @override
  State<ScreenRouter> createState() => _ScreenRouterState();
}

class _ScreenRouterState extends State<ScreenRouter> {
  @override
  void initState() {
    Provider.of<DarkModeProvider>(context, listen: false).getMode();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return const LoginScreen();
  }
}
