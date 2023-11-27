import 'package:hive/hive.dart';

class FavoriteBooks {
  final String _key = "books";
  final Box _favorites = Hive.box("favorites");

  Future<List<int>> getFavorites() async {
    return _favorites.get(_key) ?? [];
  }

  void addFavorite(int id) async {
    List<int> temp = _favorites.get(_key) ?? [];
    temp.add(id);
    _favorites.put(_key, temp);
  }

  void removeFavorite(int id) async {
    List<int> temp = _favorites.get(_key) ?? [];
    temp.remove(id);
    _favorites.put(_key, temp);
  }
}
