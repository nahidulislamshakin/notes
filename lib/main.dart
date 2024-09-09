import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:go_router/go_router.dart';
import 'package:notes/View/add_note_page.dart';
import 'package:notes/View/registration_page.dart';
import 'package:notes/local_storage_services/init_screen.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'View/home_page.dart';
import 'View/login_page.dart';
import 'View/welcome.dart';

//Declaring initScreen to check if the app firest time run or not
int? initScreen;

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  //Ensure Firebase initializing
  await Firebase.initializeApp(
    options: const FirebaseOptions(
      apiKey: "AIzaSyB7aFyC1_E4v5N4m2_MiMVHmG0vohJ59Nc",
      appId: "1:1008363445308:android:dd9b03e3a5e827d4887739",
      projectId: "notes-94524",
      messagingSenderId: "1008363445308",
    ),
  );

  //SharedPreferences is used to store initScreen value locally
  SharedPreferences preferences = await SharedPreferences.getInstance();
  initScreen = preferences.getInt("initScreen");
  //After install initScreen is set to 1, other the value is 0 because it is a global variable
  await preferences.setInt("initScreen", 1);

  //ScreenUtil is package to make the widget width, height, radius, fontSize responsive
  await ScreenUtil.ensureScreenSize();
  runApp(
    const MyApp(),
  );
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {

  final router = GoRouter(
    initialLocation: (initScreen == null || initScreen == 0) ? '/welcome' : '/login',
    routes: <RouteBase> [

      GoRoute(
          path: '/login',
          builder: (context, state) {

            return LoginPage();
          }
      ),
      GoRoute(
        path: '/home',
        builder: (context, state) {

          return HomePage();
        },
      ),
      GoRoute(
        path: '/registration',
        builder: (context, state) {
          return RegistrationPage();
        },
      ),
      GoRoute(
        path: '/add',
        builder: (context, state) {
          return AddNotePage();
        },
      ),

      GoRoute(
        path: '/welcome',
        builder: (context, state) {
          return Welcome();
        },
      )
    ],
    // redirect: (BuildContext context, GoRouterState state) {
    //   final loggedIn = FirebaseAuth.instance.currentUser != null;
    //   final signingUp = state.uri.toString() == '/registration';
    //   final loggingIn = state.uri.toString() == '/login';
    //
    //   //Checking whether it is login or not, if not, again check the app is first time loaded or not.
    //   //For the first time loaded app will navigate to welcome page. which is splash screen.
    //   //After 3 second app will go to the login page
    //   if (!loggedIn && !signingUp && !loggingIn ) {
    //
    //     if(initScreen == null || initScreen == 0){
    //       return '/welcome';
    //     }
    //     return '/';
    //     // else {
    //     //   if(!loggingIn && !loggedIn){
    //     //     return '/login';
    //     //   }
    //     //   else if(!loggedIn && !signingUp){
    //     //     return '/registration';
    //     //   }
    //     // }
    //
    //
    //   }
    //   // Do not trigger a rebuild when already on the right page
    //   if (signingUp || loggingIn) {
    //     return null; // No redirection needed, avoid unnecessary rebuilds
    //   }
    //
    //   // if (loggedIn) {
    //   //   return '/'; // Redirect to home if already logged in
    //   // }
    //
    //   return null; // No redirection
    // },
  );



  @override
  Widget build(BuildContext context) {
    final deviceWidth = MediaQuery.of(context).size.width;
    final deviceHeight = MediaQuery.of(context).size.height;


    return ScreenUtilInit(
      designSize: Size(deviceWidth, deviceHeight),
      minTextAdapt: true,
      splitScreenMode: false,
      builder: (context, child) {
        return MaterialApp.router(
           routerConfig: router,
          theme: ThemeData(
            primarySwatch: Colors.blue,
            appBarTheme: AppBarTheme(
              backgroundColor: Colors.grey,
              centerTitle: true,
              elevation: 8.0,
              titleTextStyle: TextStyle(color: Colors.white, fontWeight: FontWeight.bold, fontSize: 30.sp),
            ),
            textTheme: TextTheme(
              bodyLarge:
              TextStyle(fontSize: 18.sp, fontWeight: FontWeight.bold),
              bodyMedium: TextStyle(fontSize: 16.sp,color: Colors.grey.shade700),
              bodySmall: TextStyle(fontSize: 12.sp),
              titleLarge: TextStyle(
                fontSize: 24.sp,
                fontWeight: FontWeight.bold,
                color: Colors.black,
              ),
              titleMedium: TextStyle(fontSize: 16.sp),
              labelLarge: TextStyle(
                  fontSize: 16.sp,
                  fontWeight: FontWeight.bold,
                  color: Colors.red),
            ),
          ),
          debugShowCheckedModeBanner: false,
          title: "Notes",
        );
      },
    );
  }
}

class SetInitScreen{
  SetInitScreen(){
    initScreen = 1;
  }
}

