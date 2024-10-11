import 'package:flutter/material.dart';
import 'package:meme_generator/models/meme.dart';

class MemeTiles extends StatelessWidget {
  Meme meme;
  MemeTiles({super.key, required this.meme});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        boxShadow: [
          BoxShadow(
            color: Colors.grey.shade200, // Shadow color with opacity
            spreadRadius: 1, // Spread radius
            blurRadius: 1, // Blur radius
            offset: Offset(1, 1), // Offset: X,Y (horizontal, vertical)
          ),
        ],
      ),
      child: Column(
        children: [
          Expanded(
            child: Image.network(
              meme.url,
              fit: BoxFit.fill,
            ),
          ),
          Text(
            meme.name,
            style: TextStyle(fontSize: 16, fontWeight: FontWeight.w500),
            textAlign: TextAlign.center,
          ),
        ],
      ),
    );
  }
}
