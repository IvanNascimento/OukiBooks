// ignore_for_file: unnecessary_getters_setters

class Book {
  int? _id;
  String? _title;
  String? _author;
  String? _coverUrl;
  String? _downloadUrl;

  Book(
      {int? id,
      String? title,
      String? author,
      String? coverUrl,
      String? downloadUrl}) {
    if (id != null) {
      _id = id;
    }
    if (title != null) {
      _title = title;
    }
    if (author != null) {
      _author = author;
    }
    if (coverUrl != null) {
      _coverUrl = coverUrl;
    }
    if (downloadUrl != null) {
      _downloadUrl = downloadUrl;
    }
  }

  int? get id => _id;
  set id(int? id) => _id = id;
  String? get title => _title;
  set title(String? title) => _title = title;
  String? get author => _author;
  set author(String? author) => _author = author;
  String? get coverUrl => _coverUrl;
  set coverUrl(String? coverUrl) => _coverUrl = coverUrl;
  String? get downloadUrl => _downloadUrl;
  set downloadUrl(String? downloadUrl) => _downloadUrl = downloadUrl;

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
