// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'package:flutter/material.dart';
import 'package:meme_generator/pages/templates_page.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.transparent,
        title: Text(
          "Little Memer",
          style: TextStyle(
            fontSize: 24,
            fontWeight: FontWeight.bold,
          ),
        ),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 25.0, vertical: 100.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            //about meme generator
            Column(
              children: [
                Text(
                  "With Little Memer, creating memes is a breeze! Generate hilarious content at your fingertips using our user-friendly templates. Unleash your creativity and share laughs with friends!",
                  style: TextStyle(
                    color: Colors.grey[600],
                  ),
                  textAlign: TextAlign.center,
                ),
                //example gir or pics
                Image.asset('lib/images/memeMain.png'),
              ],
            ),

            //"Start Generating" Button
            Padding(
              padding: const EdgeInsets.only(bottom: 5.0),
              child: GestureDetector(
                onTap: () => Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => TemplatesPage(),
                  ),
                ),
                child: Container(
                  decoration: BoxDecoration(
                      color: Colors.blueGrey[300],
                      borderRadius: BorderRadius.circular(12)),
                  padding:
                      EdgeInsets.symmetric(horizontal: 100, vertical: 25.0),
                  child: Text(
                    "Start Creating",
                    style: TextStyle(
                        color: Colors.white,
                        fontSize: 16,
                        fontWeight: FontWeight.bold),
                  ),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
