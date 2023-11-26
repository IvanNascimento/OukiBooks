import 'package:flutter/material.dart';
import 'package:ouki_books/views/home.dart';

void main() {
  runApp(const OukiBooks());
}

class OukiBooks extends StatelessWidget {
  const OukiBooks({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: const HomeView(),
    );
  }
}
