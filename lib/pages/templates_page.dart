// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'dart:typed_data';
import 'package:flutter/material.dart';
import 'package:meme_generator/components/meme_tiles.dart';
import 'package:meme_generator/models/meme.dart';
import 'package:meme_generator/services/data_services.dart';
import 'package:image_editor_plus/image_editor_plus.dart';
import 'package:http/http.dart' as http;
import 'package:path_provider/path_provider.dart';
import 'package:permission_handler/permission_handler.dart';
import 'dart:io';

class TemplatesPage extends StatefulWidget {
  const TemplatesPage({super.key});

  @override
  State<TemplatesPage> createState() => _TemplatesPageState();
}

class _TemplatesPageState extends State<TemplatesPage> {
  String _memeFilter = "";

  Future<Uint8List> _fetchImageBytes(String url) async {
    final response = await http.get(Uri.parse(url));
    if (response.statusCode == 200) {
      return response.bodyBytes;
    } else {
      throw Exception('Failed to load image');
    }
  }

  Future<void> _saveImage(Uint8List editedImage, String imageName) async {
    String path = "/storage/emulated/0/Download";

    String filePath = "$path/$imageName-edited.png";

    // Save the edited image
    await File(filePath).writeAsBytes(editedImage);
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text('Image saved to $filePath')),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.transparent,
        title: Text(
          "Templates",
          style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
        ),
        centerTitle: true,
      ),
      body: Column(
        children: [
          // Search bar
          Padding(
            padding: const EdgeInsets.symmetric(
              horizontal: 20.0,
              vertical: 10.0,
            ),
            child: TextField(
              decoration: InputDecoration(
                hintText: "Search",
                filled: true,
                fillColor: Colors.white,
                suffixIcon: Icon(Icons.search, size: 30, color: Colors.black87),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(8.0),
                  borderSide: BorderSide.none,
                ),
              ),
              onChanged: (value) {
                setState(() {
                  _memeFilter = value;
                });
              },
            ),
          ),

          // List of templates
          Expanded(
            child: FutureBuilder(
              future: DataService().getMemes(_memeFilter),
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return const Center(
                    child: CircularProgressIndicator(),
                  );
                }

                if (snapshot.hasError) {
                  return const Center(
                    child: Text("Unable to load data."),
                  );
                }

                return GridView.builder(
                  padding: EdgeInsets.all(20),
                  gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2,
                    crossAxisSpacing: 15.0,
                    mainAxisSpacing: 15.0,
                  ),
                  itemCount: snapshot.data!.length,
                  itemBuilder: (context, index) {
                    Meme meme = snapshot.data![index];
                    return GestureDetector(
                      onTap: () async {
                        // Fetch the image bytes and open the editor
                        Uint8List imageBytes = await _fetchImageBytes(meme.url);
                        Uint8List? editedImage = await Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => ImageEditor(
                              image: imageBytes,
                            ),
                          ),
                        );

                        // Save the edited image if available
                        if (editedImage != null) {
                          await _saveImage(editedImage, meme.name);
                        }
                      },
                      child: MemeTiles(
                        meme: meme,
                      ),
                    );
                  },
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
