import 'package:flutter/material.dart';

class MainScreen extends StatelessWidget {
  String secretMessage;                                // CHANGE TO OPEN SECRET MESSAGE, GET TOKEN AND DO IT

  MainScreen(this.secretMessage);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Confidential"),
      ),
      body: Text(secretMessage),
    );
  }
}