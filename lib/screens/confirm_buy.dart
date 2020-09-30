import 'package:flutter/material.dart';
import 'package:learning_app/screens/home.dart';
import 'package:learning_app/screens/internals/custom_internal.dart';
import 'package:lottie/lottie.dart';

class ConfirmPayment extends StatelessWidget {
  final mFirebaseUser;

  ConfirmPayment({this.mFirebaseUser});

  @override
  Widget build(BuildContext context) {
    final animation = Lottie.network(
        "https://assets7.lottiefiles.com/packages/lf20_oUXj84.json");
    return animation == null
        ? loading()
        : Scaffold(
            body: Column(
              children: [
                Expanded(child: animation),
                Expanded(
                  child: Text(
                    "Congratulations for getting enrolled",
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 25
                    ),
                    textAlign: TextAlign.center,
                  ),
                ),
                Expanded(
                  child: Container(
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
                        onPressed: () => Navigator.pushReplacement(
                          context,
                          MaterialPageRoute(
                            builder: (context) => HomePage(
                              mFirebaseUser: mFirebaseUser,
                            ),
                          ),
                        ),
                      ),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(18.0),
                      ),
                      buttonColor:
                          isDark ? Color(0xffffaa3c) : Color(0xffffc4d0),
                    ),
                  ),
                )
              ],
            ),
          );
  }
}
