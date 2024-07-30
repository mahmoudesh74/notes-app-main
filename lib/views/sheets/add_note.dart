import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:intl/intl.dart';
import 'package:notes_app/views/home/cubit/cubit.dart';

import '../../constants.dart';
import '../../core/design/app_input.dart';
import '../../features/note_model/model.dart';
import '../home/cubit.dart';
import '../home/states.dart';

class AddNoteSheet extends StatelessWidget {
  const AddNoteSheet({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => AddNoteCubit(),
      child: BlocListener<AddNoteCubit, AddNotesStates>(
        listener: (context, state) {
          if (state is AddNoteFailed) {
            debugPrint("Failed : ${state.errorMsg}");
          }
          if (state is AddNoteSuccess) {
            Navigator.pop(context);
            BlocProvider.of<NotesCubit>(context).getNotes();
          }
        },
        child: const _AddNoteForm(),
      ),
    );
  }
}

class _AddNoteForm extends StatefulWidget {
  const _AddNoteForm({this.isLoading = false});

  @override
  State<_AddNoteForm> createState() => _AddNoteSheetState();

  final bool isLoading;
}

class _AddNoteSheetState extends State<_AddNoteForm> {
  final formKey = GlobalKey<FormState>();
  AutovalidateMode autoValidate = AutovalidateMode.disabled;
  String? title, subTitle;

  @override
  Widget build(BuildContext context) {
    return Form(
      key: formKey,
      autovalidateMode: autoValidate,
      child: SingleChildScrollView(
        padding: EdgeInsets.only(
            left: 16.w,
            right: 16.w,
            bottom: MediaQuery.of(context).viewInsets.bottom),
        child: Column(
          children: [
            SizedBox(
              height: 24.h,
            ),
            AppInput(
              hintText: "Title",
              onSaved: (value) {
                title = value;
              },
            ),
            SizedBox(
              height: 24.h,
            ),
            AppInput(
              hintText: "Content",
              maxLines: 5,
              onSaved: (value) {
                subTitle = value;
              },
            ),
            SizedBox(
              height: 24.h,
            ),
            FilledButton(
              onPressed: widget.isLoading
                  ? null
                  : () {
                      if (formKey.currentState!.validate()) {
                        formKey.currentState!.save();
                        var dateTime = DateTime.now();
                        var formattedDate =
                            DateFormat("dd-mm--yy").format(dateTime);
                        var noteModel = NoteModel(
                            title: title!,
                            subTitle: subTitle!,
                            date: formattedDate,
                            color: Colors.blue.value);
                        BlocProvider.of<AddNoteCubit>(context)
                            .addNote(noteModel);
                      } else {
                        autoValidate = AutovalidateMode.always;
                      }
                      setState(() {});
                    },
              style: FilledButton.styleFrom(
                  backgroundColor: kPrimaryColor,
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(15.r)),
                  minimumSize: Size(double.infinity, 67.h)),
              child: Text(
                "Add",
                style: TextStyle(fontSize: 20.sp, fontWeight: FontWeight.w600),
              ),
            ),
            SizedBox(
              height: 24.h,
            )
          ],
        ),
      ),
    );
  }
}
