import 'package:abc/Auth_Screens/Home.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:firebase_auth/firebase_auth.dart';
import '../Auth_Screens/Login.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  ChangeScreen() async {
    FirebaseAuth _auth = FirebaseAuth.instance;
    final user = _auth.currentUser;
    if (user != null) {
      Future.delayed(Duration(seconds: 5), () {
        Get.to(() => const Home());
        // auth.authStateChanges().listen((User? user) {
        //   if (user == null && mounted) {
        //     Get.to(() => const loginscreen());
        //   } else {
        //     Get.to(() => const Home());
        //   }
        // })
      });
    } else {
      Future.delayed(Duration(seconds: 5), () {
        Get.to(() => const login());
        // auth.authStateChanges().listen((User? user) {
        //   if (user == null && mounted) {
        //     Get.to(() => const loginscreen());
        //   } else {
        //     Get.to(() => const Home());
        //   }
        // });
      });
    }
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    ChangeScreen();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                "Welcome to Splash Screen",
                style: TextStyle(fontSize: 25),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
