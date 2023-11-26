import 'package:flutter/material.dart';
import 'package:ouki_books/classes/book.dart';
import 'package:ouki_books/repositories/local_books.dart';
import 'package:ouki_books/views/reader.dart';

class BookWidget extends StatefulWidget {
  final Book _book;
  final bool _favorite;

  const BookWidget(this._book, {super.key, bool favorite = false})
      : _favorite = favorite;

  @override
  State<BookWidget> createState() => _BookWidgetState();
}

class _BookWidgetState extends State<BookWidget> {
  bool favorite = false;

  @override
  Widget build(BuildContext context) {
    handleClick() {
      favorite = !favorite;
      setState(() {});
      // chamar função para remover dos favoritos
    }

    handleOpen(BuildContext context) {
      if (LocalBooks.downloaded(widget._book.id!)) {
        Navigator.push(context,
            MaterialPageRoute(builder: (context) => ReaderView(widget._book)));
      } else {
        LocalBooks.download(widget._book.downloadUrl!);
      }
    }

    return InkWell(
      onTap: handleOpen(context),
      child: SizedBox(
        width: 75,
        child: Column(children: [
          Stack(children: [
            Image.network(widget._book.coverUrl!,
                headers: {"Access-Control-Allow-Origin": "*"}),
            Align(
                alignment: Alignment.topRight,
                child: InkWell(
                  onTap: () {
                    handleClick();
                  },
                  child: Icon(favorite == true
                      ? Icons.bookmark
                      : Icons.bookmark_border),
                ))
          ]),
          Text(widget._book.title!),
          Text(widget._book.author!),
        ]),
      ),
    );
  }
}
