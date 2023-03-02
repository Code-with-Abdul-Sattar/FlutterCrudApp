import 'package:abc/UI/Post_Screen.dart';
import 'package:abc/Widget/button.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:velocity_x/velocity_x.dart';
import 'package:get/get.dart';

class VerificationCode extends StatefulWidget {
  final String VerificationId;
  const VerificationCode({Key, required this.VerificationId, key})
      : super(key: key);

  @override
  State<VerificationCode> createState() => _VerificationCodeState();
}

class _VerificationCodeState extends State<VerificationCode> {
  final VerificationController = TextEditingController();
  FirebaseAuth _auth = FirebaseAuth.instance;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.green,
        title: Text("Verification"),
      ),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          children: [
            TextFormField(
              keyboardType: TextInputType.phone,
              controller: VerificationController,
              decoration: InputDecoration(
                hintText: "Enter Verification Code",
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
                  final credential = PhoneAuthProvider.credential(
                      verificationId: widget.VerificationId,
                      smsCode: VerificationController.text);

                  try {
                    _auth.signInWithCredential(credential);
                    Get.to(() => PostScreen());
                  } catch (e) {
                    VxToast.show(context, msg: "Error");
                  }
                }),
          ],
        ),
      ),
    );
  }
}
