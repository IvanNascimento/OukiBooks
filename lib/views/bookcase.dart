import 'package:ouki_books/classes/book.dart';
import 'package:ouki_books/repositories/book_repository.dart';
import 'package:flutter/material.dart';
import 'package:ouki_books/widgets/book_shelf.dart';

class BookCaseView extends StatefulWidget {
  final bool favorites;
  const BookCaseView({super.key, this.favorites = false});

  @override
  State<BookCaseView> createState() => _BookCaseViewState();
}

class _BookCaseViewState extends State<BookCaseView> {
  late int shelfSize;
  late List<Book> books;
  bool loading = true;

  List<Widget> bookSeparetor() {
    List<Widget> result = [];
    List<Book> tempList = [];
    for (int i = 0; i < books.length; i++) {
      if (widget.favorites) {
        if (books[i].favorite) {
          tempList.add(books[i]);
        }
      } else {
        tempList.add(books[i]);
      }
      if (tempList.length == shelfSize) {
        result.add(BookShelfWidget(tempList));
        tempList = [];
      }
    }
    result.add(BookShelfWidget(tempList));

    return result;
  }

  Future<void> iniciar() async {
    setState(() {
      loading = true;
    });
    books = await BookRepository().getBooks();
    setState(() {
      loading = false;
    });
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    iniciar();
  }

  @override
  Widget build(BuildContext context) {
    shelfSize = (MediaQuery.of(context).size.width - 30) ~/ 100;
    return Padding(
        padding: const EdgeInsets.only(top: 20, left: 15, right: 15),
        child: loading
            ? const Center(
                child: CircularProgressIndicator(),
              )
            : ListView(children: bookSeparetor()));
  }
}
