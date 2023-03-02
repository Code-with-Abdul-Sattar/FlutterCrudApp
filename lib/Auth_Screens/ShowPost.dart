import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:firebase_database/ui/firebase_animated_list.dart';
import 'package:flutter/material.dart';
import 'package:velocity_x/velocity_x.dart';
import 'package:abc/UI/Splash.dart';
import 'package:velocity_x/velocity_x.dart';

class ShowPost extends StatefulWidget {
  const ShowPost({Key? key}) : super(key: key);

  @override
  State<ShowPost> createState() => _ShowPostState();
}

class _ShowPostState extends State<ShowPost> {
  final SearchFilter = TextEditingController();
  final ref = FirebaseDatabase.instance.ref('Data');
  final UpdateFilter = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Posts You Made"),
        backgroundColor: Colors.green,
      ),
      body: Center(
        child: Container(
          margin: EdgeInsets.symmetric(vertical: 15),
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              children: [
                // Expanded(
                //     child: StreamBuilder(
                //   stream: ref.onValue,
                //   builder: (context, AsyncSnapshot<DatabaseEvent> snapshot) {
                //     Map<dynamic, dynamic> map =
                //         snapshot.data!.snapshot.value as dynamic;
                //     List<dynamic> list = [];
                //     list.clear();
                //     list = map.values.toList();
                //
                //     if (!snapshot.hasData) {
                //       return CircularProgressIndicator();
                //     } else {
                //       return ListView.builder(
                //           itemCount: snapshot.data!.snapshot.children.length,
                //           itemBuilder: (context, index) {
                //             return ListTile(
                //               title: Text(list[index]['title']),
                //               subtitle: Text(list[index]['id']),
                //             );
                //           });
                //     }
                //   },
                // )),

                Padding(
                  padding: const EdgeInsets.all(10.0),
                  child: TextFormField(
                    controller: SearchFilter,
                    decoration: InputDecoration(
                        hintText: "Search",
                        border: InputBorder.none,
                        fillColor: Color.fromRGBO(226, 227, 227, 1.0),
                        filled: true,
                        focusedBorder: OutlineInputBorder(
                          borderSide: BorderSide(color: Colors.lightGreen),
                        )),
                    onChanged: (String value) {
                      setState(() {});
                    },
                  ).box.roundedSM.shadowSm.make(),
                ),
                20.heightBox,

                Expanded(
                  child: FirebaseAnimatedList(
                    defaultChild: Text("Loading"),
                    query: ref,
                    itemBuilder: (context, snapshot, animation, index) {
                      final title = snapshot.child('title').value.toString();

                      // function to update Data with alert dialog with two options cancel and delete
                      Future<void> ShowMyDialog(String title, String id) async {
                        UpdateFilter.text = title;
                        return showDialog(
                            context: context,
                            builder: (BuildContext context) {
                              return AlertDialog(
                                title: Text(
                                  "Update",
                                  style: TextStyle(fontWeight: FontWeight.bold),
                                ),
                                content: Container(
                                  child: TextFormField(
                                    controller: UpdateFilter,
                                    decoration: InputDecoration(
                                      hintText: "Edit Data",
                                      border: InputBorder.none,
                                      fillColor:
                                          Color.fromRGBO(226, 227, 227, 1.0),
                                      filled: true,
                                      focusedBorder: OutlineInputBorder(
                                        borderSide: BorderSide(
                                            color: Colors.lightGreen),
                                      ),
                                    ),
                                  ),
                                ),
                                actions: [
                                  TextButton(
                                      onPressed: () {
                                        Navigator.pop(context);
                                      },
                                      child: Text(
                                        "Cancel",
                                        style: TextStyle(
                                            fontWeight: FontWeight.bold,
                                            fontSize: 20),
                                      )),
                                  TextButton(
                                      onPressed: () {
                                        ref
                                            .child(snapshot
                                                .child('id')
                                                .value
                                                .toString())
                                            .update({
                                              'title':
                                                  UpdateFilter.text.toString(),
                                              id: snapshot
                                                  .child('id')
                                                  .value
                                                  .toString(),
                                            })
                                            .then((value) => {
                                                  VxToast.show(context,
                                                      msg:
                                                          "Data Successfully Updated")
                                                })
                                            .onError((error, stackTrace) => {
                                                  VxToast.show(context,
                                                      msg:
                                                          "Error In Updating Data")
                                                });
                                        Navigator.pop(context);
                                      },
                                      child: Text(
                                        "Update",
                                        style: TextStyle(
                                            fontWeight: FontWeight.bold,
                                            fontSize: 20),
                                      )),
                                ],
                              );
                            });
                      }
                      // End of function

                      //If the search text Is Empty if Statement will run
                      if (SearchFilter.text.isEmpty) {
                        return ListTile(
                          title: Text(
                            snapshot.child('title').value.toString(),
                            style: TextStyle(fontSize: 18, color: Colors.black),
                          ),
                          subtitle: Text(
                            snapshot.child('id').value.toString(),
                            style: TextStyle(fontSize: 15, color: Colors.black),
                          ),

                          //pop up Menu

                          trailing: PopupMenuButton(
                            icon: Icon(Icons.more_vert_rounded),
                            itemBuilder: (context) => [
                              // To Edit Data
                              PopupMenuItem(
                                value: 1,
                                child: ListTile(
                                  onTap: () {
                                    Navigator.pop(context);
                                    ShowMyDialog(title,
                                        snapshot.child('id').value.toString());
                                  },
                                  leading: Icon(Icons.edit),
                                  title: Text("Edit Data"),
                                ),
                              ),
                              // To Delete Data
                              PopupMenuItem(
                                value: 2,
                                child: ListTile(
                                  onTap: () {
                                    Navigator.pop(context);
                                    ref
                                        .child(snapshot
                                            .child('id')
                                            .value
                                            .toString())
                                        .remove();
                                  },
                                  leading: Icon(Icons.delete),
                                  title: Text("Delete Data"),
                                ),
                              ),
                            ],
                          ),
                        );

                        // /If the search text Is not Empty this Statement will run

                      } else if (title.toLowerCase().contains(
                          SearchFilter.text.toLowerCase().toString())) {
                        return ListTile(
                          title: Text(
                            snapshot.child('title').value.toString(),
                            style: TextStyle(fontSize: 18, color: Colors.black),
                          ),
                          subtitle: Text(
                            snapshot.child('id').value.toString(),
                            style: TextStyle(fontSize: 15, color: Colors.black),
                          ),
                          trailing: PopupMenuButton(
                            icon: Icon(Icons.more_vert_rounded),
                            itemBuilder: (context) => [
                              // To Edit Data
                              PopupMenuItem(
                                value: 1,
                                child: ListTile(
                                  onTap: () {
                                    Navigator.pop(context);
                                    ShowMyDialog(title,
                                        snapshot.child('id').value.toString());
                                  },
                                  leading: Icon(Icons.edit),
                                  title: Text("Edit Data"),
                                ),
                              ),
                              // To Delete Data
                              PopupMenuItem(
                                value: 2,
                                child: ListTile(
                                  onTap: () {
                                    Navigator.pop(context);
                                    ref
                                        .child(snapshot
                                            .child('id')
                                            .value
                                            .toString())
                                        .remove();
                                  },
                                  leading: Icon(Icons.delete),
                                  title: Text("Delete Data"),
                                ),
                              ),
                            ],
                          ),
                        );

                        // any Data if Deleted or any error occured this show Empty cOntainer

                      } else {
                        return Container();
                      }
                    },
                  ),
                ),
                20.heightBox,
              ],
            ),
          ),
        ),
      ),
    );
  }
}
