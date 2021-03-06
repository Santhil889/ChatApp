import 'package:chat/Views/chatRoom.dart';
import 'package:chat/Widgets/appbarWidget.dart';
import 'package:chat/helper/helperfunction.dart';
import 'package:chat/services/Auth.dart';
import 'package:chat/services/database.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
class SignIn extends StatefulWidget {
  final Function toggleview;

  const SignIn({Key key, this.toggleview}) : super(key: key);
  @override
  _SignInState createState() => _SignInState();
}

class _SignInState extends State<SignIn> {

  AuthMethod authmethod= new AuthMethod();
  DatabaseMethods dbmethods=new DatabaseMethods();

  bool _autovalidate=false, _isloading=false;
  final formkey=GlobalKey<FormState>();
  TextEditingController newuseremail= new TextEditingController();
  TextEditingController newuserpassword= new TextEditingController();
  QuerySnapshot qshot;

  signIn() async{
    if(formkey.currentState.validate()){

      dbmethods.getUserByUseremail(newuseremail.text).then((val){
        qshot=val;
        HelperFunctions.saveuserNameSharedPreference(qshot.documents[0].data["name"]);
      });

      HelperFunctions.saveuserEmailSharedPreference(newuseremail.text);

      setState(() {
        _isloading=true;
      });

      await authmethod.signinWithEmailAndPassword(newuseremail.text, newuserpassword.text)
          .then((value){
            if(value!=null){

              HelperFunctions.saveuserLoggedinSharedPreference(true);
              Navigator.pushReplacement(context, MaterialPageRoute(
                  builder: (context) => ChatRoom()
              ));
            }
          });
    }else{
      setState(() {
        _autovalidate= true;
      });
    }
  }

  String validateEmail(String value) {
    Pattern pattern =
        r'^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$';
    RegExp regex = new RegExp(pattern);
    if (!regex.hasMatch(value))
      return 'Enter Valid Email';
    else
      return null;
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: mainAppBar(context),
      body: SingleChildScrollView(
        child: Container(
          height: MediaQuery.of(context).size.height -50 ,
          alignment: Alignment.bottomCenter,
          child: Container(
            padding: EdgeInsets.symmetric(horizontal: 24),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Form(
                  key: formkey,
                  autovalidate: _autovalidate,
                  child: Column(
                    children: [
                      TextFormField(
                        validator: validateEmail,
                        controller: newuseremail,
                        style: simpletextstyle(),
                        decoration: textfieldinputdecor("email"),
                      ),
                      TextFormField(
                        validator: (value){
                          return value.length>6 ? null : "Password has to be at least 6 char long";
                        },
                        controller: newuserpassword,
                        obscureText: true,
                        style: simpletextstyle(),
                        decoration: textfieldinputdecor("password"),
                      ),
                    ],
                  ),
                ),
                SizedBox(height: 8,),
                Container(
                  alignment: Alignment.centerRight,
                  child: Container(
                    padding: EdgeInsets.symmetric(horizontal: 16,vertical: 8),
                    child: Text("Forgot Password?",style: simpletextstyle(),),
                  ),
                ),
                SizedBox(height: 8,),
                GestureDetector(
                  onTap: (){
                    signIn();
                  },
                  child: Container(
                    alignment: Alignment.center,
                    width: MediaQuery.of(context).size.width,
                    padding: EdgeInsets.symmetric(vertical: 20),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(30),
                      gradient: LinearGradient(
                          colors: [
                            const Color(0xff007EF4),
                            const Color(0xff2A75BC)
                          ]
                      )
                    ),
                    child: Text("Sign In",style: mediumtextstyle()),
                  ),
                ),
                SizedBox(height: 16,),
                Container(
                  alignment: Alignment.center,
                  width: MediaQuery.of(context).size.width,
                  padding: EdgeInsets.symmetric(vertical: 20),
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(30),
                      color: Colors.white,
                  ),
                  child: Text("Sign In with Google",style: TextStyle(
                    color: Colors.black87,
                    fontSize: 17,
                  ),),
                ),
                SizedBox(height: 16,),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text("Don't have an account? ",style: mediumtextstyle(),),
                    GestureDetector(
                      onTap: (){
                        widget.toggleview();
                      },
                      child: Container(
                        padding: EdgeInsets.symmetric(vertical: 8),
                        child: Text("Register Now",style: TextStyle(
                          color: Colors.white,
                          decoration: TextDecoration.underline,
                          fontSize: 17
                        ),),
                      ),
                    ),
                  ],
                ),
                SizedBox(height: 50,),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
