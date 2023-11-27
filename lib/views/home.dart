import 'package:flutter/material.dart';
import 'package:ouki_books/views/bookcase.dart';

class HomeView extends StatefulWidget {
  const HomeView({super.key});

  @override
  State<HomeView> createState() => _HomeViewState();
}

class _HomeViewState extends State<HomeView> {
  bool filterFavorites = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
            title: const Text('Ouki Books'),
            centerTitle: true,
            backgroundColor: Colors.blue[200],
            elevation: 5,
            actions: [
              IconButton(
                  tooltip: "Favoritos",
                  onPressed: () {
                    filterFavorites = !filterFavorites;
                    setState(() {});
                  },
                  icon: Icon(filterFavorites
                      ? Icons.bookmark_sharp
                      : Icons.bookmark_outline_sharp))
            ]),
        body: SafeArea(
            child: BookCaseView(
          favorites: filterFavorites,
        )));
  }
}
