import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:learning_app/models/user.dart';

import '../internals/custom_internal.dart';
import 'main_page.dart';

class SignUp extends StatefulWidget {
  @override
  _SignUpState createState() => _SignUpState();
}

class _SignUpState extends State<SignUp> {
  //TODO: Firebase setup required
  String _name, _email, _password, _confirmPassword;

  final TextEditingController _pass = TextEditingController();
  final TextEditingController _confirmPass = TextEditingController();

  static const String _nameTag = "NAME";
  static const String _emailTag = "EMAIL";
  static const String _passwordTag = "PASSWORD";
  static const String _confirmPasswordTag = "CONFIRM_PASSWORD";
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: customBackAppbar(context),
      body: SingleChildScrollView(
        child: Container(
          child: Form(
            key: _formKey,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Container(
                  child: Center(
                    child: Text(
                      "Sign Up",
                      style: TextStyle(
                        fontSize: 40.0,
                      ),
                    ),
                  ),
                ),
                SizedBox(
                  height: 50.0,
                ),
                Container(
                  child: Center(
                    child: Text(
                      "Fill the details and create your",
                      style: TextStyle(
                        fontSize: 20.0,
                      ),
                    ),
                  ),
                ),
                Container(
                  child: Center(
                    child: Text(
                      "account",
                      style: TextStyle(
                        fontSize: 20.0,
                      ),
                    ),
                  ),
                ),
                SizedBox(
                  height: 50.0,
                ),
                fields("Name", Icons.person, _nameTag),
                SizedBox(
                  height: 10.0,
                ),
                fields("Email Address", Icons.email, _emailTag),
                SizedBox(
                  height: 10.0,
                ),
                fieldsPass("Password", Icons.vpn_key, _passwordTag),
                SizedBox(
                  height: 10.0,
                ),
                fieldsPass(
                    "Confirm Password", Icons.vpn_key, _confirmPasswordTag),
                SizedBox(
                  height: 30.0,
                ),
                Container(
                  alignment: Alignment.center,
                  child: ButtonTheme(
                    minWidth: 130.0,
                    height: 50.0,
                    child: RaisedButton(
                      child: Text(
                        "Sign up",
                        style: TextStyle(
                          fontSize: 20.0,
                        ),
                        textAlign: TextAlign.center,
                      ),
                      onPressed: () => signUpAccount(),
                    ),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(18.0),
                    ),
                    buttonColor: Color(0xffffaa3c),
                  ),
                ),
                Container(
                  padding: EdgeInsets.only(
                    bottom: 40.0,
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }

  signUpAccount() async {
    if (_formKey.currentState.validate()) {
      _formKey.currentState.save();
      try {
        FirebaseUser user = ((await FirebaseAuth.instance
                .createUserWithEmailAndPassword(
                    email: _email, password: _password))
            .user);
        user.sendEmailVerification();
        Firestore.instance
            .collection('Users')
            .document(user.uid)
            .setData(User(_name, _email).toJson())
            .catchError((e) {
          debugPrint(e.toString());
        });
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(
            builder: (context) => MainPage(),
          ),
        );
      } catch (e) {
        print(e.message);
      }
    }
  }

  String checker(String value, String type) {
    if (type == _emailTag) {
      return validateEmail(value);
    } else if ((type == _passwordTag) || ((type == _confirmPasswordTag))) {
      return validatePassword(value);
    } else {
      return validateOtherFields(value);
    }
  }

  onSavedType(String value, String type) {
    switch (type) {
      case _nameTag:
        _name = value;
        break;
      case _emailTag:
        _email = value;
        break;
      case _passwordTag:
        _password = value;
        break;
      case _confirmPasswordTag:
        _confirmPassword = value;
        break;
    }
  }

  Widget fieldsPass(String hintTextVal, IconData icon, String type) {
    return new Container(
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Icon(
            icon,
          ),
          SizedBox(
            width: 20,
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
              controller: type == _confirmPasswordTag ? _confirmPass : _pass,
              validator: (String value) {
                if ((checker(value, type)) == null) {
                  if ((value != _pass.text) && (type == _confirmPasswordTag)) {
                    return "Confirm password did not match";
                  }
                }
                return checker(value, type);
              },
              onSaved: (String value) {
                onSavedType(value, type);
              },
              obscureText: true,
              textAlign: TextAlign.center,
              decoration: InputDecoration(
                border: InputBorder.none,
                hintText: hintTextVal,
                hintStyle: TextStyle(color: Colors.grey),
              ),
            ),
            width: 250,
          )
        ],
      ),
    );
  }

  Widget fields(String hintTextVal, IconData icon, String type) {
    return new Container(
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Icon(
            icon,
          ),
          SizedBox(
            width: 20,
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
              validator: (String value) {
                return checker(value, type);
              },
              onSaved: (String value) {
                onSavedType(value, type);
              },
              obscureText:
                  ((type == _passwordTag) || (type == _confirmPasswordTag))
                      ? true
                      : false,
              textAlign: TextAlign.center,
              decoration: InputDecoration(
                border: InputBorder.none,
                hintText: hintTextVal,
                hintStyle: TextStyle(color: Colors.grey),
              ),
            ),
            width: 250,
          )
        ],
      ),
    );
  }
}
