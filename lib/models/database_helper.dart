// ignore_for_file: prefer_const_declarations

import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

class DBHelper {
  static Database? db;

  static Future<void> createDB() async {
    //print('Creating database...');

    // Check if the database instance is already created
    if (db != null) {
      //print('Database instance already exists.');
    } else {
      try {
        String path = join(await getDatabasesPath(), 'notes.db');

        // checking if the database file exists
        bool exists = await databaseExists(path);

        // If the database doesn't exist, create it
        if (!exists) {
          db = await openDatabase(
            path,
            version: 1,
            onCreate: (db, version) async {
              await db.execute(
                'CREATE TABLE notes (id INTEGER PRIMARY KEY AUTOINCREMENT, Title TEXT, Note TEXT, Favourite TEXT)',
              );
            },
          );
          //print('Database created.');
        } else {
          // If the database exists, simply open it
          db = await openDatabase(path, version: 1);
          //print('Database already exists. Opened existing database.');
        }
      } catch (error) {
        //print("Error in database creation is $error");
      }
    }
  }

  // Other methods in your DBHelper class...

  static Future<void> insertToDB(title, note) async {
    try {
      await db?.insert(
          "notes", {"Title": title, "Note": note, "Favourite": "false"});
    } catch (error) {
      //print("Error in insert is $error");
    }
  }

  static Future<void> updateFavouriteStatus(
      int noteId, bool isFavourite) async {
    try {
      await db?.update(
        'notes',
        {'Favourite': isFavourite ? 'true' : 'false'}, // Convert bool to String
        where:
            'id = ?', // In SQLite's UPDATE statement, you typically use placeholders (represented by ?) and the whereArgs parameter to provide the values for those placeholders. This is done for security and to prevent SQL injection attacks.
        whereArgs: [noteId],
      );
    } catch (error) {
      //print("Error updating favourite status: $error");
    }
  }

  static Future<List<Map<String, dynamic>>?> getDataFromDB() async {
    var result = await db?.query('notes');
    return result;
  }
}
