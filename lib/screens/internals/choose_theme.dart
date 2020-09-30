import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:learning_app/screens/internals/custom_internal.dart';

import '../home.dart';

class ChooseTheme extends StatefulWidget {


  final FirebaseUser mFirebaseUser;

  const ChooseTheme({
    Key key,
    this.mFirebaseUser,
  }) : super(key: key);


  @override
  _ChooseThemeState createState() => _ChooseThemeState();
}

class _ChooseThemeState extends State<ChooseTheme> {
  @override
  Widget build(BuildContext context) {

    final screenHeight = MediaQuery.of(context).size.height;


    return Scaffold(
      appBar: customBackAppbar(context),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            children: <Widget>[
              Text("Select your theme",
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 30,
                ),
              ),
              SizedBox(
                height: screenHeight*0.06,
              ),
              isDark?darkThemeEnabled():lightThemeEnabled(),
              SizedBox(
                height: screenHeight*0.1,
              ),
              Switch(
                value: isDark,
                onChanged: (changedValue) {
                  setState(() {
                    if(isDark) {
                      isDark = false;
                    } else {
                      isDark = true;
                    }
                    changeBrightness(context);
                  });
                },
              ),
              SizedBox(
                height: screenHeight*0.08,
              ),
              Container(
                alignment: Alignment.center,
                child: ButtonTheme(
                  minWidth: 130.0,
                  height: 50.0,
                  child: RaisedButton(
                    child: Text(
                      "Next",
                      style: TextStyle(
                        fontSize: 20.0,
                      ),
                      textAlign: TextAlign.center,
                    ),
                    onPressed: () => _homePage(),
                  ),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(18.0),
                  ),
                  buttonColor: isDark?Color(0xffffaa3c):Color(0xffffc4d0),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget darkThemeEnabled() {
    return Container(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Text("Demon",
            style: TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 50,
            ),
          ),
          Text("Dark",
            style: TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 50,
            ),
          )
        ],
      ),
    );
  }

  Widget lightThemeEnabled() {
    return Container(
      child: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text("Minimal",
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 50,
              ),
            ),
            Text("White",
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 50,
              ),
            )
          ],
        ),
      ),
    );
  }

  _homePage() {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => HomePage(
          mFirebaseUser: widget.mFirebaseUser,
        ),
      ),
    );
  }

}

class ChooseThemeFromAccount extends StatefulWidget {

  @override
  _ChooseThemeFromAccountState createState() => _ChooseThemeFromAccountState();
}

class _ChooseThemeFromAccountState extends State<ChooseThemeFromAccount> {
  @override
  Widget build(BuildContext context) {

    final screenHeight = MediaQuery.of(context).size.height;

    return Scaffold(
      appBar: customBackAppbar(context),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            children: <Widget>[
              Text("Select your theme",
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 30,
                ),
              ),
              SizedBox(
                height: screenHeight*0.06,
              ),
              isDark?darkThemeEnabled():lightThemeEnabled(),
              SizedBox(
                height: screenHeight*0.1,
              ),
              Switch(
                value: isDark,
                onChanged: (changedValue) {
                  setState(() {
                    if(isDark) {
                      isDark = false;
                    } else {
                      isDark = true;
                    }
                    changeBrightness(context);
                  });
                },
              ),
              SizedBox(
                height: screenHeight*0.08,
              ),
              Container(
                alignment: Alignment.center,
                child: ButtonTheme(
                  minWidth: 130.0,
                  height: 50.0,
                  child: RaisedButton(
                    child: Text(
                      "Done",
                      style: TextStyle(
                        fontSize: 20.0,
                      ),
                      textAlign: TextAlign.center,
                    ),
                    onPressed: () => Navigator.pop(context),
                  ),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(18.0),
                  ),
                  buttonColor: isDark?Color(0xffffaa3c):Color(0xffffc4d0),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget darkThemeEnabled() {
    return Container(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Text("Demon",
            style: TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 50,
            ),
          ),
          Text("Dark",
            style: TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 50,
            ),
          )
        ],
      ),
    );
  }

  Widget lightThemeEnabled() {
    return Container(
      child: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text("Minimal",
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 50,
              ),
            ),
            Text("White",
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 50,
              ),
            )
          ],
        ),
      ),
    );
  }

}
