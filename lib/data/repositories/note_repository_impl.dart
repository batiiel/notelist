import 'dart:io';
import 'package:notelist/domain/models/note.dart';
import 'package:notelist/domain/repositories/note_repository.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path_provider/path_provider.dart';
// ignore: depend_on_referenced_packages
import 'package:path/path.dart';

class NoteRepositoryImpl implements NoteRepository{
  NoteRepositoryImpl._();
  static final NoteRepositoryImpl db = NoteRepositoryImpl._();

  static  Database? _database;

  Future<Database?> get database async {
     return _database ?? await initDB();
  }

  initDB() async {
    Directory documentsDirectory = await getApplicationDocumentsDirectory();
    String path = join(documentsDirectory.path, "NoteDB.db");
    return await openDatabase(path,
        version: 1,
        onOpen: (db) {},
        onCreate: (Database db, int versio) async {
          await db.execute("""CREATE TABLE Note (
              id INTEGER PRIMARY KEY,
              title TEXT,
              text TEXT
          )""");
        });
  }

  @override
  addNote(Note note) async {
    final db = await database;
    var res = await db!.insert("Note", note.toJson());
    return res;
  }

  @override
  getNote(int id) async{
    final db = await database;
    var res = await db!.query("Note",where: "id = ?", whereArgs: [id]);
    return res.isNotEmpty ? Note.fromJson(res.first) : null;
  }

  @override
  Future<List<Note>> getAllNotes() async {
    final db = await database;
    var res = await db!.query("Note");
    List<Note> list = res.isNotEmpty ? res.map((e) => Note.fromJson(e)).toList() : [];
    return list;
  }

  @override
  updateNote(Note note) async {
    final db = await database;
    var res = await db!.update("Note", note.toJson(), where: "id = ?", whereArgs: [note.id]);
    return res;
  }

  @override
  deleteNote(int id) async {
    final db = await database;
    db!.delete("Note",where: "id = ?", whereArgs: [id]);
    updateIdTable(id);
  }

  updateIdTable(int id) async {
    final db = await database;
    var res = await db!.query("Note", where: "id > ?", whereArgs: [id]);
    List<Note> list = res.map((e) => Note.fromJson(e)).toList();
    for(Note item in list){
      db.update("Note", {'id': item.id! - 1}, where: "id = ?", whereArgs: [item.id]);
    }

  }

}
