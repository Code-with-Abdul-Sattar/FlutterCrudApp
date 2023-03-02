import 'package:abc/UI/Post_Screen.dart';
import 'package:abc/Widget/button.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:firebase_database/ui/firebase_animated_list.dart';
import 'package:flutter/material.dart';
import 'package:velocity_x/velocity_x.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';
import 'package:abc/Auth_Screens/Login.dart';
import 'package:abc/Const.dart';
import 'package:abc/Auth_Screens/ShowPost.dart';

class Home extends StatefulWidget {
  const Home({Key? key}) : super(key: key);

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  FirebaseAuth _auth = FirebaseAuth.instance;
  final ref = FirebaseDatabase.instance.ref('Data');
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: SafeArea(
          child: Container(
            child: SingleChildScrollView(
              physics: BouncingScrollPhysics(),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Text(
                    "Welcome To Home",
                    style: TextStyle(fontSize: 30),
                  ),
                  20.heightBox,
                  postmessage.text.bold.size(24).makeCentered(),
                  20.heightBox,
                  FloatingActionButton(
                      child: Icon(
                        Icons.add,
                        color: Colors.white,
                        size: 40,
                      ),
                      onPressed: () {
                        Get.to(() => PostScreen());
                      }),
                  20.heightBox,
                  button(
                      title: "See Your Posts",
                      color: Colors.green,
                      textcolor: Colors.white,
                      onpress: () {
                        _auth.signOut().then((value) => {
                              Get.to(() => ShowPost()),
                            });
                      }),
                  20.heightBox,
                  Text("OR"),
                  20.heightBox,
                  button(
                      title: "Logout",
                      color: Colors.green,
                      textcolor: Colors.white,
                      onpress: () {
                        _auth.signOut().then((value) => {
                              Get.to(() => login()),
                            });
                      }),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
