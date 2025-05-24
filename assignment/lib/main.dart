import 'package:assignment/screens/login.dart';
import 'package:assignment/screens/project.dart';
import 'package:assignment/services/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:firebase_app_check/firebase_app_check.dart';


void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  await FirebaseAppCheck.instance.activate(
    webProvider: ReCaptchaV3Provider('recaptcha-v3-site-key'),
    androidProvider: AndroidProvider.debug,
    appleProvider: AppleProvider.appAttest,
  );
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);
 // final AuthService _authService = AuthService();

  @override
  Widget build(BuildContext context) {

    return const MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Flutter Firebase Email Authentication App',
        home: MyHomePage());
  }
}

class MyHomePage extends StatelessWidget {
  const MyHomePage({super.key});
  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
      stream: AuthService().authStateChanges,
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          return ProjectScreen();
        } else {
          return LoginScreen();
        }
      },
    );
  }
}
