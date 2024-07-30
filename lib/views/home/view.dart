import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

import '../../constants.dart';
import '../sheets/add_note.dart';
import 'cubit/cubit.dart';
import 'widgets/note_item.dart';

class NotesHomeView extends StatefulWidget {
  const NotesHomeView({super.key});

  @override
  State<NotesHomeView> createState() => _NotesHomeViewState();
}

class _NotesHomeViewState extends State<NotesHomeView> {
  late NotesCubit cubit;

  @override
  void initState() {
    super.initState();
    cubit = BlocProvider.of(context)..getNotes();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          showModalBottomSheet(
            isScrollControlled: true,
            context: context,
            builder: (context) => const AddNoteSheet(),
          );
        },
        shape: const CircleBorder(),
        backgroundColor: kPrimaryColor,
        child: const Icon(FontAwesomeIcons.plus, color: Colors.black, size: 18),
      ),
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 24.w, vertical: 16.h)
              .copyWith(bottom: 0),
          child: Column(
            children: [
              Row(
                children: [
                  Text("Notes", style: TextStyle(fontSize: 28.sp)),
                  const Spacer(),
                  Container(
                    width: 46.w,
                    height: 46.w,
                    decoration: BoxDecoration(
                      color: Colors.white.withOpacity(.06),
                      borderRadius: BorderRadius.circular(16.r),
                    ),
                    child: const Icon(Icons.search, size: 28),
                  )
                ],
              ), //custom appbar
              SizedBox(height: 24.h),
              Expanded(
                child: BlocBuilder(
                    bloc: cubit,
                    builder: (context, state) {
                      return ListView.separated(
                          padding: EdgeInsets.only(bottom: 24.h),
                          itemBuilder: (context, index) =>
                              NoteItem(note: cubit.notes![index]),
                          separatorBuilder: (context, index) =>
                              SizedBox(height: 16.h),
                          itemCount: (cubit.notes?.length) ?? 0);
                    }),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
