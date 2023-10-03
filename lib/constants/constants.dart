// ignore_for_file: prefer_const_declarations

import 'package:flutter/material.dart';
import 'package:sqflite/sqflite.dart';

class DBHelper {
  static const int _version = 1;
  static const String _tableName = 'tasks';
  static Database? db;

  static Future<void> initDb() async {
    if (db != null) {
      debugPrint('not null db');
    } else {
      try {
        String path = await getDatabasesPath() + 'task.db';
        db = await openDatabase(
          path,
          version: _version,
          onCreate: (db, version) async {
            await db.execute(
              'CREATE TABLE $_tableName ('
              'id INTEGER PRIMARY KEY AUTOINCREMENT,'
              ' title STRING, '
              ' note TEXT, '
              ' date STRING, '
              ' startTime STRING, '
              ' endTime STRING, '
              ' remind INTEGER,'
              ' repeat STRING, '
              ' color INTEGER,'
              ' isCompleted INTEGER)',
            );
          },
        );
      } catch (e) {
        print(e);
      }
    }
  }

  //
  // static Future<List<Map<String, Object?>>> query() async {
  //   print('query function called');
  //   return await db!.query(_tableName);
  // }

  // static Future<int> delete(Task? task) async {
  //   print('delete function called');
  //   return await db!.delete(_tableName, where: 'id = ?', whereArgs: [task!.id]);
  // }

  Future<void> createDB() async {
    print('Creating database...');
    try {
      db = await openDatabase(
        "notes.db",
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

  Future<void> insertToDB(title, note) async {
    try {
      await db?.insert("notes", {"Title": title, "Note": note});
    } catch (error) {
      print("Error in insert is $error");
    }
  }

  Future<List<Map<String, dynamic>>?> getDataFromDB() async {
    return await db?.query('notes');
  }

  static Future<int> deleteAll() async {
    print('deleteAll function called');
    return await db!.delete(_tableName);
  }

  static Future<int> updateraw(int id) async {
    print('updateraw function called');
    return await db!.rawUpdate('''
    UPDATE tasks
    SET isCompleted = ?
    WHERE  id = ?
    ''', [1, id]);
  }
}
