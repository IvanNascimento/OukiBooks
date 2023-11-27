// ignore_for_file: unnecessary_getters_setters

class Book {
  int? _id;
  late String _title;
  late String _author;
  late String _coverUrl;
  late String _downloadUrl;
  bool _favorite = false;

  Book(
      {int? id,
      String title = "",
      String author = "",
      String coverUrl = "",
      String downloadUrl = "",
      bool? favorite}) {
    _id = id;
    _title = title;
    _author = author;
    _coverUrl = coverUrl;

    _downloadUrl = downloadUrl;
    if (favorite != null) {
      _favorite = favorite;
    }
  }

  int? get id => _id;
  set id(int? id) => _id = id;
  String get title => _title;
  set title(String title) => _title = title;
  String get author => _author;
  set author(String author) => _author = author;
  String get coverUrl => _coverUrl;
  set coverUrl(String coverUrl) => _coverUrl = coverUrl;
  String get downloadUrl => _downloadUrl;
  set downloadUrl(String downloadUrl) => _downloadUrl = downloadUrl;
  bool get favorite => _favorite;
  set favorite(bool favorite) => _favorite = favorite;

  Book.fromJson(Map<String, dynamic> json) {
    _id = json['id'];
    _title = json['title'];
    _author = json['author'];
    _coverUrl = json['cover_url'];
    _downloadUrl = json['download_url'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = _id;
    data['title'] = _title;
    data['author'] = _author;
    data['cover_url'] = _coverUrl;
    data['download_url'] = _downloadUrl;
    return data;
  }
}
