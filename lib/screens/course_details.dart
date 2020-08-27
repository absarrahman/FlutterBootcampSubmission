import 'package:flutter/material.dart';
import 'package:learning_app/screens/internals/custom_internal.dart';

class CourseDetailsPage extends StatefulWidget {

  final list;
  final index;

  const CourseDetailsPage({
    Key key,
    this.list,
    this.index
  }) : super(key: key);

  @override
  _CourseDetailsPageState createState() => _CourseDetailsPageState();
}


class _CourseDetailsPageState extends State<CourseDetailsPage> {

  var screenHeight;
  var screenWidth;

  @override
  Widget build(BuildContext context) {
    screenHeight = MediaQuery.of(context).size.height;
    screenWidth = MediaQuery.of(context).size.width;
    return Scaffold(
      appBar: customBackAppbar(context),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Center(
            child: Hero(
              tag: widget.list[widget.index]["courseName"],
              child: Image.network(widget.list[widget.index]["imageUrl"],
                height: screenHeight * 0.34,
                width: screenHeight * 0.34,
              ),
            ),
          ),
          Text("$screenWidth $screenHeight"),
        ],
      ),
    );
  }
}
