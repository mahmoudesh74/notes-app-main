import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../constants.dart';

class AppInput extends StatelessWidget {
  const AppInput({super.key, required this.hintText, this.maxLines=1, this.onSaved, this.onchange});

  final String hintText;
  final int maxLines;
  final void Function(String?)? onSaved,onchange;
  @override
  Widget build(BuildContext context) {
    return TextFormField(
      cursorColor: kPrimaryColor,
      maxLines: maxLines,
      validator: (val){
        if(val?.isEmpty ??true){
          return "Field is required";
        }
      },
      onSaved: onSaved,
      onChanged: onchange,
      decoration: InputDecoration(
          border: buildBorder(Colors.white),
          enabledBorder: buildBorder(Colors.white),
          focusedBorder: buildBorder(kPrimaryColor),
          hintText: hintText,
          hintStyle: const TextStyle(color: Colors.white70)
      ),
    );
  }
}

OutlineInputBorder buildBorder(color){
  return OutlineInputBorder(
      borderRadius: BorderRadius.circular(12.r),
      borderSide: BorderSide(color: color)
  );
}