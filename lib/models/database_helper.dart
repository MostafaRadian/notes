// ignore_for_file: prefer_const_declarations

import 'package:sqflite/sqflite.dart';

class DBHelper {
  static Database? db;

  static Future<void> createDB() async {
    print('Creating database...');
    if (db != null) {
      print('not null db');
    } else {
      try {
        String path = "${await getDatabasesPath()}/notes.db";
        db = await openDatabase(
          path,
          version: 1,
          onCreate: (db, version) async {
            await db.execute(
              'CREATE TABLE notes (id INTEGER PRIMARY KEY AUTOINCREMENT, Title TEXT, Note TEXT)',
            );
          },
        );
      } catch (error) {
        print("error in creation is $error");
      }
      print('Database created.');
    }
  }

  static Future<void> insertToDB(title, note) async {
    try {
      await db?.insert("notes", {"Title": title, "Note": note});
    } catch (error) {
      print("Error in insert is $error");
    }
  }

  static Future<List<Map<String, dynamic>>?> getDataFromDB() async {
    var result = await db?.query('notes');
    return result;
  }
}
