import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:learning_app/screens/account_details.dart';
import 'package:learning_app/screens/course_list_page.dart';
import 'package:learning_app/screens/internals/custom_internal.dart';

class HomePage extends StatefulWidget {
  final FirebaseUser mFirebaseUser;

  const HomePage({
    Key key,
    this.mFirebaseUser,
  }) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  var screenHeight, screenWidth;
  String nameOfUser;
  Widget imageShow;

  _HomePageState() {
    imageShow = Image.asset(
      "assets/images/homeDetails.png",
      width: 350,
      height: 350,
    );
    nameView().then((value) => setState(() {
          nameOfUser = value;
        }));
  }

  @override
  Widget build(BuildContext context) {
    screenHeight = MediaQuery.of(context).size.height;
    screenWidth = MediaQuery.of(context).size.width;

    return ((nameOfUser == null) || (imageShow == null))
        ? loading()
        : WillPopScope(
            onWillPop: _onWillPop,
            child: Scaffold(
              appBar: AppBar(
                backgroundColor: Colors.transparent,
                elevation: 0,
                leading: IconButton(
                  color: isDark ? Colors.white : Colors.black,
                  icon: Icon(Icons.arrow_back),
                  onPressed: () => _exitDialogue(),
                ),
              ),
              body: Center(
                child: Column(
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(left: 20, bottom: 20),
                      child: Align(
                        alignment: Alignment.centerLeft,
                        child: Text(
                          "Hey $nameOfUser ,",
                          style: TextStyle(
                              fontWeight: FontWeight.bold, fontSize: 20),
                        ),
                      ),
                    ),
                    Expanded(
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Container(
                          child: Hero(
                            tag: "menusPic",
                            child: imageShow,
                          ),
                        ),
                      ),
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    InkWell(
                      onTap: () => routeToCourse(),
                      child: Center(
                        child: Container(
                          height: screenHeight * 0.15,
                          width: screenWidth * 0.9,
                          child: Material(
                            elevation: 7,
                            color:
                                isDark ? Color(0xffffac41) : Color(0xffffc4d0),
                            borderOnForeground: true,
                            borderRadius: BorderRadius.circular(20),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.start,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: <Widget>[
                                Padding(
                                  padding: const EdgeInsets.all(10.0),
                                  child: Icon(
                                    Icons.book_rounded,
                                    size: 30,
                                  ),
                                ),
                                Padding(
                                  padding: const EdgeInsets.all(10.0),
                                  child: Text(
                                    "Check our available courses",
                                    style: TextStyle(
                                        fontWeight: FontWeight.bold,
                                        fontSize: 20),
                                  ),
                                )
                              ],
                            ),
                          ),
                        ),
                      ),
                    ),
                    Expanded(
                      child: InkWell(
                        onTap: () => _yourAccount(),
                        child: Center(
                          child: Container(
                            height: screenHeight * 0.15,
                            width: screenWidth * 0.9,
                            child: Material(
                              elevation: 7,
                              color: isDark
                                  ? Color(0xffffac41)
                                  : Color(0xffffc4d0),
                              borderOnForeground: true,
                              borderRadius: BorderRadius.circular(20),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.start,
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: <Widget>[
                                  Padding(
                                    padding: const EdgeInsets.all(10.0),
                                    child: Icon(
                                      Icons.person,
                                      size: 30,
                                    ),
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.all(10.0),
                                    child: Text(
                                      "Your Account",
                                      style: TextStyle(
                                          fontWeight: FontWeight.bold,
                                          fontSize: 20),
                                    ),
                                  )
                                ],
                              ),
                            ),
                          ),
                        ),
                      ),
                    )
                  ],
                ),
              ),
            ),
          );
  }

  _yourAccount() {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => AccountPage(),
      ),
    );
  }

  _exitDialogue() {
    return showDialog(
      context: context,
      builder: (context) => AlertDialog(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.all(
            Radius.circular(20),
          ),
        ),
        title: Text(
          "Programmers Learning Hub",
          textAlign: TextAlign.center,
        ),
        content: Text(
          "Giving up already?",
        ),
        actions: <Widget>[
          FlatButton(
            child: Text(
              "Yes",
            ),
            onPressed: () => exit(0),
          ),
          FlatButton(
            child: Text(
              "No",
            ),
            onPressed: () => Navigator.pop(context),
          ),
        ],
      ),
    );
  }

  void routeToCourse() {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => CourseListPage(),
      ),
    );
  }

  Future<bool> _onWillPop() async {
    return (await _exitDialogue()) ?? false;
  }

  Future<String> nameView() async {
    FirebaseUser user = await FirebaseAuth.instance.currentUser();
    final uid = user.uid;
    final DocumentSnapshot documentSnapshot =
        await Firestore.instance.collection("Users").document(uid).get();
    final list = documentSnapshot.data;
    return list["name"];
  }
}
