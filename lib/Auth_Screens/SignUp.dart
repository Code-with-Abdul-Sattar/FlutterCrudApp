import 'package:abc/Auth_Screens/Home.dart';
import 'package:abc/Auth_Screens/Login.dart';
import 'package:flutter/material.dart';
import 'package:velocity_x/velocity_x.dart';
import 'package:get/get.dart';
import '../Widget/button.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:fluttertoast/fluttertoast.dart';

class SignUp extends StatefulWidget {
  const SignUp({Key? key}) : super(key: key);

  @override
  State<SignUp> createState() => _SignUpState();
}

class _SignUpState extends State<SignUp> {
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
        title: Text("Sign Up Page"),
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
              button(
                title: "Sign Up",
                color: Colors.green,
                textcolor: Colors.white,
                onpress: () {
                  if (formKey.currentState!.validate()) {
                    _auth
                        .createUserWithEmailAndPassword(
                            email: emailController.text,
                            password: passwordController.text)
                        .then((value) => {Get.to(() => Home())});
                  } else {
                    VxToast.show(context, msg: "Invalid Email OR Password");
                  }
                },
              ),
              20.heightBox,
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    "Already have an account ?",
                    style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
                  ),
                  5.widthBox,
                  TextButton(
                      onPressed: () {
                        Get.to(() => login());
                      },
                      child: Text(
                        "Login",
                        style: TextStyle(
                            color: Colors.lightGreen,
                            fontWeight: FontWeight.bold,
                            fontSize: 20),
                      ))
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
