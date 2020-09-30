import 'dart:math';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:learning_app/screens/internals/choose_theme.dart';
import 'package:learning_app/screens/internals/custom_internal.dart';
import 'package:learning_app/screens/internals/radial_progress.dart';

import 'auth/main_page.dart';

class AccountPage extends StatefulWidget {
  final accountDetails;

  AccountPage({this.accountDetails});

  @override
  _AccountPageState createState() => _AccountPageState();
}

class _AccountPageState extends State<AccountPage> {
  var screenHeight, screenWidth;
  var accountDetails;

  @override
  Widget build(BuildContext context) {
    accountDetails = widget.accountDetails;
    final completedCourses = accountDetails["courses_completed"];
    final totalEnrolled = accountDetails["courses_enrolled"];
    screenHeight = MediaQuery.of(context).size.height;
    screenWidth = MediaQuery.of(context).size.width;
    return Scaffold(
      appBar: customBackAppbar(context),
      body: Column(
        children: [
          Center(
            child: completedCourses==0?Text("You have not completed any course",style: TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 20
            ),):RadialProgress(
              completedCourse: completedCourses,
              goalCompletedRatio: (completedCourses / totalEnrolled),
            ),
          ),
          Expanded(
            child: Padding(
              padding: const EdgeInsets.only(top: 20.0),
              child: Text(
                "${accountDetails["name"]}",
                style: TextStyle(
                  fontSize: 30,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ),
          Row(
            children: [
              Expanded(child: _emailCard()),
              Expanded(child: _totalEnrolledCard()),
            ],
          ),
          Row(
            children: [
              Expanded(child: _changeThemeCard()),
              Expanded(child: _logOutCard()),
            ],
          )
        ],
      ),
    );
  }

  Widget _emailCard() {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Center(
        child: Container(
          height: screenHeight * 0.20,
          width: screenWidth * 0.5,
          child: Material(
            elevation: 7,
            color: colorDef,
            borderOnForeground: true,
            borderRadius: BorderRadius.circular(20),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: <Widget>[
                Padding(
                  padding: const EdgeInsets.all(10.0),
                  child: Icon(Icons.email),
                ),
                SizedBox(
                  height: screenHeight * 0.01,
                ),
                FittedBox(
                  fit: BoxFit.fill,
                  child: Text(
                    "Your email",
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 16,
                    ),
                  ),
                ),
                SizedBox(
                  height: screenHeight * 0.01,
                ),
                FittedBox(
                  fit: BoxFit.fill,
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Text(
                      "${accountDetails["email"]}",
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _totalEnrolledCard() {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Center(
        child: Container(
          height: screenHeight * 0.20,
          width: screenWidth * 0.5,
          child: Material(
            elevation: 7,
            color: colorDef,
            borderOnForeground: true,
            borderRadius: BorderRadius.circular(20),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: <Widget>[
                Padding(
                  padding: const EdgeInsets.all(10.0),
                  child: Icon(Icons.book_sharp),
                ),
                SizedBox(
                  height: screenHeight * 0.01,
                ),
                FittedBox(
                  fit: BoxFit.fill,
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Text(
                      "Total enrolled courses",
                      style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
                    ),
                  ),
                ),
                FittedBox(
                  fit: BoxFit.fill,
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Text(
                      "${accountDetails["courses_enrolled"]}",
                      style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _changeThemeCard() {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Center(
        child: Container(
          height: screenHeight * 0.20,
          width: screenWidth * 0.5,
          child: InkWell(
            onTap: _changeTheme,
            child: Material(
              elevation: 7,
              color: colorDef,
              borderOnForeground: true,
              borderRadius: BorderRadius.circular(20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: <Widget>[
                  Padding(
                    padding: const EdgeInsets.all(10.0),
                    child: Icon(Icons.format_paint_sharp,size: 30,),
                  ),
                  SizedBox(
                    height: screenHeight * 0.01,
                  ),
                  FittedBox(
                    fit: BoxFit.fill,
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Text(
                        "Change theme",
                        style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
                      ),
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

  Widget _logOutCard() {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Center(
        child: Container(
          height: screenHeight * 0.20,
          width: screenWidth * 0.5,
          child: InkWell(
            onTap: _exitDialogue,
            child: Material(
              elevation: 7,
              color: colorDef,
              borderOnForeground: true,
              borderRadius: BorderRadius.circular(20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: <Widget>[
                  Padding(
                    padding: const EdgeInsets.all(10.0),
                    child: Transform(
                      alignment: Alignment.center,
                      transform: Matrix4.rotationY(pi),
                      child: Icon(
                        Icons.exit_to_app,
                        size: 30,
                      ),
                    ),
                  ),
                  SizedBox(
                    height: screenHeight * 0.01,
                  ),
                  FittedBox(
                    fit: BoxFit.fill,
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Text(
                        "Logout",
                        style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
                      ),
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

  _changeTheme() {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => ChooseThemeFromAccount(),
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
          "Do you want to logout?",
        ),
        actions: <Widget>[
          FlatButton(
            child: Text(
              "Yes",
            ),
            onPressed: _logOut,
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
