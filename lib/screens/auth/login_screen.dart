import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:learning_app/screens/internals/choose_theme.dart';
import 'package:learning_app/screens/internals/custom_internal.dart';

import '../home.dart';

class LoginPage extends StatefulWidget {
  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  String _email, _password;
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    final screenHeight = MediaQuery.of(context).size.height;
    final screenWidth = MediaQuery.of(context).size.width;

    return Scaffold(
      appBar: customBackAppbar(context),
      body: Form(
        key: _formKey,
        child: SingleChildScrollView(
          child: Column(
            children: <Widget>[
              Container(
                width: screenWidth,
                height: screenHeight * 0.4,
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
                      left: screenWidth * 0.5,
                      top: screenHeight * 0.13,
                      child: Text(
                        "is",
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 40,
                        ),
                      ),
                    ),
                    Positioned(
                      right: 10,
                      top: screenHeight * 0.23,
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
              SizedBox(
                height: 20,
              ),
              Container(
                decoration: BoxDecoration(
                  border: Border(
                    bottom: BorderSide(
                      color: Colors.grey,
                    ),
                  ),
                ),
                child: TextFormField(
                  validator: validateEmail,
                  onSaved: (String value) => _email = value,
                  textAlign: TextAlign.center,
                  decoration: InputDecoration(
                    icon: Icon(Icons.email),
                    border: InputBorder.none,
                    hintText: "Email address",
                    hintStyle: TextStyle(color: Colors.grey),
                  ),
                ),
                width: 250,
              ),
              Container(
                decoration: BoxDecoration(
                  border: Border(
                    bottom: BorderSide(
                      color: Colors.grey,
                    ),
                  ),
                ),
                child: TextFormField(
                  obscureText: true,
                  validator: validatePassword,
                  onSaved: (String value) => _password = value,
                  textAlign: TextAlign.center,
                  decoration: InputDecoration(
                    icon: Icon(Icons.vpn_key),
                    border: InputBorder.none,
                    hintText: "Password",
                    hintStyle: TextStyle(color: Colors.grey),
                  ),
                ),
                width: 250,
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
                      "Log in",
                      style: TextStyle(
                        fontSize: 20.0,
                      ),
                      textAlign: TextAlign.center,
                    ),
                    onPressed: () => signIn(),
                  ),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(18.0),
                  ),
                  buttonColor: Color(0xffffaa3c),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Future<void> signIn() async {
    if (_formKey.currentState.validate()) {
      _formKey.currentState.save();

      try {
        FirebaseUser user = ((await FirebaseAuth.instance
            .signInWithEmailAndPassword(
            email: _email.trim(), password: _password))
            .user);
        print(user);
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(
            builder: (context) => ChooseTheme(
              mFirebaseUser: user,
            ),
          ),
        );
      } catch (e) {
        print(e.message);
      }
    }
  }

}
