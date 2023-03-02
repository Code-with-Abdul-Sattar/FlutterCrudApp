import 'package:abc/Auth_Screens/VerificationCode.dart';
import 'package:abc/Widget/button.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:velocity_x/velocity_x.dart';
import 'package:get/get.dart';

class PhoneNumber extends StatefulWidget {
  const PhoneNumber({Key? key}) : super(key: key);

  @override
  State<PhoneNumber> createState() => _PhoneNumberState();
}

class _PhoneNumberState extends State<PhoneNumber> {
  final PhoneController = TextEditingController();
  FirebaseAuth _auth = FirebaseAuth.instance;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.green,
        title: Text("LogIn With Phone Number"),
      ),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          children: [
            TextFormField(
              keyboardType: TextInputType.phone,
              controller: PhoneController,
              decoration: InputDecoration(
                hintText: "Enter Phone Number",
                border: InputBorder.none,
                fillColor: Color.fromRGBO(226, 227, 227, 1.0),
                filled: true,
                focusedBorder: OutlineInputBorder(
                  borderSide: BorderSide(color: Colors.lightGreen),
                ),
              ),
            ).box.roundedSM.shadowSm.make(),
            30.heightBox,
            button(
                title: "Login",
                color: Colors.green,
                textcolor: Colors.white,
                onpress: () {
                  _auth.verifyPhoneNumber(
                      phoneNumber: PhoneController.text,
                      verificationCompleted: (_) {
                        VxToast.show(context, msg: "Verification Completed");
                      },
                      verificationFailed: (e) {
                        VxToast.show(context, msg: "Verification Failed");
                      },
                      codeSent: (String VerificationId, int? token) {
                        Get.to(() => VerificationCode(
                              VerificationId: VerificationId,
                            ));
                      },
                      codeAutoRetrievalTimeout: (e) {
                        VxToast.show(context, msg: "Verification Failed");
                      });
                }),
          ],
        ),
      ),
    );
  }
}
