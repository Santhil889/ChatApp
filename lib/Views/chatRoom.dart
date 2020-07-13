import 'package:chat/Views/conversation.dart';
import 'package:chat/Views/search.dart';
import 'package:chat/Views/signin.dart';
import 'package:chat/Widgets/appbarWidget.dart';
import 'package:chat/helper/Authincate.dart';
import 'package:chat/helper/Constant.dart';
import 'package:chat/helper/helperfunction.dart';
import 'package:chat/services/Auth.dart';
import 'package:chat/services/database.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class ChatRoom extends StatefulWidget {
  @override
  _ChatRoomState createState() => _ChatRoomState();
}

class _ChatRoomState extends State<ChatRoom> {
  DatabaseMethods dbmethods= new DatabaseMethods();
  AuthMethod _auth= new AuthMethod();
  Stream chatRoomStream;

  Widget chatroomlist(){
    return StreamBuilder(
      stream: chatRoomStream,
      builder: (context,snapshot){
        return snapshot.hasData ? ListView.builder(
            itemCount: snapshot.data.documents.length,
            itemBuilder: (context,index){
              return ChatTile(username: snapshot.data.documents[index].data["chatroomId"]
                  .toString().replaceAll("_", "").replaceAll(Constants.myname, ""),
                chatRoomID: snapshot.data.documents[index].data["chatroomId"],
              );
            }
        ) : Container();
      },
    );
  }

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
    dbmethods.getChatRoom(Constants.myname).then((val){
      setState(() {
        chatRoomStream=val;
      });
    });
    setState(() {

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
      body: chatroomlist(),
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.search),
        onPressed: (){

          Navigator.push(context, MaterialPageRoute(builder: (context)=> Search()));
        },
      ),
    );
  }
}

class ChatTile extends StatelessWidget {
  final String username;
  final String chatRoomID;
  const ChatTile({Key key, this.username,this.chatRoomID}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: (){
        Navigator.push(context, MaterialPageRoute(builder: (context)=> ConversationScreen(chatRoomID: chatRoomID,)));
      },
      child: Container(
        decoration: BoxDecoration(
            color: Colors.white12,
          borderRadius: BorderRadius.circular(30)
        ),
        margin: EdgeInsets.only(bottom: 5,left: 5,right: 5,top: 1),

        padding: EdgeInsets.symmetric(horizontal: 24,vertical: 16),
        child: Row(
          children: [
            Container(
              height: 40,
              width: 40,
              decoration: BoxDecoration(
                color: Colors.blue,
                borderRadius: BorderRadius.circular(40)
              ),
                child: Center(child: Text("${username.substring(0, 1).toUpperCase()}",style: mediumtextstyle(),))
            ),
            SizedBox(width: 18,),
            Text(username,style: mediumtextstyle(),)
          ],
        ),
      ),
    );
  }
}
