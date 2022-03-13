import 'package:agam/screens/login.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class FormScreen extends StatefulWidget {
  @override
  _FormScreenState createState() => _FormScreenState();
}

class _FormScreenState extends State<FormScreen> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController nameController = new TextEditingController();
  final TextEditingController phoneController = new TextEditingController();
  final TextEditingController emailController = new TextEditingController();

  FirebaseAuth _auth = FirebaseAuth.instance;
  FirebaseFirestore _firestore = FirebaseFirestore.instance;

  void addContact() async {
    await _firestore
        .collection('users')
        .doc(_auth.currentUser!.uid)
        .collection('contactList')
        .add({
      'name': nameController.text,
      'phone': phoneController.text,
      'email': emailController.text,
    });
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final saveButton = Material(
      elevation: 5,
      borderRadius: BorderRadius.circular(30),
      color: Colors.blue,
      child: MaterialButton(
        padding: EdgeInsets.fromLTRB(20, 15, 20, 15),
        minWidth: MediaQuery.of(context).size.width * 0.5,
        onPressed: () {
          addContact();
          FocusScope.of(context).unfocus();
          nameController.clear();
          emailController.clear();
          phoneController.clear();
        },
        child: Text(
          "Save",
          textAlign: TextAlign.center,
          style: TextStyle(
            fontSize: 20,
            color: Colors.white,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
    );
    return Scaffold(
      appBar: AppBar(title: Text('Contact Details Page'), actions: [
        IconButton(
          onPressed: () {
            logOut(context);
          },
          icon: Icon(Icons.person),
        ),
      ]),
      backgroundColor: Colors.white,
      body: SingleChildScrollView(
        child: Container(
          color: Colors.white,
          child: Padding(
            padding: const EdgeInsets.all(20.0),
            child: Form(
              key: _formKey,
              child: Column(
                // mainAxisAlignment: MainAxisAlignment.center,
                // crossAxisAlignment: CrossAxisAlignment.center,
                children: <Widget>[
                  SizedBox(
                    height: 60,
                    child: Text(
                      "Contact Form And Contact Login Page",
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontSize: 20,
                        color: Colors.blue,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                  SizedBox(height: 20),
                  SizedBox(
                    height: 50,
                    child: Text(
                      "Add Contacts",
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontSize: 25,
                        color: Colors.blue,
                        fontWeight: FontWeight.w400,
                      ),
                    ),
                  ),
                  SizedBox(height: 10),
                  Row(
                    // mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      Expanded(
                        flex: 2,
                        child: Text(
                          "Name",
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            fontSize: 17,
                            color: Colors.black,
                            fontWeight: FontWeight.w400,
                          ),
                        ),
                      ),
                      Expanded(
                        flex: 5,
                        child: TextFormField(
                          autofocus: false,
                          controller: nameController,
                          keyboardType: TextInputType.name,
                          onSaved: (value) {},
                          textInputAction: TextInputAction.next,
                          decoration: InputDecoration(
                            contentPadding: EdgeInsets.fromLTRB(20, 15, 20, 15),
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(10),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: 20),
                  Row(
                    // mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      Expanded(
                        flex: 2,
                        child: Text(
                          "Phone Number",
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            fontSize: 17,
                            color: Colors.black,
                            fontWeight: FontWeight.w400,
                          ),
                        ),
                      ),
                      Expanded(
                        flex: 5,
                        child: TextFormField(
                          autofocus: false,
                          controller: phoneController,
                          keyboardType: TextInputType.number,
                          onSaved: (value) {},
                          textInputAction: TextInputAction.next,
                          decoration: InputDecoration(
                            contentPadding: EdgeInsets.fromLTRB(20, 15, 20, 15),
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(10),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: 20),
                  Row(
                    // mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      Expanded(
                        flex: 2,
                        child: Text(
                          "Email",
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            fontSize: 17,
                            color: Colors.black,
                            fontWeight: FontWeight.w400,
                          ),
                        ),
                      ),
                      Expanded(
                        flex: 5,
                        child: TextFormField(
                          autofocus: false,
                          controller: emailController,
                          keyboardType: TextInputType.emailAddress,
                          onSaved: (value) {},
                          textInputAction: TextInputAction.next,
                          decoration: InputDecoration(
                            contentPadding: EdgeInsets.fromLTRB(20, 15, 20, 15),
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(10),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: 10),
                  saveButton,
                  SizedBox(height: 30),

                  SizedBox(
                    height: 60,
                    child: Text(
                      "Contact Details",
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontSize: 20,
                        color: Colors.blue,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                  SizedBox(height: 10),
                  Row(
                    // mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      Expanded(
                        flex: 2,
                        child: Text(
                          "Name",
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            fontSize: 20,
                            color: Colors.black,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                      Expanded(
                        flex: 3,
                        child: Text(
                          "Phone number",
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            fontSize: 20,
                            color: Colors.black,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                      Expanded(
                        flex: 3,
                        child: Text(
                          "Email",
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            fontSize: 20,
                            color: Colors.black,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ],
                  ),

                  SizedBox(height: 10),
                  SingleChildScrollView(
                    child: Row(
                      // mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        Expanded(
                          flex: 2,
                          child: StreamBuilder(
                              stream: _firestore
                                  .collection('users')
                                  .doc(_auth.currentUser!.uid)
                                  .collection('contactList')
                                  .snapshots(),
                              builder: (
                                BuildContext context,
                                AsyncSnapshot<QuerySnapshot> snapshot,
                              ) {
                                if (snapshot.hasError) {
                                  return Text('something is wrong');
                                }
                                if (snapshot.connectionState ==
                                    ConnectionState.waiting) {
                                  return CircularProgressIndicator();
                                }

                                final data = snapshot.requireData;

                                return ListView.builder(
                                    scrollDirection: Axis.vertical,
                                    shrinkWrap: true,
                                    itemCount: data.size,
                                    itemBuilder: ((context, index) {
                                      return ListTile(
                                        title: Text(data.docs[index]['name']),
                                      );
                                    }));
                              }),
                        ),
                        Expanded(
                          flex: 3,
                          child: StreamBuilder(
                              stream: _firestore
                                  .collection('users')
                                  .doc(_auth.currentUser!.uid)
                                  .collection('contactList')
                                  .snapshots(),
                              builder: (
                                BuildContext context,
                                AsyncSnapshot<QuerySnapshot> snapshot,
                              ) {
                                if (snapshot.hasError) {
                                  return Text('something is wrong');
                                }
                                if (snapshot.connectionState ==
                                    ConnectionState.waiting) {
                                  return CircularProgressIndicator();
                                }

                                final data = snapshot.requireData;

                                return ListView.builder(
                                    scrollDirection: Axis.vertical,
                                    shrinkWrap: true,
                                    itemCount: data.size,
                                    itemBuilder: ((context, index) {
                                      return ListTile(
                                        title: Text(data.docs[index]['phone']),
                                      );
                                    }));
                              }),
                        ),
                        Expanded(
                          flex: 3,
                          child: StreamBuilder(
                              stream: _firestore
                                  .collection('users')
                                  .doc(_auth.currentUser!.uid)
                                  .collection('contactList')
                                  .snapshots(),
                              builder: (
                                BuildContext context,
                                AsyncSnapshot<QuerySnapshot> snapshot,
                              ) {
                                if (snapshot.hasError) {
                                  return Text('something is wrong');
                                }
                                if (snapshot.connectionState ==
                                    ConnectionState.waiting) {
                                  return CircularProgressIndicator();
                                }

                                final data = snapshot.requireData;

                                return ListView.builder(
                                    scrollDirection: Axis.vertical,
                                    shrinkWrap: true,
                                    itemCount: data.size,
                                    itemBuilder: ((context, index) {
                                      return ListTile(
                                        title: Text(data.docs[index]['email']),
                                      );
                                    }));
                              }),
                        ),
                      ],
                    ),
                  ),

                  // SizedBox(height: 10),
                  // Row(
                  //   // mainAxisAlignment: MainAxisAlignment.center,
                  //   children: <Widget>[
                  //     Expanded(
                  //       flex: 2,
                  //       child: StreamBuilder(
                  //           stream: _firestore
                  //               .collection('users')
                  //               .doc(_auth.currentUser!.uid)
                  //               .collection('contactList')
                  //               .snapshots(),
                  //           builder: (
                  //             BuildContext context,
                  //             AsyncSnapshot<QuerySnapshot> snapshot,
                  //           ) {
                  //             if (snapshot.hasError) {
                  //               return Text('something is wrong');
                  //             }
                  //             if (snapshot.connectionState ==
                  //                 ConnectionState.waiting) {
                  //               return CircularProgressIndicator();
                  //             }

                  //             final data = snapshot.requireData;

                  //             return Expanded(
                  //               child: ListView.builder(
                  //                   scrollDirection: Axis.vertical,
                  //                   shrinkWrap: true,
                  //                   itemCount: data.size,
                  //                   itemBuilder: ((context, index) {
                  //                     return ListTile(
                  //                       title: Text(data.docs[index]['name']),
                  //                     );
                  //                   })),
                  //             );
                  //           }),
                  //     ),
                  //     Expanded(
                  //       flex: 3,
                  //       child: StreamBuilder(
                  //           stream: _firestore
                  //               .collection('users')
                  //               .doc(_auth.currentUser!.uid)
                  //               .collection('contactList')
                  //               .snapshots(),
                  //           builder: (
                  //             BuildContext context,
                  //             AsyncSnapshot<QuerySnapshot> snapshot,
                  //           ) {
                  //             if (snapshot.hasError) {
                  //               return Text('something is wrong');
                  //             }
                  //             if (snapshot.connectionState ==
                  //                 ConnectionState.waiting) {
                  //               return CircularProgressIndicator();
                  //             }

                  //             final data = snapshot.requireData;

                  //             return Expanded(
                  //               child: ListView.builder(
                  //                   scrollDirection: Axis.vertical,
                  //                   shrinkWrap: true,
                  //                   itemCount: data.size,
                  //                   itemBuilder: ((context, index) {
                  //                     return ListTile(
                  //                       title: Text(data.docs[index]['phone']),
                  //                     );
                  //                   })),
                  //             );
                  //           }),
                  //     ),
                  //     Expanded(
                  //       flex: 3,
                  //       child: StreamBuilder(
                  //           stream: _firestore
                  //               .collection('users')
                  //               .doc(_auth.currentUser!.uid)
                  //               .collection('contactList')
                  //               .snapshots(),
                  //           builder: (
                  //             BuildContext context,
                  //             AsyncSnapshot<QuerySnapshot> snapshot,
                  //           ) {
                  //             if (snapshot.hasError) {
                  //               return Text('something is wrong');
                  //             }
                  //             if (snapshot.connectionState ==
                  //                 ConnectionState.waiting) {
                  //               return CircularProgressIndicator();
                  //             }

                  //             final data = snapshot.requireData;

                  //             return Expanded(
                  //               child: ListView.builder(
                  //                   scrollDirection: Axis.vertical,
                  //                   shrinkWrap: true,
                  //                   itemCount: data.size,
                  //                   itemBuilder: ((context, index) {
                  //                     return ListTile(
                  //                       title: Text(data.docs[index]['email']),
                  //                     );
                  //                   })),
                  //             );
                  //           }),
                  //     ),
                  //   ],
                  // ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  Future logOut(BuildContext context) async {
    FirebaseAuth _auth = FirebaseAuth.instance;

    try {
      await _auth.signOut().then((value) {
        Navigator.pushAndRemoveUntil(
            context,
            MaterialPageRoute(builder: (context) => LoginScreen()),
            (route) => false);
      });
    } catch (e) {
      print("error");
    }
  }
}
