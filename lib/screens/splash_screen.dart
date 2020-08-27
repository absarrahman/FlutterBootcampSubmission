import 'package:flutter/material.dart';
import 'package:learning_app/screens/main_page.dart';
import 'package:learning_app/custom_internal.dart';

class SplashScreen extends StatefulWidget {
  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {

  @override
  void initState() {
    super.initState();
    Future.delayed(
      Duration(
        seconds: 5,
      ),
          () {
        Navigator.pushAndRemoveUntil(
            context,
            MaterialPageRoute(
              builder: (context) => MainPage(),
            ), (e) => false
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    final screenHeight = MediaQuery.of(context).size.height;

    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            ClipRRect(
              borderRadius: BorderRadius.circular(30.0),
              child: Image(
                fit: BoxFit.fill,
                height: screenHeight * 0.3,
                width: screenHeight * 0.3,
                image: AssetImage("assets/images/splash_screen_image.jpg"),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(
                top: 8.0,
              ),
              child: Text(
                "Programmers learning",
                style: TextStyle(
                  fontSize: 35,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            Text(
              "hub",
              style: TextStyle(
                fontSize: 35,
                fontWeight: FontWeight.bold,
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(top: 30.0),
              child: Text(
                "An app where you can learn \nand practice your coding skills",
                style: TextStyle(
                  fontSize: 20,
                  //fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.add),
        onPressed: () => changeBrightness(context),
      ),
    );
  }

}
