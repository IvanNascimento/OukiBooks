import 'package:flutter/material.dart';
import 'package:ouki_books/views/bookcase.dart';

class HomeView extends StatefulWidget {
  const HomeView({super.key});

  @override
  State<HomeView> createState() => _HomeViewState();
}

class _HomeViewState extends State<HomeView> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(title: const Text('Ouki Books')),
        body: const BookCaseView());
  }
}
