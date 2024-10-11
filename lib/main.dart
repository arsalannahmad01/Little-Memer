import 'package:flutter/material.dart';
import 'package:meme_generator/pages/home_page.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: HomePage(),
      theme: ThemeData(
        colorSchemeSeed: Colors.blueGrey,
      ),
    );
  }
}
