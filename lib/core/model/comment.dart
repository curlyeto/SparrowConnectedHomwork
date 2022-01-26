class Comment{
  final int newsId;
  final int rate;
  final String title;
  final String userId;
  Comment({required this.newsId,required this.rate,required this.title,required this.userId});

  Comment.fromMap(Map<String, dynamic> map)
      :
        newsId = map['news_id'],
        rate = map['rate'],
        title = map['title'],
        userId = map['user_id'];

  Map<String, dynamic> toMap() {
    return {
      'news_id': newsId,
      'rate':rate,
      'title':title,
      'user_id': userId,
    };
  }
}