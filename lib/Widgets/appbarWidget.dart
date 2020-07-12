import 'package:flutter/material.dart';

Widget mainAppBar(BuildContext context){
  return AppBar(
    title: Image.asset("assets/images/logo.png", height: 50,),
  );
}

InputDecoration textfieldinputdecor(String hint){
  return InputDecoration(
      hintText: '$hint',
      hintStyle: TextStyle(
        color: Colors.white54,
      ),
      focusedBorder: UnderlineInputBorder(
        borderSide: BorderSide(color: Colors.white),
      ),
      enabledBorder: UnderlineInputBorder(
        borderSide: BorderSide(color: Colors.white),
      ),
    );
}

TextStyle simpletextstyle(){
  return TextStyle(color: Colors.white,
    fontSize: 16,
  );
}

TextStyle mediumtextstyle(){
  return TextStyle(
    color: Colors.white,
    fontSize: 17,
  );
}
//TIMEPASS
BoxDecoration sentbymeDecoration(){
  return BoxDecoration(
    borderRadius: BorderRadius.only(topLeft: Radius.circular(40),topRight: Radius.circular(40),bottomLeft: Radius.circular(40)),
    color: Colors.blue,
  );
}

BoxDecoration sentbyotherDecoration(){
  return BoxDecoration(
    borderRadius: BorderRadius.only(topLeft: Radius.circular(40),topRight: Radius.circular(40),bottomRight: Radius.circular(40)),
    color: Colors.black26,
  );
}