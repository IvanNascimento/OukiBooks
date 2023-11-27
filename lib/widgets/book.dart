import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:ouki_books/repositories/favorites_repository.dart';
import 'package:vocsy_epub_viewer/epub_viewer.dart';

import 'package:ouki_books/repositories/book_repository.dart';
import 'package:ouki_books/classes/book.dart';

class BookWidget extends StatefulWidget {
  final Book _book;

  const BookWidget(this._book, {super.key});

  @override
  State<BookWidget> createState() => _BookWidgetState();
}

class _BookWidgetState extends State<BookWidget> {
  BookRepository br = BookRepository();
  FavoriteBooks fb = FavoriteBooks();
  bool downloading = false;
  late bool downloaded = false;

  _init() async {
    downloaded = await br.downloaded(widget._book.id!);
    setState(() {});
  }

  @override
  void initState() {
    super.initState();
    _init();
  }

  @override
  Widget build(BuildContext context) {
    showSnackbar(String texto) {
      ScaffoldMessenger.of(context)
          .showSnackBar(SnackBar(content: Text(texto)));
    }

    handleTagClick() {
      if (widget._book.favorite) {
        fb.removeFavorite(widget._book.id!);
      } else {
        fb.addFavorite(widget._book.id!);
      }
      widget._book.favorite = !widget._book.favorite;
      setState(() {});
    }

    handleDownloadClick() async {
      if (!downloaded && !downloading) {
        setState(() {
          downloading = true;
        });
        bool status =
            await br.download(widget._book.downloadUrl, widget._book.id!);
        if (status) {
          setState(() {
            downloading = false;
            downloaded = true;
          });
        } else {
          showSnackbar("Error no download do Livro");
          setState(() {
            downloading = false;
            downloaded = false;
          });
        }
      }
    }

    handleOpen() async {
      if (downloaded) {
        VocsyEpub.setConfig(
          themeColor: Theme.of(context).primaryColor,
          identifier: "book",
          scrollDirection: EpubScrollDirection.ALLDIRECTIONS,
          allowSharing: true,
          enableTts: true,
        );
        VocsyEpub.open(await br.bookpath(widget._book.id!));
      } else {
        handleDownloadClick();
      }
    }

    handleLongPress() {
      return showDialog(
          context: context,
          builder: (BuildContext bc) {
            return AlertDialog(
              title: const Text("Mais Informações"),
              content: SingleChildScrollView(
                child: ListBody(children: [
                  const Text("Título:",
                      style: TextStyle(fontWeight: FontWeight.bold)),
                  Text(utf8.decode(widget._book.title.codeUnits)),
                  const Text("Autor:",
                      style: TextStyle(fontWeight: FontWeight.bold)),
                  Text(utf8.decode(widget._book.author.codeUnits))
                ]),
              ),
              actions: [
                TextButton(
                  onPressed: () {
                    handleDownloadClick();
                    Navigator.pop(context);
                  },
                  child: const Text("Baixar Livro"),
                ),
                TextButton(
                    onPressed: () {
                      handleTagClick();
                      Navigator.pop(context);
                    },
                    child: const Text("Favoritar Livro"))
              ],
            );
          });
    }

    return GestureDetector(
      onTap: () {
        handleOpen();
      },
      onLongPress: () {
        handleLongPress();
      },
      child: SizedBox(
        width: 100,
        child: Column(children: [
          Stack(
            alignment: Alignment.bottomCenter,
            children: [
              Stack(
                alignment: Alignment.topCenter,
                children: [
                  Image.network(widget._book.coverUrl),
                  Align(
                    alignment: Alignment.topRight,
                    child: InkWell(
                      onTap: () {
                        debugPrint("Favorito");
                        handleTagClick();
                      },
                      child: Icon(
                        widget._book.favorite
                            ? Icons.bookmark
                            : Icons.bookmark_border,
                        color: Colors.red,
                        weight: 25,
                      ),
                    ),
                  ),
                ],
              ),
              Align(
                alignment: Alignment.bottomRight,
                child: InkWell(
                  onTap: () {
                    debugPrint("download");
                    handleDownloadClick();
                  },
                  child: Icon(
                    downloaded
                        ? Icons.download_done
                        : downloading
                            ? Icons.downloading
                            : Icons.download,
                    color: Colors.black,
                  ),
                ),
              ),
            ],
          ),
          Text(
            utf8.decode(widget._book.title.codeUnits),
            style: const TextStyle(fontWeight: FontWeight.bold),
          ),
          Text(utf8.decode(widget._book.author.codeUnits),
              style: const TextStyle(
                  fontStyle: FontStyle.italic, fontWeight: FontWeight.bold)),
        ]),
      ),
    );
  }
}
