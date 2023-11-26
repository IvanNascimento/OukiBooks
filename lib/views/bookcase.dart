import 'package:flutter/material.dart';
import 'package:ouki_books/widgets/book_shelf.dart';

class BookCaseView extends StatefulWidget {
  const BookCaseView({super.key});

  @override
  State<BookCaseView> createState() => _BookCaseViewState();
}

class _BookCaseViewState extends State<BookCaseView> {
  @override
  Widget build(BuildContext context) {
    return Container(child: Column(children: [const BookShelfWidget()]));
  }
}
