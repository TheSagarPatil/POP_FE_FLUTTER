import 'dart:convert';
import 'dart:developer' as developer;
import 'dart:io';
//flutter run -d web-server --web-port 5555
//flutter run -d headless-server --web-port=5555

import 'package:flutter/material.dart';
import 'package:flutter_pop/Models/models.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter/services.dart';
import  'package:http/http.dart' as _http;
import 'HomePage.dart';
import 'package:location/location.dart';
import 'package:localstorage/localstorage.dart';


class PhoneNumberScreen extends StatefulWidget {
  @override
  _PhoneNumberScreenState createState() => _PhoneNumberScreenState();
}
class _PhoneNumberScreenState extends State<PhoneNumberScreen> {
  final controllerTxtCode = TextEditingController();
  var _controller = new TextEditingController(text: '91');
  var user={
    'country_code':'91',
    'phone_number':'',
    'password':''
  };
//  final Location location = Location();
/*  void getDeviceLocation() async{
    Location location = new Location();

    bool _serviceEnabled;
    PermissionStatus _permissionGranted;
    LocationData _locationData;

    _serviceEnabled = await location.serviceEnabled();
    if (!_serviceEnabled) {
      _serviceEnabled = await location.requestService();
      if (!_serviceEnabled) {
        return;
      }
    }

    _permissionGranted = await location.hasPermission();
    if (_permissionGranted == PermissionStatus.denied) {
      _permissionGranted = await location.requestPermission();
      if (_permissionGranted != PermissionStatus.granted) {
        return;
      }
    }
  }*/

