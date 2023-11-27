import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:http/http.dart' as http;
import 'package:dio/dio.dart';
import 'package:ouki_books/repositories/favorites_repository.dart';
import 'package:path_provider/path_provider.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:device_info_plus/device_info_plus.dart';

import 'package:ouki_books/classes/book.dart';

class BookRepository {
  final Uri _url = Uri.https('escribo.com', '/books.json');
  final DeviceInfoPlugin platform = DeviceInfoPlugin();
  final FavoriteBooks favoriteBooks = FavoriteBooks();

  late List<Book> _books;
  late Directory? appDocDir;

  bool dir = false;
  Dio dio = Dio();

  BookRepository() {
    _init();
  }

  _init() async {
    appDocDir = await getExternalStorageDirectory();
    dir = true;
  }

  Future<List<Book>> getBooks() async {
    final request = await http.get(_url);
    if (request.statusCode != 200) {
      throw Exception('Request error');
    }
    final booksList = jsonDecode(request.body) as List;

    _books = booksList.map((book) => Book.fromJson(book)).toList();
    List<int> favorites = await favoriteBooks.getFavorites();

    for (var i = 0; i < _books.length; i++) {
      _books.removeWhere(
          (element) => element.id == _books[i].id && element != _books[i]);
      if (favorites.contains(_books[i].id)) {
        _books[i].favorite = true;
      }
    }

    return _books;
  }

  Future<String?> _getAndroidVersion() async {
    try {
      final AndroidDeviceInfo info = (await platform.androidInfo);
      debugPrint(info.toString());
      return info.version.release;
    } on PlatformException catch (e) {
      debugPrint("FAILED TO GET ANDROID VERSION: ${e.message}");
      return null;
    }
  }

  Future<bool> downloaded(int id) async {
    if (!dir) {
      await _init();
    }
    String path = await bookpath(id);
    if (File(path).existsSync()) {
      debugPrint("Baixado");
      return true;
    }
    debugPrint("não baixado");
    return false;
  }

  Future<bool> download(String url, int id) async {
    final String? version = await _getAndroidVersion();
    if (version != null) {
      String? firstPart;
      if (version.toString().contains(".")) {
        int indexOfFirstDot = version.indexOf(".");
        firstPart = version.substring(0, indexOfFirstDot);
      } else {
        firstPart = version;
      }
      int intValue = int.parse(firstPart);
      if (intValue >= 13) {
        return _download(url, id);
      } else {
        final PermissionStatus status = await Permission.storage.request();
        if (status == PermissionStatus.granted) {
          return _download(url, id);
        } else {
          await Permission.storage.request();
        }
      }
    }
    return false;
  }

  Future<bool> _download(String url, int id) async {
    if (!dir) {
      await _init();
    }
    String path = await bookpath(id);
    File file = File(path);

    if (!File(path).existsSync()) {
      await file.create();
      try {
        await dio.download(
          url,
          path,
          deleteOnError: true,
          onReceiveProgress: (receivedBytes, totalBytes) {
            debugPrint('Download --- ${(receivedBytes / totalBytes) * 100}');
          },
        ).whenComplete(() => debugPrint("Livro Baixado"));
      } catch (e) {
        return false;
      }
    }
    return true;
  }

  List<Book> books(bool favorites) {
    if (favorites) {
      return _books.where((book) => book.favorite == true).toList();
    }
    return _books;
  }

  Future<String> bookpath(int id) async {
    if (!dir) {
      await _init();
    }
    return '${appDocDir!.path}/$id.epub';
  }
}
