import 'dart:async';
import 'package:flutter/material.dart';
import 'login_page.dart';
import 'package:go_router/go_router.dart';

class Welcome extends StatefulWidget {
  @override
  _WelcomeState createState() => _WelcomeState();
}

class _WelcomeState extends State<Welcome> {

  //initState is used to wait 3 second after navigating this page.
  @override
  void initState() {
    super.initState();
    _navigate();
  }

  Future<void> _navigate() async {

    //Wait for 3 seconds to go to the Login Page
     Timer(const Duration(seconds: 3),(){
      // Navigator.pushReplacement(context, MaterialPageRoute(builder: (context)=> LoginPage()));
       //context.go('/login');
       context.pushReplacement('/login');
     });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Text(
          "Welcome to Note App",
          style: Theme.of(context).textTheme.titleLarge,
        ),
      ),
    );
  }
}
