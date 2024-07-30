
class AddNotesStates {}

class NotesInitialState extends AddNotesStates {}

class AddNoteLoading extends AddNotesStates {}

class AddNoteSuccess extends AddNotesStates {}

class AddNoteFailed extends AddNotesStates {
  final String errorMsg;

  AddNoteFailed({required this.errorMsg});
}