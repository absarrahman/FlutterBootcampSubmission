import 'package:flutter/material.dart';
import 'package:learning_app/screens/internals/custom_internal.dart';
import 'package:learning_app/screens/internals/radial_progress.dart';

class AccountPage extends StatefulWidget {
  @override
  _AccountPageState createState() => _AccountPageState();
}

class _AccountPageState extends State<AccountPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: customBackAppbar(context),
      body: Column(
        children: [
        ],
      ),
    );
  }
}
