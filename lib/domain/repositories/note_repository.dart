import 'package:notelist/domain/models/note.dart';

abstract class NoteRepository{

  addNote(Note note);

  getNote(int id);

  Future<List<Note>> getAllNotes();

  updateNote(Note note);

  deleteNote(int id);
}
