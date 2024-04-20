import 'package:firebase_practice2/initial_bindings.dart';
import 'package:firebase_practice2/screens/HomePage.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class MovieApp extends StatelessWidget {
  const MovieApp({super.key});

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      initialBinding: InitialBindings(),
      debugShowCheckedModeBanner: false,
        theme: ThemeData(
          progressIndicatorTheme: ProgressIndicatorThemeData(color:Colors.amber[900]),
            inputDecorationTheme: InputDecorationTheme(
                enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(8),
                    borderSide: const BorderSide(color: Colors.amber)))),
        home: const HomePage() //MovieListScreen()
        );
  }
}
