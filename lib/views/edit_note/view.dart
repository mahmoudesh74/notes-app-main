import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

import '../../core/design/app_input.dart';
import '../../features/note_model/model.dart';
import '../home/cubit/cubit.dart';

class EditNoteView extends StatefulWidget {
  const EditNoteView({super.key, required this.note});

  final NoteModel note;

  @override
  State<EditNoteView> createState() => _EditNoteViewState();
}

class _EditNoteViewState extends State<EditNoteView> {
  String? title, subTitle;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 16.h, vertical: 24.h),
          child: Column(
            children: [
              Row(
                children: [
                  Text(
                    "Edit Note",
                    style:
                        TextStyle(fontSize: 26.sp, fontWeight: FontWeight.w500),
                  ),
                  const Spacer(),
                  Container(
                    width: 46.w,
                    height: 46.w,
                    decoration: BoxDecoration(
                      color: Colors.white.withOpacity(.06),
                      borderRadius: BorderRadius.circular(16.r),
                    ),
                    child: IconButton(
                      onPressed: () {
                        widget.note.title = title ?? widget.note.title;
                        widget.note.subTitle = subTitle ?? widget.note.subTitle;
                        widget.note.save();
                        BlocProvider.of<NotesCubit>(context).getNotes;
                        Navigator.pop(context);
                      },
                      icon: Icon(FontAwesomeIcons.check, size: 24.w),
                    ),
                  )
                ],
              ),
              SizedBox(
                height: 60.h,
              ),
              AppInput(
                hintText: widget.note.title,
                onchange: (value) {
                  title = value;
                },
              ),
              SizedBox(height: 24.h),
              AppInput(
                hintText: widget.note.subTitle,
                maxLines: 5,
                onchange: (value) {
                  subTitle = value;
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
