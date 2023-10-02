import 'package:flutter/material.dart';

import 'modules/note_page/notes_page.dart';

void main() {
  runApp(const MainApp());
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      home: Notes(),
      debugShowCheckedModeBanner: false,
    );
  }
}
