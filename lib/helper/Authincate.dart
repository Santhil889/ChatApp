import 'package:chat/Views/signin.dart';
import 'package:chat/Views/signup.dart';
import 'package:flutter/material.dart';

class Authincate extends StatefulWidget {
  @override
  _AuthincateState createState() => _AuthincateState();
}

class _AuthincateState extends State<Authincate> {
  bool showSignin= true;
  void toggleview(){
    setState(() {
      showSignin=!showSignin;
    });
  }
  @override
  Widget build(BuildContext context) {
    if(showSignin)
      return SignIn(toggleview: toggleview);
    else
      return SignUp(toggleview: toggleview);
  }
}
