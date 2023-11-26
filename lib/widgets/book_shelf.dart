import 'package:flutter/material.dart';
import 'package:ouki_books/classes/book.dart';
import 'package:ouki_books/widgets/book.dart';

class BookShelfWidget extends StatefulWidget {
  const BookShelfWidget({super.key});

  @override
  State<BookShelfWidget> createState() => _BookShelfWidgetState();
}

class _BookShelfWidgetState extends State<BookShelfWidget> {
  @override
  Widget build(BuildContext context) {
    return Row(children: [
      BookWidget(Book(
          id: 1,
          author: "Oswald, Felix L.",
          title: "The Bible of Nature",
          coverUrl:
              "https://www.gutenberg.org/cache/epub/72134/pg72134.cover.medium.jpg",
          downloadUrl: "https://www.gutenberg.org/ebooks/72134.epub3.images")),
    ]);
  }
}
