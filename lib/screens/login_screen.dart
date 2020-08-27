import 'package:flutter/material.dart';
import 'package:learning_app/custom_internal.dart';

class LoginPage extends StatefulWidget {
  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  @override
  Widget build(BuildContext context) {

    final screenHeight = MediaQuery.of(context).size.height;
    final screenWidth = MediaQuery.of(context).size.width;

    return Scaffold(
      appBar: customBackAppbar(context),
      body: Column(
        children: <Widget>[
          Container(
            width: screenWidth,
            height: screenHeight*0.4,
            child: Stack(
              children: <Widget>[
                Positioned(
                  left: 10,
                  child: Text(
                    "Coding",
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 60,
                    ),
                  ),
                ),
                Positioned(
                  left: screenWidth*0.45,
                  top: screenHeight*0.13,
                  child: Text(
                    "is",
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 40,
                    ),
                  ),
                ),
                Positioned(
                  left: screenWidth*0.35,
                  top: screenHeight*0.23,
                  child: Text(
                    "Everything",
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 50,
                    ),
                  ),
                ),
              ],
            ),
          ),

        ],
      )
    );
  }
}
