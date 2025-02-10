import 'package:flutter/cupertino.dart';
import 'package:formation/data/note_database.dart';

import 'note.dart';

class NoteDatabaseProvider with ChangeNotifier {
  List<Note>? _notes;

  List<Note>? get notes => _notes;

  NoteDatabaseProvider() {
    _fetchNotes();
  }

  Future<void> _fetchNotes() async {
    _notes = await NoteDatabaseHelper().getNotes();
    notifyListeners();
  }

  Future<void> addNote(Note note) async {
    await NoteDatabaseHelper().addNote(note);
    await _fetchNotes();
  }

  Future<void> deleteNote(Note note) async {
    await NoteDatabaseHelper().deleteNote(note);
    await _fetchNotes();
  }

  Future<void> editNote(Note note) async {
    await NoteDatabaseHelper().editNote(note);
    await _fetchNotes();
  }
}
