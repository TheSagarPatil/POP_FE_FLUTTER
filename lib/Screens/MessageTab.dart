import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_pop/Models/models.dart';
import 'dart:developer';
import 'package:http/http.dart' as _http;
import 'package:localstorage/localstorage.dart';

import 'MessageWindow.dart';

class MessageTab extends StatefulWidget {
  @override
  _MessageTabState createState() => _MessageTabState();
}

class _MessageTabState extends State<MessageTab> {
  final LocalStorage storage = new LocalStorage('pop');
  Future<List<MessagePayload>> _conversationList;

  Future<List<MessagePayload>> getConversationList() async{
    var data = {'userId' : storage.getItem('id'),'distance':10};
    final String pathUrl = serverPathUrl+"/api/UserProfile/getConversationList";
    final _http.Response response = await _http.post(
        pathUrl,
        body : jsonEncode(data),
        headers : {
          HttpHeaders.contentTypeHeader : 'application/json; charset=utf-8',
          HttpHeaders.authorizationHeader : 'bearer '+ storage.getItem("token"),
        }
    );
    var jsonData = json.decode(response.body);
    List<MessagePayload> conversationList = [];
    for (var m in jsonData){
      var msg = MessagePayload(m['id'],
          m['username'],
          m['msgcount'],
          m['converserid']);
      conversationList.add(msg);
    }
    print(conversationList.length.toString());
    return conversationList;
  }

  @override
  Widget build(BuildContext context) {
    log("msg intiate");
    return Container(
      child: getFutureListView()
      /*Column(
        children:<Widget>[
          ListTile(
            title: Text(
              'Sender',
              style: TextStyle(fontSize: 18.0, fontWeight: FontWeight.bold),
            ),

            leading: ConstrainedBox(
              constraints: BoxConstraints(
                minWidth: 44,
                minHeight: 44,
                maxWidth: 44,
                maxHeight: 44,
              ),
            child: Image.asset('assets/images/person1.jpg', fit: BoxFit.cover),
          ),
          )
        ]
      )*/
    );
  }
  Widget getFutureListView(){
    return FutureBuilder(
      future:getConversationList(),
      builder: (BuildContext context, AsyncSnapshot snapshot){
        if(snapshot.data == null){
          return Container(
              child:Text('_NULL_')
          );
        }else{
          return ListView.builder(
              itemCount:snapshot.data.length,
              itemBuilder:(BuildContext context, int index){
                var data = snapshot.data[index];
                return ListTile(
                  title: Text(
                      //'Data'
                          //+ snapshot.data[index].msgcount.toString()
                          snapshot.data[index].username.toString()
                          //+ snapshot.data[index].converserid.toString()
                      ,
                    style: TextStyle(fontSize: 18.0, fontWeight: FontWeight.bold),
                  ),
                  leading: ConstrainedBox(
                    constraints: BoxConstraints(
                      minWidth: 44,
                      minHeight: 44,
                      maxWidth: 44,
                      maxHeight: 44,
                    ),
                    child: Image.asset('assets/images/person1.jpg', fit: BoxFit.cover),
                  ),
                  onTap: ()=>{
                    Navigator.push(context, MaterialPageRoute(builder:(context)=>MessageWindow(data.converserid)))
                  },
                );
              }
          );
        }

      },
    );
  }
}
