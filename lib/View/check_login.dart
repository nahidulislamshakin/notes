import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:notes/View/login_page.dart';

import 'home_page.dart';

class CheckLogin extends StatelessWidget{
  @override
  Widget build(BuildContext context) {
    return FirebaseAuth.instance.currentUser == null ? LoginPage() : HomePage();
  }
}