import 'package:flutter/material.dart';
import 'package:modul_8/examle_in_youtube/theme/theme_colors.dart';
import 'package:modul_8/pages/home_page.dart';
import 'package:modul_8/examle_in_youtube/pages/index_page.dart';


void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
        //primaryColor: primary,
        colorScheme: ColorScheme.fromSeed(
          seedColor: primary,
        )
        //primarySwatch: Colors.red,
      ),
      debugShowCheckedModeBanner: false,
      home: const HomePage(),
      routes: {
        HomePage.id:(context)=> const HomePage(),
      },
    );
  }
}