import 'package:flutter/material.dart';
import 'package:notelist/data/repositories/note_repository_impl.dart';
import 'package:notelist/domain/models/note.dart';

// class NoteProvider{

//   List<Note>? list;

//   Future<List<Note>> loadNoteData() async {
   
//     return NoteRepositoryImpl.db.getAllNotes(); 
//   }
// }

class NoteProviderChange extends ChangeNotifier{
  Future<List<Note>>? _list;

  Future<List<Note>>? get list {
    if (_list == null) loadNoteData();
    return _list;
  }

  void loadNoteData() {
    _list = NoteRepositoryImpl.db.getAllNotes(); 
  }

  void update(Note note){
    NoteRepositoryImpl.db.updateNote(note);
    loadNoteData();
    notifyListeners();
  }

  void add(String title, String text) {
    Note newNote = Note(title: title, text: text);
    NoteRepositoryImpl.db.addNote(newNote);
    loadNoteData();
    notifyListeners();
  }

  delete(int id) {
    NoteRepositoryImpl.db.deleteNote(id);
    loadNoteData();
    notifyListeners();
  }
}