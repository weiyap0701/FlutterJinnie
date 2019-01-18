import 'package:flutter/material.dart';

class Helper {

  static showErrorDialog(BuildContext cont) {
    showDialog(
      context: cont,
      builder: (BuildContext context) {
        return AlertDialog(
          title: new Text("Error"),
          content: new Text("Oops, unexpected error occured."),
          actions: <Widget>[
            new FlatButton(
              child: new Text("Close"),
              onPressed: (){
                Navigator.of(context).pop();
              },
            )
          ],
        );
      }
    );
  }

  static String validateEmail(String value) {
    Pattern pattern =
        r'^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$';
    RegExp regex = new RegExp(pattern);
    if (!regex.hasMatch(value))
      return "Please enter a valid email";
    else
      return null;
  }

  static String validatePassword(String value) {
    if (value.length < 8) {
      return "A password must be at least 8 characters";
    }
    else {
      return null;
    }
  }
}
