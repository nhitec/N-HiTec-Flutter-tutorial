import 'dart:async';

import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

import 'note.dart';

class NoteDatabaseHelper {
  static final NoteDatabaseHelper _instance = NoteDatabaseHelper._internal();
  static Database? _database;

  factory NoteDatabaseHelper() => _instance;

  NoteDatabaseHelper._internal();

  Future<Database> get database async {
    _database ??= await _initDatabase();
    return _database!;
  }

  Future<Database> _initDatabase() async {
    String path = join(await getDatabasesPath(), 'notes.db');
    return await openDatabase(path, version: 1, onCreate: (db, version) async {
      await db.execute('''
          CREATE TABLE notes (
            id INTEGER PRIMARY KEY AUTOINCREMENT,
            title TEXT NOT NULL,
            content TEXT,
            creationDate INTEGER NOT NULL,
            editionDate INTEGER NOT NULL
          )
        ''');
    });
  }

  Future<void> addNote(Note note) async {
    final db = await database;
    int id = await db.insert(
      'notes',
      note.toMap(),
      conflictAlgorithm: ConflictAlgorithm.replace,
    );
    note.id = id;
  }

  Future<void> deleteNote(Note note) async {
    final db = await database;
    await db.delete(
      'notes',
      where: 'id = ?',
      whereArgs: [note.id],
    );
  }

  Future<void> editNote(Note note) async {
    final db = await database;
    note.editionDate = DateTime.now();
    await db.update(
      'notes',
      note.toMap(),
      where: 'id = ?',
      whereArgs: [note.id],
    );
  }

  Future<List<Note>> getNotes() async {
    final db = await database;
    final List<Map<String, dynamic>> maps = await db.query(
      'notes',
      orderBy: 'editionDate DESC',
    );
    return maps.map((map) => Note.fromMap(map)).toList();
  }
}
