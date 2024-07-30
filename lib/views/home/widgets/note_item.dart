import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:notes_app/core/logic/hive_helper.dart';

import '../../../features/note_model/model.dart';
import '../../edit_note/view.dart';
import '../cubit/cubit.dart';

class NoteItem extends StatelessWidget {
  const NoteItem({super.key, required this.note});

  final NoteModel note;
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => EditNoteView(note: note),
            ));
      },
      child: Container(
        padding:
        EdgeInsetsDirectional.only(top: 24.h, bottom: 24.h, start: 16.w),
        decoration: BoxDecoration(
          color: const Color(0xffffcc80),
          borderRadius: BorderRadius.circular(16.r),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.end,
          children: <Widget>[
            ListTile(
              title: Text(
                note.title,
                style: TextStyle(
                  color: Colors.black,
                  fontSize: 26.sp,
                ),
              ),
              subtitle: Padding(
                padding: EdgeInsets.symmetric(vertical: 16.h),
                child: Text(
                  note.subTitle,
                  style: TextStyle(
                    color: Colors.black.withOpacity(.45),
                    fontSize: 18.sp,
                  ),
                ),
              ),
              trailing: IconButton(
                onPressed: () {
                  note.delete();
                  BlocProvider.of<NotesCubit>(context).getNotes();
                },
                icon: Icon(
                  FontAwesomeIcons.trash,
                  color: Colors.black,
                  size: 24.w,
                ),
              ),
            ),
            Padding(
              padding: EdgeInsetsDirectional.only(end: 24.w),
              child: Text(
                note.date,
                style: TextStyle(color: Colors.black.withOpacity(.45)),
              ),
            )
          ],
        ),
      ),
    );
  }
}