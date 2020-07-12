import 'package:chat/Views/conversation.dart';
import 'package:chat/Widgets/appbarWidget.dart';
import 'package:chat/helper/Constant.dart';
import 'package:chat/helper/helperfunction.dart';
import 'package:chat/services/database.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class Search extends StatefulWidget {
  @override
  _SearchState createState() => _SearchState();
}

class _SearchState extends State<Search> {
  DatabaseMethods dbmethod=new DatabaseMethods();
  TextEditingController username=new TextEditingController();
  QuerySnapshot qsearch;
  initsearch(){
    if(username.text!=Constants.myname){
      dbmethod.getUserByUsername(username.text).then((val){
        setState(() {
          qsearch=val;
        });
      });
    }else{
      print("Naam dusra daal ke search kar");
    }

  }

  //create char room and send user to conversation screen push replacement
  createChatRoomsendConversation({String userName}){
    if(userName!=HelperFunctions.getuserNameSharedPreference()){
      List<String> users =[userName,Constants.myname];
      String chatroomID=getChatRoomID(userName, Constants.myname);
      Map<String,dynamic> chatroommap={
        "users": users,
        "chatroomId": chatroomID,
      };
      DatabaseMethods().createChatRoom(chatroomID, chatroommap);
      Navigator.push(context,
          MaterialPageRoute(builder: (context)=> ConversationScreen(
            chatRoomID: chatroomID,
          )));
    }

  }


  Widget SearchList(){
    return qsearch!=null ? ListView.builder(
        shrinkWrap: true,
        itemCount: qsearch.documents.length,
        itemBuilder: (context, index){
          return searchTile(
            username: qsearch.documents[index].data["name"],
            email: qsearch.documents[0].data["email"],
          );
        },
    ) : Container();
  }

  Widget searchTile({String username,String email}){
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 24,vertical: 16),
      child: Row(
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(username,style: mediumtextstyle(),),
              Text(email,style: mediumtextstyle(),)
            ],
          ),
          Spacer(),
          GestureDetector(
            onTap: (){
              createChatRoomsendConversation(userName: username);
            },
            child: Container(
              decoration: BoxDecoration(
                color: Colors.blue,
                borderRadius: BorderRadius.circular(30),
              ),
              padding: EdgeInsets.symmetric(vertical: 16,horizontal: 16),
              child: Text("Message",style: mediumtextstyle(),),
            ),
          )
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: mainAppBar(context),
      body: Container(
        child: Column(
          children: [
            Container(
              color: Color(0x54FFFFFF),
              padding: EdgeInsets.symmetric(horizontal: 24,vertical: 16),
              child: Row(
                children: [
                  Expanded(child: TextField(
                    controller: username,
                    style: TextStyle(
                      color: Colors.white,
                    ),
                    decoration: InputDecoration(
                      hintText: "Search username",
                      hintStyle: TextStyle(
                        color: Colors.white54,
                      ),
                      border: InputBorder.none,
                    ),
                  )),
                  GestureDetector(
                    onTap: (){
                      initsearch();
                    },
                    child: Container(
                        height: 40,
                        width: 40,
                        padding: EdgeInsets.all(12),
                        decoration: BoxDecoration(
                          gradient: LinearGradient(
                            colors: [
                              Color(0x36FFFFFF),
                              Color(0x0fffffff)
                            ]
                          ),
                          borderRadius: BorderRadius.circular(40)
                        ),

                        child: Image.asset('assets/images/search_white.png')
                    ),
                  )
                ],
              ),
            ),
            SearchList(),
          ],
        ),

      ),
    );
  }
}



getChatRoomID(String a,String b){
  int x=a.compareTo(b);
  if(x>0)
    return "$b\_$a";
  else
    return "$a\_$b";
}