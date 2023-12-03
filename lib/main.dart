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

class MainApp extends StatefulWidget {
  const MainApp({super.key});

  @override
  State<MainApp> createState() => _MainAppState();
}

class _MainAppState extends State<MainApp> {
  final NotesCubit _notesCubit = NotesCubit();

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => NotesCubit(),
      child: MaterialApp(
        routes: {
          '/': (context) => BlocProvider.value(
                value: _notesCubit,
                child: const Notes(),
              ),
          '/new_note': (context) => BlocProvider.value(
                value: _notesCubit,
                child: NewNote(),
              ),
          '/fav_note': (context) => BlocProvider.value(
                value: _notesCubit,
                child: const NotesFavourite(),
              )
        },
        debugShowCheckedModeBanner: false,
      ),
    );
  }

  @override
  void dispose() {
    _notesCubit.close();
    super.dispose();
  }
}
