import 'dart:convert';
import 'dart:developer';
//import 'dart:html';
import 'dart:io';
import 'package:flutter_pop/Models/models.dart';
import 'package:flutter_pop/Screens/photoUpload.dart';
import  'package:http/http.dart' as _http;
import 'package:localstorage/localstorage.dart';
import 'package:flutter/material.dart';

import 'SelectInterests.dart';
class ProfileTab extends StatefulWidget {
  @override
  _ProfileTabState createState() => _ProfileTabState();
}
class _ProfileTabState extends State<ProfileTab> {
  LocalStorage storage;
  var tuserName = TextEditingController();
  var tusername = TextEditingController();
  var tphoneNumber = TextEditingController();
  var tpassword = TextEditingController();
  var tconfirmPassword = TextEditingController();
  var tage = TextEditingController();

  var user = {
    "userName":"",
    "phone_number":"",
    "age":"",
    "password":"",
    "cpassword":"",
    "_value":5
  };
  Future<_http.Response> postData(user) async {
    var data = {
      'id': storage.getItem('id').toString()
    };
    final String pathUrl = serverPathUrl+"/api/UserProfile/GetUserById";
    final _http.Response response = await _http.post(
        pathUrl,
        body: jsonEncode(data),
        //body: jsonEncode({'phone_number': user['country_code'] + user['phone_number'],'password':user['password'],'location_x':user['location_x'],'location_y':user['location_y']}),
        headers: {
          HttpHeaders.contentTypeHeader: 'application/json; charset=utf-8',
          //'Access-Control-Allow-Origin':'true'
        }
    );
    if(response.statusCode == 200 ) {

      Map <String, dynamic> obj = jsonDecode(response.body)[0];
      tuserName.text = obj["username"].toString();
      tusername.text = obj["username"].toString();
      tphoneNumber.text = obj["phone_number"].toString();
      tpassword.text= obj["password"].toString();
      tconfirmPassword.text= obj["password"].toString();
      tage.text= obj["age"].toString();
      debugPrint("=====user=========");
      debugPrint(obj.toString());
      debugPrint("=====user=========");
      user["userName"] = obj["userName"];

    }
  }
  Future<_http.Response> postDataUpdate(user) async {
    var data = {
      'id': storage.getItem('id').toString(),
      'password': tpassword.text.toString(),
      'username': tusername.text.toString(),
      'age': tage.text.toString(),
      'phone_number': tphoneNumber.text.toString(),

    };
    //final String pathUrl = "http://localhost:62435/api/UserProfile/updateuser";
    final String pathUrl = serverPathUrl+"/api/UserProfile/updateuser";
    final _http.Response response = await _http.post(
        pathUrl,
        body: jsonEncode(data),
        //body: jsonEncode({'phone_number': user['country_code'] + user['phone_number'],'password':user['password'],'location_x':user['location_x'],'location_y':user['location_y']}),
        headers: {
          HttpHeaders.contentTypeHeader: 'application/json; charset=utf-8',
          HttpHeaders.authorizationHeader : 'bearer '+ storage.getItem('token')
          //'Access-Control-Allow-Origin':'true'
        }
    );
    if(response.statusCode == 200 ) {
      Map <String, dynamic> obj = jsonDecode(response.body)[0];
      /*tusername.text = obj["username"].toString();
      tuserName.text = obj["userName"].toString();
      tphoneNumber.text = obj["phone_number"].toString();
      tpassword.text= obj["password"].toString();
      tconfirmPassword.text= obj["password"].toString();
      tage.text= obj["age"].toString();
      debugPrint("=====user=========");
      debugPrint(obj.toString());
      debugPrint("=====user=========");
      user["userName"] = obj["userName"];
*/
    }
  }
  @override
  void initState(){
    // TODO: implement initState

    super.initState();
    storage = new LocalStorage('pop');
    postData(user);
  }
  @override
  Widget build(BuildContext context) {
    log("profile  intiated");
    final LocalStorage storage = new LocalStorage('pop');
    debugPrint('--------------------------');
    debugPrint('storageUserId'+storage.getItem('id'));
    log('storageUserId'+storage.getItem('id'));
    return SingleChildScrollView(
      child: Column(
          children:<Widget>[
            /*ClipRRect(
              borderRadius: new BorderRadius.circular(100),
              child: Image.asset("$user.name"),
            ),*/
            new TextField(
              controller: tuserName,
              decoration: InputDecoration(
                labelText: 'Name',
                hintText: 'Enter Your Name',
                contentPadding: EdgeInsets.all(20.0),
              ),
              onChanged: (v){user["password"] = v;},
            ),
            new TextField(
              controller: tpassword,
              decoration: InputDecoration(
                labelText: 'Password',
                hintText: 'password',
                contentPadding: EdgeInsets.all(20.0),
              ),
              onChanged: (v){user["password"] = v;},
            ),
            new TextField(
              controller: tconfirmPassword,
              decoration: InputDecoration(
              labelText: 'Confirm Password',
              hintText: 'Confirm Password',
              contentPadding: EdgeInsets.all(20.0),
            ),
              onChanged: (v){user["cpassword"] = v;},
            ),
            new TextField(
              controller: tphoneNumber,
              decoration: InputDecoration(
                labelText: 'Phone Number',
                hintText: 'Phone Number',
                contentPadding: EdgeInsets.all(20.0),
              ),
              onChanged: (v){user["phoneNumber"] = v;},
            ),
            new TextField(
              controller: tage,
              decoration: InputDecoration(
                labelText: 'Age',
                hintText: 'Age ',
                contentPadding: EdgeInsets.all(20.0),
              ),
              onChanged: (v){user["age"] = v;},
            ),
            //new ListView(),
            //PersonalityType
            Slider(
              min: 0,
              max: 100,
              value: user['_value'],
              onChanged: (value) {
                setState(() {
                  user['_value'] = value;
                });
              },
            ),
            SizedBox(
                height:20
            ),

            new FlatButton.icon(
                //mainAxisAlignment: MainAxisAlignment.center,
              onPressed: (){
                debugPrint("Next Clicked");
                postDataUpdate(user);
                Navigator.push(context, MaterialPageRoute(builder:(context)=>PhotoUpload()));
                return new SnackBar(
                  content: Text('Yay! Success !!')
                );
              },
              icon: Icon(Icons.arrow_forward),
              label: new Text("Save Profile"),

            ),
            new FlatButton.icon(
              //mainAxisAlignment: MainAxisAlignment.center,
              onPressed: (){
                debugPrint("Next Clicked");
                Navigator.push(context, MaterialPageRoute(builder:(context)=>PhotoUpload()));
              },
              icon: Icon(Icons.arrow_forward),
              label: new Text("Next"),

            )
          ]
      ),
    );
  }
}
