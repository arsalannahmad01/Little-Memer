class Meme {
  String id;
  String name;
  String url;
  int width;
  int height;
  int boxCount;
  int captions;

  Meme({
    required this.id,
    required this.name,
    required this.url,
    required this.width,
    required this.height,
    required this.boxCount,
    required this.captions,
  });

  Meme copyWith({
    String? id,
    String? name,
    String? url,
    int? width,
    int? height,
    int? boxCount,
    int? captions,
  }) =>
      Meme(
        id: id ?? this.id,
        name: name ?? this.name,
        url: url ?? this.url,
        width: width ?? this.width,
        height: height ?? this.height,
        boxCount: boxCount ?? this.boxCount,
        captions: captions ?? this.captions,
      );

  factory Meme.fromJson(Map<String, dynamic> json) => Meme(
        id: json["id"],
        name: json["name"],
        url: json["url"],
        width: json["width"],
        height: json["height"],
        boxCount: json["box_count"],
        captions: json["captions"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
        "url": url,
        "width": width,
        "height": height,
        "box_count": boxCount,
        "captions": captions,
      };
}
