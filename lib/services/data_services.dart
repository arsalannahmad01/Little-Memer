import 'package:meme_generator/models/meme.dart';
import 'package:meme_generator/services/http_serrvices.dart';

class DataService {
  static final DataService _singleton = DataService._internal();

  final HTTPService _httpService = HTTPService();

  factory DataService() {
    return _singleton;
  }

  DataService._internal();

  Future<List<Meme>?> getMemes(String filter) async {
    String path = "get_memes/";
    var response = await _httpService.get(path);
    if (response?.statusCode == 200 && response?.data != null) {
      List data = response!.data?['data']['memes'];

      if (filter.isNotEmpty) {
        List<Meme> new_data = data.map((e) => Meme.fromJson(e)).toList();

        return new_data.where((meme) {
          // Convert the meme name and query to lowercase to make the search case-insensitive
          final memeName = meme.name.toLowerCase();
          final searchQuery = filter.toLowerCase();

          // Check if any word in the meme's name contains the search query
          return memeName.split(" ").any((word) => word.contains(searchQuery));
        }).toList();
      }

      List<Meme> memes = data.map((e) => Meme.fromJson(e)).toList();
      return memes;
    }
    return [];
  }
}
