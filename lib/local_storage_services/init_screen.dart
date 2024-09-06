import 'package:shared_preferences/shared_preferences.dart';

class InitScreen{
  int? initScreen;

  Future<void> setInitScreen()async{
    SharedPreferences preferences = await SharedPreferences.getInstance();
    await preferences.setInt("initScreen", 1);

  }
  Future<int?> getInitScreen()async{
    SharedPreferences preferences = await SharedPreferences.getInstance();
    initScreen = preferences.getInt("initScreen");
    return initScreen;
  }
}