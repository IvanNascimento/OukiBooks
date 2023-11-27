import 'package:flutter/material.dart';
import 'package:ouki_books/repositories/book_repository.dart';
import 'package:ouki_books/classes/book.dart';
import 'package:ouki_books/widgets/book.dart';

class BookShelfWidget extends StatefulWidget {
  final List<Book> books;
  const BookShelfWidget(this.books, {super.key});

  @override
  State<BookShelfWidget> createState() => _BookShelfWidgetState();
}

class _BookShelfWidgetState extends State<BookShelfWidget> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Wrap(
        alignment: WrapAlignment.spaceAround,
        children: widget.books.map((book) => BookWidget(book)).toList());
  }
}
