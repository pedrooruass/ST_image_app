class PhotoModel {
  String title;
  String url;
  String thumbnailUrl;

  PhotoModel({
    this.title,
    this.url,
    this.thumbnailUrl,
  });

  factory PhotoModel.fromMap(Map<String, dynamic> map) {
    return PhotoModel(
      thumbnailUrl: map["thumbnailUrl"],
      url: map["url"],
      title: map["title"],
    );
  }
}
