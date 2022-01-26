class News{
  final String id;
  final String headline;
  final String image;
  final String summary;

  News.fromMap(Map<String, dynamic> map)
      : id = map['id'],
        headline = map['headline'],
        image = map['image'],
        summary = map['summary'];

  Map<String, Object?> toJson() {
    return {
      'id': id,
      'headline': headline,
      'image': image,
      'summary': summary,
    };
  }
}