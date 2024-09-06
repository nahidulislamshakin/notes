import 'package:firebase_auth/firebase_auth.dart';
import 'package:go_router/go_router.dart';
import 'package:notes/View/home_page.dart';
import 'package:notes/View/registration_page.dart';
import 'package:notes/firebase_services/firebase_services.dart';
import 'package:notes/local_storage_services/init_screen.dart';
import 'package:notes/main.dart';
import 'package:notes/utils/utils.dart';

import '../utils/input_box.dart';
import '/view_model/loginPage_viewmodel.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class LoginPage extends StatefulWidget {
  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  String? errorMessage;
  bool valid = true;
  final _formKey = GlobalKey<FormState>();



  @override
  void initState() {
    setState(() {
      SetInitScreen();
    });

    super.initState();
  }
  @override
  void dispose() {
    // TODO: implement dispose
    emailController.dispose();
    passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    final height = MediaQuery.of(context).size.height;
    final keyboardHeight = MediaQuery.of(context).viewInsets.bottom;
    final availableHeight = height - keyboardHeight;
    final firebaseServices = FirebaseServices();
    FocusNode _focusNode = FocusNode();

    return FirebaseAuth.instance.currentUser != null ? HomePage() : Scaffold(
      //resizeToAvoidBottomInset: false,
      body: SafeArea(
        child: SingleChildScrollView(
          child: Container(
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
                      "Login",
                      style: Theme.of(context).textTheme.titleLarge,
                    ),
                    SizedBox(height: 15.h),

                    //InputBox is a custom design for TextFormField
                    InputBox(
                      width: width,
                      height: height,
                      textField: TextFormField(
                        autofillHints: null,
                        onTap: () {
                          // Prevent navigation or state changes when tapping on the input
                          setState(() {
                            _focusNode.requestFocus();
                          });
                        },
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
                      width: width,
                      height: height,
                      textField: TextFormField(
                        autofillHints: null,
                        onTap: () {
                          // Prevent navigation or state changes when tapping on the input
                          setState(() {
                            _focusNode.requestFocus();
                          });
                        },
                        obscureText: true,
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
                    SizedBox(height: 10.h),
                    ElevatedButton(
                      onPressed: () async {
                        await firebaseServices.login(email: emailController.text, password: passwordController.text);
                        if(FirebaseAuth.instance.currentUser != null ){
                          context.go('/home');
                        }
                        else{
                          Utils.toastMessage("Invalid Email or Password");
                        }
                      },
                      child: Text(
                        "Login",
                        style: Theme.of(context).textTheme.labelLarge,
                      ),
                    ),
                    SizedBox(height: 5.h),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          "Don't have an account?",
                          style: Theme.of(context).textTheme.bodyMedium,
                        ),
                        TextButton(
                          onPressed: () {
                            if(FirebaseAuth.instance.currentUser == null){
                              context.push('/registration');
                              print("Navigating is not working");
                            }

                          },
                          child: Text(
                            "SIGN UP",
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


