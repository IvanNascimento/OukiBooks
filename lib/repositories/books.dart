import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:ouki_books/classes/book.dart';

class BookRepository {
  final _url = Uri.https('https://escribo.com/books.json');

  Future<List<Book>> getBooks() async {
    final request = await http.get(_url);
    if (request.statusCode != 200) {
      throw Exception('Request error');
    }
    final booksList = jsonDecode(request.body) as List<Map<String, dynamic>>;

    return booksList.map(Book.fromJson).toList();
  }
}
