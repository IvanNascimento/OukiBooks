import 'package:flutter/material.dart';

import 'package:device_info_plus/device_info_plus.dart';
import 'package:ouki_books/classes/book.dart';
import 'package:path_provider/path_provider.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:vocsy_epub_viewer/epub_viewer.dart';

class ReaderView extends StatefulWidget {
  final Book _book;
  const ReaderView(
    this._book, {
    super.key,
  });

  @override
  State<ReaderView> createState() => _ReaderViewState();
}

class _ReaderViewState extends State<ReaderView> {
  @override
  Widget build(BuildContext context) {
    return Container(color: const Color(0xFFFFE306));
  }
}
