import 'dart:io';

import 'package:flutter/material.dart';
import 'package:learning_app/custom_internal.dart';
import 'package:learning_app/screens/login_screen.dart';

class MainPage extends StatefulWidget {
  @override
  _MainPageState createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
  @override
  Widget build(BuildContext context) {

    final screenHeight = MediaQuery.of(context).size.height;
    debugPrint(screenHeight.toString());

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        leading: IconButton(
          color: Theme.of(context).brightness == Brightness.dark
              ? Colors.white
              : Colors.black,
          icon: Icon(Icons.exit_to_app),
          onPressed: () => exit(0),
        ),
      ),
      body: Container(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Image.asset("assets/images/main_page.png",
              height: screenHeight*0.4,
              width: screenHeight*0.4,
            ),
            SizedBox(
              height: screenHeight*0.01,
            ),
            Text(
              "Welcome",
              textAlign: TextAlign.start,
              style: TextStyle(
                fontSize: 40.0,
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(
              height: screenHeight*0.15,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Padding(
                  child: Container(
                    alignment: Alignment.centerLeft,
                    child: ButtonTheme(
                      minWidth: 130.0,
                      height: 50.0,
                      child: RaisedButton(
                        child: Text("Login",
                          style: TextStyle(
                            fontSize: 20.0,
                          ),
                          textAlign: TextAlign.center,
                        ),
                        onPressed: () => login(),
                      ),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(18.0),
                      ),
                    ),
                  ),
                  padding: EdgeInsets.only(
                    left: 50.0,
                  ),
                ),
                Spacer(
                  flex: 1,
                ),
                Padding(
                  child: Container(
                    alignment: Alignment.centerRight,
                    child: ButtonTheme(
                      minWidth: 130.0,
                      height: 50.0,
                      child: RaisedButton(
                        child: Text("Signup",
                          style: TextStyle(
                            fontSize: 20.0,
                          ),
                          textAlign: TextAlign.center,
                        ),
                        onPressed: () => {},
                      ),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(18.0),
                      ),
                    ),
                  ),
                  padding: EdgeInsets.only(
                    right: 50.0,
                  ),
                ),
              ],
            )
          ],
        ),
      ),
    );
  }

  login() {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => LoginPage(),
      ),
    );
  }

}
