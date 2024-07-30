
import 'package:notes_app/features/note_model/model.dart';

class NotesStates {}

class NotesInitialState extends NotesStates {}

class NotesLoadingState extends NotesStates {}

class NotesSuccessState extends NotesStates {
}

class NotesFailedState extends NotesStates {
  final String errorMsg;

  NotesFailedState({required this.errorMsg});
}
