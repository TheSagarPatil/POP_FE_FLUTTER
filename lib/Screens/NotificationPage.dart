import 'dart:convert';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter_pop/Models/models.dart';
import 'dart:developer';
import 'package:http/http.dart' as _http;
import 'package:localstorage/localstorage.dart';

import 'MessageWindow.dart';
import 'SelectInterests.dart';

class NotificationPage extends StatefulWidget {
  @override
  _NotificationPageState createState() => _NotificationPageState();
}

class _NotificationPageState extends State<NotificationPage> {
  final LocalStorage storage = new LocalStorage('pop');
  //Future<List<userNotification>> _notificationList;

  Future<List<userNotification>> getNotificationList() async{
    var data = {'userId' : storage.getItem('id'),'distance':10};
    final String pathUrl = serverPathUrl+"/api/match/getNotificationsListByUser";
    final _http.Response response = await _http.post(
        pathUrl,
        body : jsonEncode(data),
        headers : {
          HttpHeaders.contentTypeHeader : 'application/json; charset=utf-8',
          HttpHeaders.authorizationHeader : 'bearer '+ storage.getItem("token"),
        }
    );
    var jsonData = json.decode(response.body);
    List<userNotification> notificationList = [];
    for (var n in jsonData){
      var msg = userNotification(n['id'], n['userId'], n['type'], n['metadatajson'], n['relateduserid'], n['relatedusername']);
      notificationList.add(msg);
    }
    print(notificationList.length.toString());
    return notificationList;
  }

  @override
  Widget build(BuildContext context) {
    log("msg intiate");
    return Container(
        child: getFutureListView()
      //Text('Opening nots')
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
      future:getNotificationList(),
      builder: (BuildContext context, AsyncSnapshot snapshot){
        if(snapshot.data == null){
          return Container(
              child:Text('No notifications found')
          );
        }else{
          return ListView.builder(
              itemCount:snapshot.data.length,
              itemBuilder:(BuildContext context, int index){
                var data = snapshot.data[index];
                if(data.type=='SWIPE'){
                  return getSwipeTemplate(data);
                }else{ //(snapshot.data[index].type == 'MESSAGE'){
                  return getMessageTemplate(data);
                }
                //else{}
              }
          );
        }
      },
    );
  }
  Widget getSwipeTemplate(data){
    return ListTile(
        title: Text(

          //'Data'
          //+ snapshot.data[index].msgcount.toString()
          data.relatedusername.toString() + ' has liked you tap to like them back and message.'

          //+ snapshot.data[index].converserid.toString()
          ,
          //style: TextStyle(fontSize: 16.0, fontWeight: FontWeight.bold),
        ),
        onTap: (){
          debugPrint("Next Clicked");
          Navigator.push(context, MaterialPageRoute(builder:(context)=>MessageWindow(data.relateduserid)));
        },
        leading: ConstrainedBox(
          constraints: BoxConstraints(
            minWidth: 44,
            minHeight: 44,
            maxWidth: 44,
            maxHeight: 44,
          ),
          //child: Image.asset('assets/images/person1.jpg', fit: BoxFit.cover),
          child: provideImage(data)

        )
    );
  }
  Widget getMessageTemplate(data){
    return ListTile(
      title: Text(
        data.relatedusername.toString()+ 'has sent you a message tap to respond to them',
      ),
      onTap: (){
        debugPrint("Next Clicked");
        Navigator.push(context, MaterialPageRoute(builder:(context)=>MessageWindow(data.relateduserid)));
      },
    );
  }
  Image provideImage(data){
    if(deployedMode){
      var path = networkPath+data.relateduserid.toString()+'.jpg';
      return Image.network(path, fit: BoxFit.cover);
    }else{
      var path = filePath+data.relateduserid.toString() + '.jpg';
      debugPrint(path);
      return Image.file(File(path) , fit: BoxFit.cover);
    }
  }
}