  Future<_http.Response> postData(user) async{
    var data = {'phone_number': user['country_code'] + user['phone_number'],'password':user['password'], 'location_x':user['location_x'],'location_y':user['location_y']};
    //final String pathUrl = serverPathUrl+"http://localhost:62435/api/Token/GetToken";
    final String pathUrl = serverPathUrl+"/api/Token/GetToken";
    print("path : " + pathUrl);
    try {
      final _http.Response response = await _http.post(
          pathUrl,
          body: jsonEncode(data),
          //body: jsonEncode({'phone_number': user['country_code'] + user['phone_number'],'password':user['password'],'location_x':user['location_x'],'location_y':user['location_y']}),
          headers: {
            HttpHeaders.contentTypeHeader: 'application/json; charset=utf-8',
            //'Access-Control-Allow-Origin':'true'
          }
      );
      //if (response.statusCode == 201 || response.statusCode == 200) {
      // If the server did return a 201 CREATED response,
      // then parse the JSON.
      print("status :" + response.statusCode.toString());
      debugPrint(jsonEncode({
        'phone_number': user['country_code'] + user['phone_number'],
        'password': user['password'],
        'location_x': user['location_x'],
        'location_y': user['location_y']
      }));
      debugPrint(TokenMdl.fromJson(jsonDecode(response.body)).toString());

      //return TokenMdl.fromJson(jsonDecode(response.body));
      return response;
    }
    catch(e) {
      print('error caught: $e');
    }
    //} else {
      // If the server did not return a 201 CREATED response,
      // then throw an exception.
      //return response;
      //throw Exception('Failed to load album');
    //}
  }
  var connectionStatus = "notConnected";
  Future<_http.Response> getConnection() async{

    //final String pathUrl = serverPathUrl+"http://localhost:62435/api/Token/GetToken";
    final String pathUrl = serverPathUrl+"/api/Token/GetToken";
    print("path : " + pathUrl);
    try {
      final _http.Response response = await _http.get(
          pathUrl,
          headers: {
            HttpHeaders.contentTypeHeader: 'application/json; charset=utf-8',
            //'Access-Control-Allow-Origin':'true'
          }
      );
      print("connectionStatus :" + response.statusCode.toString());
      print("ConnectionSecured");
      debugPrint("ConnectionSecured");
      developer.log("connectionStatus :" + response.statusCode.toString());
      //debugPrint(TokenMdl.fromJson(jsonDecode(response.body)).toString());
      //return TokenMdl.fromJson(jsonDecode(response.body));
      return response;
    }
    catch(e) {
      print('error caught: $e');
    }
    //} else {
    // If the server did not return a 201 CREATED response,
    // then throw an exception.
    //return response;
    //throw Exception('Failed to load album');
    //}
  }
  @override
  Widget build(BuildContext context) {
    final LocalStorage storage = new LocalStorage('pop');

    return new Scaffold(
      backgroundColor: Colors.white,
      appBar: new AppBar(
          backgroundColor: Colors.white,
          automaticallyImplyLeading: false,
          elevation: 0,
          leading: new IconButton(
              icon: new Icon(Icons.arrow_back,
                  //color:Colors.Theme.of(context).primaryColor
                  color: Colors.pinkAccent),
              onPressed: () {
                Navigator.pop(context);
              }
            )
      ),
      body: new Padding(
          padding: EdgeInsets.only(
            left: ScreenUtil().setSp(50.0),
            right: ScreenUtil().setSp(50.0),
          ),
          child: new Column(
            children: <Widget>[
              new Expanded(
                  flex: 5,
                  child: new Column(
                    children: <Widget>[
                      new Align(
                        alignment: Alignment.topLeft,
                        child: new Text(
                          "My Phone Number is",
                          style: new TextStyle(
                              fontSize: ScreenUtil().setSp(96.0),
                              fontWeight: FontWeight.w600,
                              color: Colors.black54),
                        ),
                      ),
                      new SizedBox(height: ScreenUtil().setHeight(80)),
                      new Row(children: <Widget>[
                        new Expanded(
                          flex: 3,
                          child: new TextField(
                            controller : _controller,
                            keyboardType: TextInputType.number,
                            cursorColor: Theme.of(context).primaryColor,
                            onChanged: (v){
                              setState(() {
                                user['country_code'] = v;
                              });
                            },
                            decoration: new InputDecoration(
                                prefixIcon: new Icon(
                                  Icons.add,
                                  color: Colors.black,
                                ),
                                helperText: 'Country code'),
                          ),
                        ),
                        new SizedBox(
                          width: ScreenUtil().setWidth(20.0),
                        ),
                        new Expanded(
                            flex: 7,
                            child: new TextField(
                              //controller: controllerTxtCode,
                              onChanged: (v){
                                setState(() {
                                  user['phone_number'] = v;
                                });
                              },
                              keyboardType: TextInputType.number,
                              cursorColor: Theme.of(context).primaryColor,
                              inputFormatters: <TextInputFormatter>[
                                FilteringTextInputFormatter.digitsOnly
                              ],
                              decoration: new InputDecoration(helperText: 'Phone number'),

                            )
                        ),
                        new SizedBox(
                          height: ScreenUtil().setHeight(60.0),
                        ),
                      ]),
                      new SizedBox(
                        height: ScreenUtil().setHeight(60.0),
                      ),
                      new Row(
                        children: <Widget>[
                          new Expanded(
                            flex:10,
                            child: new TextField(
                              //controller: controllerTxtCode,
                              obscureText: true,
                              onChanged: (v){
                                setState((){
                                  user['password']=v;
                                });
                              },
                              cursorColor: Theme.of(context).primaryColor,
                              decoration:new InputDecoration(
                                  helperText:"Password"
                              ),

                            )
                          )
                        ],
                      ),
                      new SizedBox(
                        height: ScreenUtil().setHeight(60.0),
                      ),
                      new Text(
                        'When you tap "Continue",Tinder will send a text a with verification code. Message and data rates may apply.\nThe verified phone number can be used to log in. Learn what happens when your number changes.',
                        style: new TextStyle(
                            fontSize: ScreenUtil().setSp(37.0),
                            fontWeight: FontWeight.w500,
                            color: Colors.black54),
                      ),
                      new SizedBox(
                        height: ScreenUtil().setHeight(40.0),
                      ),
                      new GestureDetector(
                        onTap: () async {

                          //testing purpose code

                          /*Navigator.pop(context);
                          Navigator.pop(context);
                          Navigator.push(
                              context,
                              MaterialPageRoute(builder: (context) =>
                                  HomePage())
                          );*/
                          //return;
                          //remove this


                          var a = getConnection();
                          //log("controllerValue"+controllerTxtCode.value.toString());
                          debugPrint('posting data');
                          Location location = new Location();
                          if(user['phone_number'].length<8 || user['password'].length <8){
                            return showDialog(context: context, builder:(context){
                              return AlertDialog(
                                title:new Text("Notice"),
                                content: new Text("Phone numbers and Passwords can not be less than 8 characters"),
                                actions: <Widget>[
                                  new FlatButton(
                                    child: new Text("Close"),
                                    onPressed: (){
                                      Navigator.of(context).pop();
                                    },
                                  )
                                ],
                              );
                          });
                          }else{

                          }
                          bool _serviceEnabled;
                          PermissionStatus _permissionGranted;
                          LocationData _locationData;
                          _serviceEnabled = await location.serviceEnabled();
                          if (!_serviceEnabled) {
                            _serviceEnabled = await location.requestService();
                            if (!_serviceEnabled) {
                              return;
                            }
                          }
                          _permissionGranted = await location.hasPermission();
                          if (_permissionGranted == PermissionStatus.denied) {
                            _permissionGranted = await location.requestPermission();
                            if (_permissionGranted != PermissionStatus.granted) {
                              return;
                            }
                          }
                          _locationData = await location.getLocation();

                          debugPrint("Location Time" + _locationData.time.toString());
                          debugPrint("Location X" + _locationData.latitude.toString());
                          debugPrint("Location Y" + _locationData.longitude.toString());
                          user['location_x'] = _locationData.latitude.toString();
                          user['location_y'] = _locationData.longitude.toString();
                          //await postData(user).then((v){debugPrint(v.toString());print(v.toString());});
                          _http.Response res = await postData(user);

                          if(res.statusCode == 200 )
                          {
                            Map<String, dynamic> obj = jsonDecode(res.body);
                            storage.setItem('id', obj["id"].toString());
                            storage.setItem('token', obj["data"]);
                            //storage.setItem('token', jsonDecode(res.body));
                            //storage.setItem('id', user['id']);
                            debugPrint(user.toString());
                            Navigator.pop(context);
                            Navigator.pop(context);
                            Navigator.push(
                                context,
                                MaterialPageRoute(builder: (context) =>
                                    HomePage())
                            );
                          }else{
                            return showDialog(context: context, builder:(context){
                              return AlertDialog(
                                title:new Text("Alert"),
                                content: new Text("Wrong Password"),
                                actions: <Widget>[
                                  new FlatButton(
                                    child: new Text("Close"),
                                    onPressed: (){

                                      Navigator.of(context).pop();
                                    },
                                  )
                                ],
                              );
                            });
                          }
                        },
                        child: new Container(
                          decoration: new BoxDecoration(
                              borderRadius: new BorderRadius.circular(90.0),
                              gradient: new LinearGradient(
                                  colors: [
                                    Theme.of(context).accentColor,
                                    Theme.of(context).secondaryHeaderColor,
                                    Theme.of(context).primaryColor
                                  ],
                                  begin: Alignment.centerRight,
                                  end: Alignment.centerLeft,
                                  stops: [0.0, 0.1, 1.0])),
                          width: double.infinity,
                          height: ScreenUtil().setHeight(110.0),
                          child: Center(
                            child: new Text(
                              "CONTINUE",
                              style: new TextStyle(
                                  color: Colors.white,
                                  letterSpacing: 1.2,
                                  fontWeight: FontWeight.w600,
                                  fontSize: ScreenUtil().setSp(45.0)),
                            ),
                          ),
                        ),
                      )
                    ],
                  )),
            ],
          )),
    );
  }
}
