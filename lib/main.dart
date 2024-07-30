import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:notes_app/constants.dart';
import 'package:notes_app/core/logic/hive_helper.dart';
import 'package:notes_app/core/logic/observer.dart';
import 'package:notes_app/features/note_model/model.dart';
import 'package:notes_app/views/home/cubit/cubit.dart';
import 'package:notes_app/views/home/view.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  Bloc.observer = SimpleBlocObserver();
  await HiveHelper.init();

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
      designSize: const Size(428, 926),
      builder: (context, child) => BlocProvider(
        create: (context) => NotesCubit(),
        child: MaterialApp(
          debugShowCheckedModeBanner: false,
          theme: ThemeData(
            fontFamily: "poppins",
            brightness: Brightness.dark,
          ),
          home: child,
        ),
      ),
      child: const NotesHomeView(),
    );
  }
}
