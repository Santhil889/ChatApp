import 'package:chat/Views/search.dart';
import 'package:chat/Views/signin.dart';
import 'package:chat/Widgets/appbarWidget.dart';
import 'package:chat/helper/Authincate.dart';
import 'package:chat/helper/Constant.dart';
import 'package:chat/helper/helperfunction.dart';
import 'package:chat/services/Auth.dart';
import 'package:flutter/material.dart';

class ChatRoom extends StatefulWidget {
  @override
  _ChatRoomState createState() => _ChatRoomState();
}

class _ChatRoomState extends State<ChatRoom> {
  AuthMethod _auth= new AuthMethod();

  @override
  void initState() {
    getUserInfo();
    super.initState();
    printdetails();
  }

  printdetails(){
    print(Constants.myname);
    HelperFunctions.getuserNameSharedPreference().then((value){
      print(value);
    });
    HelperFunctions.getuserEmailSharedPreference().then((value){
      print(value);
    });
    HelperFunctions.getuserLoggedinSharedPreference().then((value){
      print(value);
    });
  }

  getUserInfo()async{
    Constants.myname= await HelperFunctions.getuserNameSharedPreference();
    setState(() {
      Constants.myname=Constants.myname;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Image.asset("assets/images/logo.png", height: 50,),
        actions: [
          GestureDetector(
            onTap: (){
              _auth.signOut();
              HelperFunctions.saveuserLoggedinSharedPreference(false);
              HelperFunctions.saveuserEmailSharedPreference("");
              HelperFunctions.saveuserNameSharedPreference("");
              Navigator.pushReplacement(context, MaterialPageRoute(builder: (context)=> Authincate()));
            },
            child: Container(
              padding: EdgeInsets.symmetric(horizontal: 16),
                child: Icon(Icons.exit_to_app,)
            ),
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.search),
        onPressed: (){

          Navigator.push(context, MaterialPageRoute(builder: (context)=> Search()));
        },
      ),
    );
  }
}
