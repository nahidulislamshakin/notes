import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
//import 'package:go_router/go_router.dart';
import 'package:notes/View/home_page.dart';

import '../firebase_services/firebase_services.dart';
import '../utils/input_box.dart';
import '../utils/utils.dart';
import 'login_page.dart';

class RegistrationPage extends StatefulWidget {

  @override
  State<RegistrationPage> createState() => _RegistrationPageState();
}

class _RegistrationPageState extends State<RegistrationPage> {
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final TextEditingController nameController = TextEditingController();
  String? errorMessage;
  bool valid = true;
  final _formKey = GlobalKey<FormState>();
  @override
  void dispose() {
    // TODO: implement dispose
    emailController.dispose();
    passwordController.dispose();
    nameController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    final height = MediaQuery.of(context).size.height;
    final keyboardHeight = MediaQuery.of(context).viewInsets.bottom;
    final availableHeight = height - keyboardHeight;
    final firebaseServices = FirebaseServices();

    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: SafeArea(
        child: SingleChildScrollView(
          child: SizedBox(
            width: width,
            height: availableHeight,
            child: Padding(
              padding: const EdgeInsets.all(12.0),
              child: Form(
                key: _formKey,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    //Title of the Login Page
                    Text(
                      "Registration",
                      style: Theme.of(context).textTheme.titleLarge,
                    ),
                    SizedBox(height: 15.h),

                    InputBox(
                      textField: TextFormField(
                        style: TextStyle(color: Colors.black,fontWeight: FontWeight.normal,fontSize: 17.sp),
                        controller: nameController,
                        decoration: InputDecoration(
                          labelText: "Name",
                          labelStyle:
                              TextStyle(color: Colors.grey, fontSize: 14.sp),
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(12.r),
                          ),
                        ),
                      ),
                    ),

                    SizedBox(
                      height: 25.h,
                    ),

                    //InputBox is a custom design for TextFormField
                    InputBox(
                      textField: TextFormField(
                        style: TextStyle(color: Colors.black,fontWeight: FontWeight.normal,fontSize: 17.sp),
                        controller: emailController,
                        keyboardType: TextInputType.emailAddress,
                        decoration: InputDecoration(
                          fillColor: Colors.white,
                          filled: true,
                          labelText: "Enter Email",
                          labelStyle:
                              TextStyle(color: Colors.grey, fontSize: 14.sp),
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(12.r),
                          ),
                        ),
                      ),
                    ),
                    SizedBox(height: 25.h),
                    InputBox(
                      textField: TextFormField(
                        style: TextStyle(color: Colors.black,fontWeight: FontWeight.normal,fontSize: 17.sp),
                       // obscureText: true,
                        controller: passwordController,
                        decoration: InputDecoration(
                          labelText: "Enter Password",
                          labelStyle:
                              TextStyle(color: Colors.grey, fontSize: 14.sp),
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(12.r),
                          ),
                        ),
                      ),
                    ),

                    SizedBox(height: 25.h),
                    ElevatedButton(
                      onPressed: () async {
                        if (kDebugMode) {
                          print("Email: ${emailController.text}, Password: ${passwordController.text}");
                        }

                        await firebaseServices.signUp(
                            email: emailController.text,
                            password: passwordController.text,
                            name: nameController.text);
                        if (FirebaseAuth.instance.currentUser!=null) {
                          context.pushReplacement('/home');
                        }
                        else {
                          // Handle the case where user creation failed
                          Utils.toastMessage("Failed to register. Please try again");
                        }
                      },
                      child: Text(
                        "Registration",
                        style: Theme.of(context).textTheme.labelLarge,
                      ),
                    ),
                    SizedBox(height: 5.h),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          "Already have an account?",
                          style: Theme.of(context).textTheme.bodyMedium,
                        ),
                        TextButton(
                          onPressed: () {
                            context.push('/login');
                          },
                          child: Text(
                            "Login",
                            style: Theme.of(context).textTheme.labelLarge,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
