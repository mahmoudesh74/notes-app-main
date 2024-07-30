import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hive_flutter/adapters.dart';
import 'package:notes_app/constants.dart';
import 'package:notes_app/core/logic/hive_helper.dart';
import 'package:notes_app/features/note_model/model.dart';
import 'package:notes_app/views/home/states.dart';

class AddNoteCubit extends Cubit<AddNotesStates> {
  AddNoteCubit() : super(NotesInitialState());

  addNote(NoteModel note) async {
    emit(AddNoteLoading());
    try {
      HiveHelper.addNote(note);
      emit(AddNoteSuccess());
    } catch (e) {
      emit(AddNoteFailed(errorMsg: e.toString()));
    }
  }
}
