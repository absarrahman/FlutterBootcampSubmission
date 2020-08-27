import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:learning_app/screens/course_details.dart';
import 'package:learning_app/screens/internals/custom_internal.dart';

import 'auth/main_page.dart';

class CourseListPage extends StatefulWidget {
  @override
  _CourseListPageState createState() => _CourseListPageState();
}

class _CourseListPageState extends State<CourseListPage> {
  var screenHeight, screenWidth;
  Widget imageShow;


  _CourseListPageState() {
    imageShow = Image.asset(
      "assets/images/homeDetails.png",

    );
  }

  @override
  Widget build(BuildContext context) {
    screenHeight = MediaQuery.of(context).size.height;
    screenWidth = MediaQuery.of(context).size.width;

    return StreamBuilder<QuerySnapshot>(
      stream: Firestore.instance.collection("Courses").snapshots(),
      builder: (context, snapshot) {
        if (snapshot.hasError) {
          print("Error");
          return Text("Error");
        } else if (snapshot.connectionState == ConnectionState.waiting) {
          return loading();
        } else {
          final list = snapshot.data.documents.toList();
          return Scaffold(
            body: CustomScrollView(
              slivers: <Widget>[
                SliverAppBar(
                  backgroundColor: isDark?Color(0xff303030):Colors.white,
                  leading: IconButton(
                    color: isDark?Colors.white:Colors.black,
                    icon: Icon(Icons.arrow_back),
                    onPressed: () => Navigator.of(context).pop(),
                  ),
                  floating: false,
                  pinned: true,
                  expandedHeight: 160.0,
                  flexibleSpace: FlexibleSpaceBar(
                    centerTitle: true,
                    title: Text("Courses",
                      style: TextStyle(
                        color: isDark?Colors.white:Colors.black,
                        backgroundColor: isDark?Color(0xff303030):Colors.white
                      ),
                    ),
                    background: Hero(
                      tag: "menusPic",
                      child: imageShow,
                    ),
                  ),
                ),
                SliverList(
                  delegate: SliverChildBuilderDelegate(
                    (builder, index) => _courseCard(list, index),
                    childCount: list.length,
                  ),
                ),
              ],
            ),
            floatingActionButton: FloatingActionButton(
              onPressed: () => _logOut(),
              child: Text("*"),
            ),
          );
        }
      },
    );
  }

/*  @override
  Widget build(BuildContext context) {
    screenHeight = MediaQuery.of(context).size.height;
    screenWidth = MediaQuery.of(context).size.width;
    return Scaffold(
      body: StreamBuilder<QuerySnapshot>(
          stream: Firestore.instance.collection("Courses").snapshots(),
          builder: (context, snapshot) {
            if (snapshot.hasError) {
              print("Error");
              return Text("Error");
            } else if (snapshot.connectionState == ConnectionState.waiting) {
              return loading();
            } else {
              final list = snapshot.data.documents.toList();
              return CustomScrollView(
                slivers: <Widget>[
                  SliverAppBar(
                    backgroundColor: Color(0xff3c5a73),
                    leading: IconButton(
                      color: Colors.white,
                      icon: Icon(Icons.arrow_back),
                      onPressed: () => Navigator.of(context).pop(),
                    ),
                    floating: false,
                    pinned: true,
                    expandedHeight: 160.0,
                    flexibleSpace: FlexibleSpaceBar(
                      background: Image.asset(
                        "assets/images/home_page_background.png",
                        fit: BoxFit.cover,
                      ),
                      */ /*title: Text(
                        nameOfUser != null ? "Hey $nameOfUser ," : "",
                        style: TextStyle(
                          backgroundColor: Color(0xff3c5a73),
                          fontWeight: FontWeight.bold,
                        ),
                      ),*/ /*
                    ),
                  ),
                  SliverList(
                    delegate: SliverChildBuilderDelegate(
                          (builder, index) => _courseCard(list, index),
                      childCount: list.length,
                    ),
                  ),
                ],
              );
            }
          }),
      floatingActionButton: FloatingActionButton(
        onPressed: () => _logOut(),
        child: Text("*"),
      ),
    );
  }*/

  Widget _courseCard(List list, int index) {
    return Padding(
      padding: const EdgeInsets.only(top: 20.0),
      child: InkWell(
        onTap: () => _courseDetailsRoute(list, index),
        child: Center(
          child: Container(
            height: screenHeight * 0.20,
            width: screenWidth * 0.9,
            child: Material(
              elevation: 7,
              color: isDark ? Color(0xffffac41) : Color(0xffffc4d0),
              borderOnForeground: true,
              borderRadius: BorderRadius.circular(20),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: <Widget>[
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Hero(
                      tag: list[index]["courseName"],
                      child: Image.network(
                        list[index]["imageUrl"],
                        height: screenHeight * 0.14,
                        width: screenWidth * 0.25,
                      ),
                    ),
                  ),
                  SizedBox(
                    width: screenWidth * 0.14,
                  ),
                  Text(
                    list[index]["courseName"],
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  _courseDetailsRoute(List list, int index) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => CourseDetailsPage(
          list: list,
          index: index,
        ),
      ),
    );
  }

  _logOut() {
    FirebaseAuth.instance.signOut();
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(
        builder: (context) => MainPage(),
      ),
    );
  }
}
