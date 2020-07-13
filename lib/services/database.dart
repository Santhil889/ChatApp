import 'package:cloud_firestore/cloud_firestore.dart';

class DatabaseMethods{
  getUserByUsername(String username) async{
    return await Firestore.instance.collection("users")
        .where("name",isEqualTo: username)
        .getDocuments();
  }
  getUserByUseremail(String useremail) async{
    return await Firestore.instance.collection("users")
        .where("email",isEqualTo: useremail)
        .getDocuments();
  }
  uploadUserData(Usermap){
    Firestore.instance.collection("users")
        .add(Usermap);
  }
  createChatRoom(String chatroomid,chatroommap){
    Firestore.instance.collection("ChatRoom")
        .document(chatroomid).setData(chatroommap).catchError((e){
          print(e.message);
    });
  }

  addConverstionMessages(String chatRoomId,messageMap){
    Firestore.instance.collection("ChatRoom")
        .document(chatRoomId).collection("chats")
        .add(messageMap).catchError((e){
          print(e.message);
    });
  }
  getConverstionMessages(String chatRoomId) async{
    return await Firestore.instance.collection("ChatRoom")
        .document(chatRoomId).collection("chats").orderBy("time",descending: false)
        .snapshots();
  }
  getChatRoom(String username)async{
    return await Firestore.instance.collection("ChatRoom").where("users",arrayContains: username).snapshots();
  }
}