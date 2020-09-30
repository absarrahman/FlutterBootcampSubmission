import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:learning_app/models/user.dart';
import 'package:learning_app/screens/confirm_buy.dart';
import 'package:learning_app/screens/internals/custom_internal.dart';

class CourseDetailsPage extends StatefulWidget {
  final list;
  final index;

  const CourseDetailsPage({Key key, this.list, this.index}) : super(key: key);

  @override
  _CourseDetailsPageState createState() => _CourseDetailsPageState();
}

class _CourseDetailsPageState extends State<CourseDetailsPage> {
  var screenHeight, screenWidth, list, index, user;
  bool isEnrolled;


  @override
  void initState() {
    super.initState();
    _checkUser();
  }

  _checkUser() async {
    isEnrolled = false;
    user = await FirebaseAuth.instance.currentUser();
    final uid = user.uid;
    try {
      await Firestore.instance.document("Courses/${widget.list[index]["courseName"]}/enrolled_students/$uid").get().then((doc) {
        setState(() {
          if (doc.exists){
            isEnrolled = true;
          } else {
            isEnrolled = false;
          }
        });
      });
    } catch (e) {
      isEnrolled = false;
    }
  }

  @override
  Widget build(BuildContext context) {
    screenHeight = MediaQuery.of(context).size.height;
    screenWidth = MediaQuery.of(context).size.width;
    list = widget.list;
    index = widget.index;
    return Scaffold(
      appBar: customBackAppbar(context),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Center(
            child: Hero(
              tag: list[index]["courseName"],
              child: Image.network(
                list[index]["imageUrl"],
                height: screenHeight * 0.34,
                width: screenHeight * 0.34,
              ),
            ),
          ),
          Center(
            child: Text(
              "${list[index]["courseName"]}",
              style: TextStyle(
                fontSize: 30,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            child: Row(
              children: [
                _typeCard(
                  "Total lectures",
                  Icons.video_collection_sharp,
                  Color(0xffff1e56),
                  list[index]["lectures"],
                ),
                _typeCard(
                  "Instructor",
                  Icons.assignment_ind,
                  Colors.red,
                  list[index]["instructor"],
                ),
                _typeCard(
                  "Worksheets",
                  Icons.assignment,
                  Colors.blue,
                  list[index]["practice_sheet"],
                ),
              ],
            ),
          ),
          Expanded(
            child: Container(
              alignment: Alignment.center,
              child: ButtonTheme(
                minWidth: 130.0,
                height: 50.0,
                child: RaisedButton(
                  elevation: 10,
                  child: Text(
                    isEnrolled?"You are enrolled":"Buy now for ${list[index]["price"]}",
                    style: TextStyle(
                      fontSize: 20.0,
                    ),
                    textAlign: TextAlign.center,
                  ),
                  onPressed: ()=>_buyNow(),
                ),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(18.0),
                ),
                buttonColor: Colors.green,
              ),
            ),
          ),
        ],
      ),
    );
  }

  _buyNow() {
    if(!isEnrolled) {
      showDialog(
        context: context,
        builder: (context) =>
            AlertDialog(
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
                "Do you want to buy this course?",
              ),
              actions: <Widget>[
                FlatButton(
                  child: Text(
                    "Yes",
                  ),
                  onPressed: () => _confirmBuy(),
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
    } else {
      showDialog(
        context: context,
        builder: (context) =>
            AlertDialog(
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
                "Your course will start from 10/10/20",
              ),
              actions: <Widget>[
                FlatButton(
                  child: Text(
                    "Ok",
                  ),
                  onPressed: () => Navigator.pop(context),
                ),
              ],
            ),
      );
    }
  }

  _confirmBuy() async {
    final uid = user.uid;
    final DocumentSnapshot documentSnapshot =
    await Firestore.instance.collection("Users").document(uid).get();

    var details = documentSnapshot.data;
    var _name = details["name"];
    var _email = details["email"];
    var enrollCount = details["courses_enrolled"];
    var completed = details["courses_completed"];
    enrollCount++;

    Firestore.instance
        .collection("Courses/${widget.list[index]["courseName"]}/enrolled_students")
        .document(uid)
        .setData(User(user.uid, user.email, completed, enrollCount).toJson());

    Firestore.instance
        .collection('Users')
        .document(user.uid)
        .setData(User(_name, _email, completed, enrollCount).toJson());

    Navigator.pushReplacement(
      context,
      MaterialPageRoute(
        builder: (context) => ConfirmPayment(
          mFirebaseUser: user,
        ),
      ),
    );
  }

  Widget _typeCard(String s, IconData icon, Color color, dynamic data) {
    return Padding(
      padding: const EdgeInsets.all(20.0),
      child: Center(
        child: Container(
          height: screenHeight * 0.20,
          width: screenWidth * 0.5,
          child: Material(
            elevation: 7,
            color: color,
            borderOnForeground: true,
            borderRadius: BorderRadius.circular(20),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: <Widget>[
                Padding(
                  padding: const EdgeInsets.all(10.0),
                  child: Icon(
                    icon,
                    size: 25,
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
                      s,
                      style:
                          TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
                    ),
                  ),
                ),
                FittedBox(
                  fit: BoxFit.fill,
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Text(
                      "$data",
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 20,
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

}
