import 'dart:async';
import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_pop/Models/models.dart';
import 'package:flutter_pop/Screens/HomePage.dart';
import 'package:http/http.dart' as _http;
//import 'package:localstorage/localstorage.dart' as LocalStorage;
import 'package:localstorage/localstorage.dart';
class MessageWindow extends StatefulWidget {
  int relateduserid;
  MessageWindow(int relateduserid){
    this.relateduserid = relateduserid;
  }
  @override
  _MessageWindow createState() => new _MessageWindow(this.relateduserid);
}

class _MessageWindow extends State<MessageWindow> {
  LocalStorage storage;
  //final LocalStorage storage = new LocalStorage('pop');
  //Future<List<userNotification>> _notificationList;
  var CURRENT_USER;
  var RELATED_USER_ID;
  var MESSAGE_LIST = [];
  _MessageWindow(int relateduserid){
    this.RELATED_USER_ID = relateduserid;
  }

  TextEditingController _controllerUserTypedMesssage =TextEditingController();
  StreamController _controllerChatStream =StreamController();
  Stream _streamChat;
  var timer;
  @override
  void initState() {

    storage = new LocalStorage('pop');
    // TODO: implement initState
    //getExptList();
    //exptListRenderer.add(Expt('4','abc','false'));
    super.initState();
    //exptListRenderer = getExptList();
    //debugPrint(exptListRenderer.toString());
    _controllerChatStream = StreamController();
    _streamChat = _controllerChatStream.stream;
    timer = new Timer.periodic(const Duration(milliseconds: 5000), (Timer t)=>getMessageLatest());
  }
  /*invokeMessages(){
    getMessageList();
     var timer = new Timer.periodic(const Duration(milliseconds: 1000), (Timer t)=>getMessageList());
  }*/
  @override
  Widget build(BuildContext context) {
    return new Scaffold(
        appBar: new AppBar(
          title: new Text('Chats'),
          backgroundColor: Colors.white,
          automaticallyImplyLeading: false,
          elevation: 0,
          /*actions: [
            new IconButton(
                icon: new Icon(Icons.arrow_forward,
                    //color:Colors.Theme.of(context).primaryColor
                    color: Colors.pinkAccent),
                onPressed: () {
                  Navigator.push(context,
                      MaterialPageRoute(builder: (context) => HomePage()));
                }
            )
          ],*/
          leading: new IconButton(
              icon: new Icon(Icons.arrow_back,
                  //color:Colors.Theme.of(context).primaryColor
                  color: Colors.pinkAccent
              ),
              onPressed: () {
                timer.cancel();
                Navigator.pop(context);

              }
          ),
        ),
        body: new Container(
          margin: EdgeInsets.all(10.0),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(10.0),
          ),
          //child: Text('loading'),
          child: getStreamBuilder(),
          //getFutureBuilderListView()
        ),
        bottomSheet:new Row(
          children:<Widget>[
            Expanded(
              child : TextFormField(
                controller:_controllerUserTypedMesssage
              )
            ),
            IconButton(
              icon:Icon(
                  Icons.keyboard_arrow_right
              ),
              onPressed:(){
                this._sendMessage();
              }
            )
          ]
        )
    );
  }

  getFutureBuilderListView(){
    return FutureBuilder(
      future: getMessageList(),
      builder: (BuildContext context, AsyncSnapshot snapshot) {
        if (snapshot.data == null) {
          return Container(
              child:Text('No Conversations between you two were found.')
          );
        } else {
          return ListView.builder(
            itemCount:snapshot.data.length,
            itemBuilder:(BuildContext context, int index){
              var data = snapshot.data[index];
              /*if(data.type=='SWIPE'){
                return getSwipeTemplate(data);
              }else{ //(snapshot.data[index].type == 'MESSAGE'){
                return getMessageTemplate(data);
              }*/
              return ListTile(
                title : Text(
                  data.message.toString() + data.time_stamp.toString() + data._time.toString()
                )
              );
              //return getMessageTemplate(data);
              //else{}
            }
          );
        }
      }
    );
  }
  Widget getStreamBuilder(){
    return StreamBuilder(
      stream:_streamChat,
      builder:(BuildContext context, AsyncSnapshot snapshot){
        if(snapshot.data == null){
          return Text('No Chats');
        }
        return ListView.builder(
          itemCount:this.MESSAGE_LIST.length,
          itemBuilder:(BuildContext context, int index) {
            var isMe = CURRENT_USER==MESSAGE_LIST[index].fromUserId || CURRENT_USER==MESSAGE_LIST[index].fromUserId.toString();
            return ListBody(
              children: <Widget>[
                Container(
                  padding:EdgeInsets.all(4.0),
                  alignment: isMe?Alignment.centerRight:Alignment.centerLeft,
                  child: Column(
                    children: <Widget>[
                      Text(
                        MESSAGE_LIST[index].message,
                        textAlign: isMe?TextAlign.right:TextAlign.left,
                        style: TextStyle(
                          fontSize: 14.0
                        ),
                      ),
                      SizedBox(
                        height:3.0
                      ),
                      Text(MESSAGE_LIST[index].senttime,
                        textAlign: isMe?TextAlign.right:TextAlign.left,
                        style: TextStyle(
                            fontSize: 8.0
                        ),
                      )
                    ],
                  ),
                  decoration: BoxDecoration(
                    color: isMe
                      ?Colors.yellowAccent[100]
                      :Colors.pinkAccent[100],
                    borderRadius:isMe
                      ?BorderRadius.only(topLeft : Radius.circular(10),bottomLeft : Radius.circular(10),)
                      :BorderRadius.only(topRight : Radius.circular(10),bottomRight : Radius.circular(10),)
                  ),
                  margin: isMe
                      ?EdgeInsets.only(top:8.0,bottom:8.0,left:80.0) //me
                      :EdgeInsets.only(top:8.0,bottom:8.0,right:80.0), //away user

                )
              ],
            );
          }
        );
      }
    );
  }
  Widget getMessageTemplate(data){
    return ListTile(
      title: Text(
        data.relatedusername.toString()+ 'has sent you a message tap to respond to them',
      ),
      /*onTap: (){
        debugPrint("Next Clicked");
        //Navigator.push(context, MaterialPageRoute(builder:(context)=>MessageWindow()));
      },*/
    );
  }
  _sendMessage() async{
    if(_controllerUserTypedMesssage.text == null || _controllerUserTypedMesssage.text.length == 0){
      _controllerChatStream.add(null);
    }else{
      var data = {'fromUserId' : storage.getItem('id'),
        'toUserId':this.RELATED_USER_ID,
        'message':_controllerUserTypedMesssage.text
      };
      final String pathUrl = serverPathUrl+"/api/comm/insertConversation";
      final _http.Response response = await _http.post(
          pathUrl,
          body : jsonEncode(data),
          headers : {
            HttpHeaders.contentTypeHeader : 'application/json; charset=utf-8',
            HttpHeaders.authorizationHeader : 'bearer '+ storage.getItem("token"),
          }
      );
      if(response.statusCode == 200){
        _controllerChatStream.add(data);
        _controllerUserTypedMesssage.text="";
      }
    }

  }
  Future<List<Message>> getMessageList() async{
    CURRENT_USER = storage.getItem('id');
    var data = {
      'userId' : storage.getItem('id'),
      'fromUserId':this.RELATED_USER_ID};
    final String pathUrl = serverPathUrl+"/api/comm/getConversation";
    final _http.Response response = await _http.post(
        pathUrl,
        body : jsonEncode(data),
        headers : getHeaders()
    );
    var jsonData = json.decode(response.body);
    List<Message> messageList = [];
    for (var n in jsonData){
      var msg = Message(n['conv_id'],
        n['fromuserid'],
        n['touserid'],
        n['message'],
        n['time_stamp'],
        n['senttime']
      );
      messageList.add(msg);
      MESSAGE_LIST.add(msg);
      _controllerChatStream.add(msg);
    }
    print('User to user messages length'+ messageList.length.toString());
    return messageList;
  }
  Future<List<Message>> getMessageLatest() async{
    CURRENT_USER = storage.getItem('id');
    var latestConvId = 0;
    if(MESSAGE_LIST.length ==0 ){
      latestConvId = 0;
    }else{
      latestConvId = MESSAGE_LIST[MESSAGE_LIST.length-1].conv_id;
    }
    var data = {
      'userId' : storage.getItem('id'),
      'fromUserId':this.RELATED_USER_ID,
      'conv_id':latestConvId
    };
    final String pathUrl = serverPathUrl+"/api/comm/getConversationLatest";
    final _http.Response response = await _http.post(
        pathUrl,
        body : jsonEncode(data),
        headers : {
          HttpHeaders.contentTypeHeader : 'application/json; charset=utf-8',
          HttpHeaders.authorizationHeader : 'bearer '+ storage.getItem("token"),
        }
    );
    var jsonData = json.decode(response.body);
    List<Message> messageList = [];
    for (var n in jsonData){
      var msg = Message(n['conv_id'],
          n['fromuserid'],
          n['touserid'],
          n['message'],
          n['time_stamp'],
          n['senttime']
      );
      messageList.add(msg);
      MESSAGE_LIST.add(msg);
      _controllerChatStream.add(msg);
    }
    print('User to user messages length Received this Req'+ messageList.length.toString());
    print('User to user messages length TOTAL'+ MESSAGE_LIST.length.toString());
    return messageList;
  }

  getHeaders(){
    return {
      HttpHeaders.contentTypeHeader : 'application/json; charset=utf-8',
      HttpHeaders.authorizationHeader : 'bearer '+ storage.getItem("token"),
    };
  }
}