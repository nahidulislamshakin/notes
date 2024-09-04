import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

//Custom Design for Email Password Input Field
class InputBox extends StatelessWidget {
  final double width;
  final double height;
  final Widget textField;

  const InputBox(
      {super.key,
        required this.width,
        required this.height,
        required this.textField,
      });
  @override
  Widget build(BuildContext context) {
    return Container(
      height: 55.h,
      margin: EdgeInsets.only(left: 30.w, right: 30.w),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12.r),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.5),
            spreadRadius: 0.1.r,
            blurRadius: 10.r,
            offset: const Offset(0, 7),
          )
        ],
      ),
      child: textField,
    );
  }
}