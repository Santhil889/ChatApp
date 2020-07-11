import 'package:chat/Views/chatRoom.dart';
import 'package:chat/Views/signin.dart';
import 'package:chat/Views/signup.dart';
import 'package:chat/helper/Authincate.dart';
import 'package:chat/helper/helperfunction.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {

  bool Userisloggedin=false;
  @override
  void initState() {
    // TODO: implement initState
    getloggedininfo();
    super.initState();
  }

  getloggedininfo() async{
    await HelperFunctions.getuserLoggedinSharedPreference().then((value){
      setState(() {
        if(value==null)
          Userisloggedin=false;
        else
          Userisloggedin=value;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primaryColor: Color(0xff145c9e),
        scaffoldBackgroundColor: Color(0xff1f1f1f),
        primarySwatch: Colors.blue,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      debugShowCheckedModeBanner: false,
      home: Userisloggedin ? ChatRoom() : Authincate(),
    );
  }
}