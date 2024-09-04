import 'package:flutter/cupertino.dart';

class LoginPageViewModel with ChangeNotifier {
  String? errorMessage;

  String? validateEmail(TextEditingController emailController) {
    emailController.addListener(() {
      final email = emailController.text;
      if (email.isEmpty) {
        errorMessage = null;
        notifyListeners();
      } else if (!email.contains('@')) {
        errorMessage = 'Email must contain a "@" symbol';
        notifyListeners();

      } else {
        errorMessage = null;
        notifyListeners();
      }
    });

    return errorMessage;
  }
}
