import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:notes_app/modules/note_favourite/notes_favourite.dart';

import 'models/database_helper.dart';
import 'models/notes_cubit.dart';
import 'modules/new_note/new_note.dart';
import 'modules/note_page/notes_page.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await DBHelper.createDB();
  runApp(const MainApp());
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => NotesCubit()..getNotes(),
      child: MaterialApp(
        routes: {
          '/': (context) => const Notes(),
          '/new_note': (context) => NewNote(),
          '/fav_note': (context) => const NotesFavourite(),
        },
        debugShowCheckedModeBanner: false,
      ),
    );
  }
}
