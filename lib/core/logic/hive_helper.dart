import 'package:hive_flutter/adapters.dart';

import '../../features/note_model/model.dart';

class HiveHelper {
  static const kNotesBox = "notes_box";
  static late Box<NoteModel> notesBox;

  static Future<void> openNoteBox() async{

    notesBox= await Hive.openBox<NoteModel>(kNotesBox);
  }

  static Future<void> addNote(NoteModel note) async {
    await notesBox.add(note);
  }
  static List<NoteModel> getNotes(){
    return notesBox.values.toList();
  }

  static Future<void> init() async{
    await Hive.initFlutter();
    Hive.registerAdapter(NoteModelAdapter());
    await openNoteBox();
  }
}
