import 'package:abc/Widget/button.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:velocity_x/velocity_x.dart';
import 'package:abc/Const.dart';

class PostScreen extends StatefulWidget {
  const PostScreen({Key? key}) : super(key: key);

  @override
  State<PostScreen> createState() => _PostScreenState();
}

class _PostScreenState extends State<PostScreen> {
  // final database = FirebaseDatabase.instance.ref('Data').child('Mydata');
  final database = FirebaseDatabase.instance.ref('Data');
  final postControlller = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Post Page"),
        backgroundColor: Colors.green,
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 12.0),
        child: Column(
          children: [
            20.heightBox,
            TextFormField(
              maxLines: 5,
              controller: postControlller,
              decoration: InputDecoration(
                hintText: "What's On Your Mind",
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
                color: Colors.green,
                title: "Add Post",
                textcolor: Colors.white,
                onpress: () {
                  String id =
                      (DateTime.now().millisecondsSinceEpoch.toString());
                  // Map<String, String> data = {'title': postControlller.text};
                  database
                      .child(id)
                      .set({
                        'id': id,
                        'title': postControlller.text,
                      })
                      .then((value) => {
                            VxToast.show(context,
                                msg: "Post Added Successfully")
                          })
                      .onError((error, stackTrace) => {
                            VxToast.show(context,
                                msg: "Some Unknown Error Found")
                          });

                  // database.push().set(data);
                }).box.rounded.make(),
          ],
        ),
      ),
    );
  }
}
