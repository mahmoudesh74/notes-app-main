import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hive/hive.dart';
import 'package:hive_flutter/adapters.dart';
import 'package:notes_app/core/logic/hive_helper.dart';
import 'package:notes_app/views/home/cubit/states.dart';

import '../../../constants.dart';
import '../../../features/note_model/model.dart';

class NotesCubit extends Cubit<NotesStates> {
  NotesCubit() : super(NotesInitialState());
  // List<NoteModel> list=[];
  List<NoteModel>? notes;
  void getNotes() {
    try {
      // list.addAll(HiveHelper.getNotes());
      var notesBox=Hive.box<NoteModel>(HiveHelper.kNotesBox);
      notes =notesBox.values.toList();
      emit(NotesSuccessState(),);
    } catch (e) {
      emit(NotesFailedState(errorMsg: e.toString())

      );
      debugPrint(e.toString());
    }
    debugPrint("List length : ${notes?.length}");
  }
}
