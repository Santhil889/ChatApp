import 'package:chat/Widgets/appbarWidget.dart';
import 'package:chat/helper/Constant.dart';
import 'package:chat/services/database.dart';
import 'package:flutter/material.dart';

class ConversationScreen extends StatefulWidget {

  final String chatRoomID;

  const ConversationScreen({Key key, this.chatRoomID}) : super(key: key);
  @override
  _ConversationScreenState createState() => _ConversationScreenState();
}

class _ConversationScreenState extends State<ConversationScreen> {
  ScrollController controller= new ScrollController();
  Stream chatStream;
  TextEditingController message=new TextEditingController();
  DatabaseMethods dbmethod= new DatabaseMethods();
  Widget ChatMessageList(){
    return StreamBuilder(
      stream: chatStream,
      builder: (context,snapshot){
        return snapshot.hasData ? ListView.builder(
            controller: controller,
            itemCount: snapshot.data.documents.length,
            itemBuilder: (context,index){
              return MessageTile(message: snapshot.data.documents[index].data["message"],
              issentbyme: snapshot.data.documents[index].data["sentBy"]==Constants.myname,);
            }) : Container();
      },

    );
  }

  sendMessage(){
    if(message.text.isNotEmpty){
      Map<String,dynamic> msgmap={
        "message": message.text,
        "sentBy": Constants.myname,
        "time" : DateTime.now().millisecondsSinceEpoch,
      };
      dbmethod.addConverstionMessages(widget.chatRoomID, msgmap);
      controller.jumpTo(controller.position.maxScrollExtent);
      message.clear();
    }
  }

  @override
  void initState() {
    // TODO: implement initState
    dbmethod.getConverstionMessages(widget.chatRoomID).then((val){
      setState(() {
        chatStream=val;
      });
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          title: Text("${widget.chatRoomID.toString().replaceAll("_", "").replaceAll(Constants.myname, "")}")
      ),
      body: Container(
        child: Stack(
          children: [
            ChatMessageList(),
            Container(
              alignment: Alignment.bottomCenter,
              child: Container(
                color: Color(0x54FFFFFF),
                padding: EdgeInsets.symmetric(horizontal: 24,vertical: 16),
                child: Row(
                  children: [
                    Expanded(child: TextField(
                      controller: message,
                      style: TextStyle(
                        color: Colors.white,
                      ),
                      decoration: InputDecoration(
                        hintText: "message",
                        hintStyle: TextStyle(
                          color: Colors.white54,
                        ),
                        border: InputBorder.none,
                      ),
                    )),
                    GestureDetector(
                      onTap: (){
                        sendMessage();
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

                          child: Image.asset('assets/images/send.png')
                      ),
                    )
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class MessageTile extends StatelessWidget {
  final String message;
  final bool issentbyme; //true if i sent ;false if other guy sends
  const MessageTile({Key key, this.message,this.issentbyme}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(vertical: 8,horizontal: 14),
      width: MediaQuery.of(context).size.width,
      alignment: issentbyme? Alignment.centerRight: Alignment.centerLeft,
      child: Container(
        padding: EdgeInsets.symmetric(vertical: 16,horizontal: 24),
        decoration: BoxDecoration(
          gradient: LinearGradient(colors: issentbyme ?
            [Color(0xff007ef4),Color(0xff2a75bc)]:
            [Color(0x1affffff),Color(0x1affffff)]),
          borderRadius: issentbyme ? BorderRadius.only(topLeft: Radius.circular(40),topRight: Radius.circular(40),bottomLeft: Radius.circular(40))
            : BorderRadius.only(topLeft: Radius.circular(40),topRight: Radius.circular(40),bottomRight: Radius.circular(40)),
        ),
        child: Text(message,style: TextStyle(
            color: Colors.white,
            fontSize: 17,
          ),
        ),
      ),
    );
  }
}
