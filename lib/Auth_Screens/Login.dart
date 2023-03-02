import 'package:abc/Auth_Screens/Home.dart';
import 'package:abc/Auth_Screens/login_with_phone_number.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:velocity_x/velocity_x.dart';

import '../Widget/button.dart';
import 'package:get/get.dart';

import 'SignUp.dart';

class login extends StatefulWidget {
  const login({Key? key}) : super(key: key);

  @override
  State<login> createState() => _loginState();
}

class _loginState extends State<login> {
  bool isloading = false;
  final formKey = GlobalKey<FormState>();
  final emailController = TextEditingController();
  final passwordController = TextEditingController();

  FirebaseAuth _auth = FirebaseAuth.instance;

  void dispose() {
    emailController.dispose();
    passwordController.dispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Login Page"),
        backgroundColor: Colors.green,
      ),
      body: Container(
        margin: EdgeInsets.all(16),
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Form(
                  key: formKey,
                  child: Column(
                    children: [
                      TextFormField(
                        keyboardType: TextInputType.emailAddress,
                        controller: emailController,
                        decoration: InputDecoration(
                          hintText: "Enter Email",
                          prefixIcon: Icon(
                            Icons.email,
                            color: Colors.black,
                          ),
                          hintStyle:
                              TextStyle(color: Colors.black, fontSize: 22),
                          border: InputBorder.none,
                          fillColor: Color.fromRGBO(226, 227, 227, 1.0),
                          filled: true,
                          focusedBorder: OutlineInputBorder(
                            borderSide: BorderSide(color: Colors.lightGreen),
                          ),
                        ),
                        validator: (value) {
                          if (value!.isEmpty) {
                            return "Enter Email";
                          }
                        },
                      ),
                      20.heightBox,
                      TextFormField(
                        keyboardType: TextInputType.text,
                        obscureText: true,
                        controller: passwordController,
                        decoration: InputDecoration(
                          hintText: "Enter password",
                          prefixIcon: Icon(
                            Icons.lock,
                            color: Colors.black,
                          ),
                          hintStyle:
                              TextStyle(color: Colors.black, fontSize: 22),
                          border: InputBorder.none,
                          fillColor: Color.fromRGBO(226, 227, 227, 1.0),
                          filled: true,
                          focusedBorder: OutlineInputBorder(
                            borderSide: BorderSide(color: Colors.lightGreen),
                          ),
                        ),
                        validator: (value) {
                          if (value!.isEmpty) {
                            return "Enter Password";
                          }
                        },
                      ),
                    ],
                  )),
              20.heightBox,
              isloading
                  ? CircularProgressIndicator()
                  : button(
                      isloading: isloading,
                      title: "Login",
                      color: Colors.green,
                      textcolor: Colors.white,
                      onpress: () {
                        isloading = true;
                        if (formKey.currentState!.validate()) {
                          _auth
                              .signInWithEmailAndPassword(
                                  email: emailController.text,
                                  password: passwordController.text)
                              .then((value) =>
                                  {isloading = false, Get.to(() => Home())});
                        } else {
                          isloading = false;
                          VxToast.show(context,
                              msg: "Invalid Email OR Password");
                        }
                      }),
              20.heightBox,
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    "Don't have an account ?",
                    style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
                  ),
                  5.widthBox,
                  TextButton(
                      onPressed: () {
                        Get.to(() => SignUp());
                      },
                      child: Text(
                        "Sign Up",
                        style: TextStyle(
                            color: Colors.lightGreen,
                            fontWeight: FontWeight.bold,
                            fontSize: 20),
                      ))
                ],
              ),
              20.heightBox,
              InkWell(
                onTap: () {
                  Get.to(() => PhoneNumber());
                },
                child: Container(
                  height: 50,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(50),
                    border: Border.all(color: Colors.green),
                  ),
                  child: Center(
                    child: Text(
                      "Login With Phone Number",
                      style: TextStyle(color: Colors.black, fontSize: 20),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
