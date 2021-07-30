import 'dart:convert';
import 'dart:developer';
//import 'dart:html';
import 'dart:io';
import 'package:flutter/services.dart';
import 'package:http/http.dart' as _http;
import 'package:flutter/material.dart';
import 'package:flutter_pop/Models/models.dart';
import 'package:flutter_pop/Screens/LoginScreen.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:location/location.dart';
import 'package:localstorage/localstorage.dart';
import 'HomePage.dart';
import 'SelectInterests.dart';
class RegisterPage extends StatefulWidget {
  @override
  _RegisterPageState createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  bool  isUnique=false;
  var isFormValid="valid";
  //var selectedValueG = "I am a";
  //var selectedValueS = "I am looking for";
  var selectedValueS, selectedValueG;
  var gender = [
    {"text":"I am a Man","value":"M"},
    {"text":"I am a Woman","value":"W"},
    {"text":"I am an LGBTQ","value":"Q"}
  ];
  var sexuality = [
    {"text":"I am looking for men","value":"M"},
    {"text":"I am looking for women","value":"W"},
    {"text":"I am looking for men","value":"Q"}
  ];
  var user = {
    "userName":"",
    "phone_number":"",
    "age":"",
    "password":"",
    "cpassword":"",
    "userDescription":"",
    "location_x":"",
    "location_y":"",
    "gender":"",
    "sexuality":"",
    'country_code':'91'

  };
  var expt={
    "id":"",
    "name":"",
    "selected":""
  };
  var selectedList=[{"id":"1"},
    {"id":"2"},
    {"id":"3"},
    {"id":"4"},
  ];
  var exptList=[
  {"id": "1", "name": "abc"},
  {"id": "2", "name": "asdsad"},
  {"id": "3", "name": "asdads"}
  ];
  var exptListWidgetArray=<Widget>[];
void onExptSelect(bool selected, expt_id){
  if(selected == true){
    setState((){
      selectedList.add({"id":expt_id});
    });
  }else{
    setState((){
      selectedList.remove({"id":expt_id});
    });
  }
}

postRegistrationData(user) async{

  var data = {
    'phone_number': user['country_code'] + user['phone_number'],
    'password':user['password'],
    'cpassword':user['cpassword'],
    'age':user['age'],
    'userName':user['userName'],
    'userDescription':user['userDescription'],
    'date_of_birth':user['date_of_birth'],
    'location_x':user['location_x'],
    'location_y':user['location_y'],
    'sexuality':user['sexuality'],
    'gender':user['gender']
  };

  final String pathUrl = serverPathUrl+"/api/UserProfile/insertUser";
  final _http.Response response = await _http.post(
      pathUrl,
      body : jsonEncode(data),
      //body: jsonEncode({'phone_number': user['country_code'] + user['phone_number'],'password':user['password'],'location_x':user['location_x'],'location_y':user['location_y']}),
      headers : {
        HttpHeaders.contentTypeHeader : 'application/json; charset=utf-8',
        //'Access-Control-Allow-Origin':'true'
      }
  );
  debugPrint(jsonEncode({'userName':user['userName'],'phone_number': user['country_code'] + user['phone_number'],'password':user['password'],'location_x':user['location_x'],'location_y':user['location_y']}));
  debugPrint(TokenMdl.fromJson(jsonDecode(response.body)).toString());
  return response;
}
checkUnique(user) async{

  var data = {
    'phone_number': user['country_code'] + user['phone_number'],
    'userName': user['userName']

  };
  final String pathUrl = serverPathUrl+"/api/Token/checkUnique";
  final _http.Response response = await _http.post(
      pathUrl,
      body : jsonEncode(data),
      //body: jsonEncode({'phone_number': user['country_code'] + user['phone_number'],'password':user['password'],'location_x':user['location_x'],'location_y':user['location_y']}),
      headers : {
        HttpHeaders.contentTypeHeader : 'application/json; charset=utf-8',
        //'Access-Control-Allow-Origin':'true'
      }
  );
  debugPrint(jsonEncode({'phone_number': user['country_code'] + user['phone_number'],'password':user['password'],'location_x':user['location_x'],'location_y':user['location_y']}));
  //debugPrint(TokenMdl.fromJson(jsonDecode(response.body)).toString());
  //return response;
  var res = TrueFalseMsg.fromJson(jsonDecode(response.body));
  //if(response.statusCode == 200){return true  ;}else{return false;}

  if (res.message == "true"){
    debugPrint(user['userName']);
    debugPrint(user['password']);
    debugPrint(user['phone_number']);

    if(user['userName'].length > 7 && user["phone_number"].length > 7){
      debugPrint(isUnique.toString());
      isUnique = true;
      setState((){
        numberNameValid = isUnique;
        isFormValid = "_valid";
      });
      return true;
    }else{
      debugPrint(isUnique.toString());
      isUnique =false;
      setState((){
        isFormValid = "invalid";
        numberNameValid = isUnique;
      });
      return false;
    }


  }else{
    debugPrint(isUnique.toString());
    isUnique =false;
    setState((){
      isFormValid = "invalid";
      numberNameValid = isUnique;
    });
    return false;
  }


}
  /*
  List<Widget> buildCheckboxes(){
    for(var i=0;i<exptList.length;i++){
      //var radioText=exptList[i]["name"].toString();
      exptListWidgetArray.add(
        new CheckboxListTile(
            title: Text(exptList[i]["name"]),
            //value: exptList[i]["selected"],
            onChanged: (bool v)=>setState((){debugPrint(v.toString());debugPrint(exptList.length.toString());debugPrint(i.toString());
            //exptList[i]["selected"]=v;
            controlAffinity: ListTileControlAffinity.leading;
          }))
      );
    }
    return exptListWidgetArray;
  }
  */

  showDialogB(
      //context: context, builder:(context
      ) {
    return AlertDialog(
      title: new Text("Notice"),
      content: new Text(
          "Data should not be empty"),
      actions: <Widget>[
        new FlatButton(
          child: new Text("Close"),
          onPressed: () {
            Navigator.of(context).pop();
          },
        )
      ],
    );
  }

  var p_contentPadding = EdgeInsets.all(20.0);
  final controllerTxtCode = TextEditingController();
  bool numberNameValid=false;
  var _formKey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    final LocalStorage storage = new LocalStorage('pop');
    return new Scaffold(
      backgroundColor: Colors.white,
      appBar: new AppBar(
          backgroundColor: Colors.white,
          automaticallyImplyLeading: false,
          elevation: 0,
          actions: [
            new IconButton(
                icon: new Icon(Icons.arrow_forward,
                    //color:Colors.Theme.of(context).primaryColor
                    color: Colors.pinkAccent),
                onPressed: () {

                }
            )
          ],
          leading: new IconButton(
              icon: new Icon(Icons.arrow_back,
                  //color:Colors.Theme.of(context).primaryColor
                  color: Colors.pinkAccent),
              onPressed: () {
                Navigator.pop(context);
              }
          )
      ),
      body:new SingleChildScrollView(
        child: Form(
          key : _formKey,
          child: Column(
            children:<Widget>[
              new Text(
              "Tell us about yourself ...",
              style : new TextStyle(
                  fontSize: ScreenUtil().setWidth(24),
                  color: numberNameValid?Colors.green:Colors.red
              ),

            ),
              new TextFormField(
                //inputFormatters: [FilteringTextInputFormatter.allow(new RegExp("/[a-zA-Z]/g"))],
                keyboardType: TextInputType.name,
                decoration: InputDecoration(
                  labelText: 'Name',
                  hintText: 'Enter Your Name',
                  prefixIcon: new Icon(numberNameValid?Icons.check:Icons.clear_outlined),
                  contentPadding: EdgeInsets.all(20.0),
                  /*border: new UnderlineInputBorder(
                      borderSide: new BorderSide(
                          color: numberNameValid?Colors.green:Colors.blue
                      )
                  )*/
                ),
                validator:(v){
                  return numberNameValid?null:'Please enter unique name';
                },
                onChanged: (v) async {
                  user["userName"] = v;
                  numberNameValid = await checkUnique(user);
                },
              ),
              new TextField(
                keyboardType: TextInputType.number,
                decoration: InputDecoration(
                  labelText: 'Phone Number',
                  hintText: 'Phone Number',
                  contentPadding: EdgeInsets.all(20.0),
                ),
                onChanged: (v)async{
                  user["phone_number"] = v;
                  numberNameValid = await checkUnique(user);
                },
              ),
              new Text(
                  isFormValid,
                  style : new TextStyle(
                      fontSize: ScreenUtil().setSp(48),
                      color:Colors.grey[700]
                  )
              ),
              new Text(
                  "I am a",
                  style : new TextStyle(
                      fontSize: ScreenUtil().setSp(48),
                      color:Colors.grey[700]
                  )
              ),
              new DropdownButton<String>(
                  items: gender.map((var genderItem) {
                    return new DropdownMenuItem<String>(
                      value: genderItem['value'],
                      child: new Text(genderItem['text']),
                    );
                  }).toList(),
                  onChanged: (_) {
                    setState((){
                      user["gender"] = _.toString();
                      selectedValueG = _.toString();
                    });
                  },
                  value : selectedValueG
              ),
              new Text(

                  "I am looking for",
                  style : new TextStyle(
                      fontSize: ScreenUtil().setSp(48),
                      color:Colors.grey[700]
                  )
              ),
              new DropdownButton<String>(

                  items: sexuality.map((var sexualityItem) {
                    return new DropdownMenuItem<String>(
                      value: sexualityItem['value'],
                      child: new Text(sexualityItem['text']),
                    );
                  }).toList(),
                  onChanged: (_) {
                    setState((){
                      user["sexuality"] = _.toString();
                      selectedValueS = _.toString();
                    });
                  },
                  value : selectedValueS
              ),
              new TextField(
                //keyboardType: TextInputType.name,
                decoration: InputDecoration(
                  labelText: 'Description',
                  hintText: 'describe yourself',
                  contentPadding: EdgeInsets.all(20.0),
                ),
                onChanged: (v){user["userDescription"] = v;},
              ),
              new TextFormField(
                keyboardType: TextInputType.visiblePassword,
                obscureText: true,
                decoration: InputDecoration(
                  labelText: 'Password',
                  hintText: 'password',
                  contentPadding: EdgeInsets.all(20.0),
                ),
                onChanged: (v){user["password"] = v;},

              ),
              new TextField(
                keyboardType: TextInputType.visiblePassword,
                //inputFormatters: [FilteringTextInputFormatter.allow("/^[a-z0-9_-]{6,16}/")],
                obscureText :true,
                decoration: InputDecoration(
                  labelText: 'Confirm Password',
                  hintText: 'Confirm Password',
                  contentPadding: EdgeInsets.all(20.0),
                ),
                onChanged: (v){user["cpassword"] = v;},
              ),

              new TextField(
                keyboardType: TextInputType.number,
                decoration: InputDecoration(
                  labelText: 'Age',
                  hintText: 'Age ',
                  contentPadding: EdgeInsets.all(20.0),
                ),
                onChanged: (v){user["age"] = v;},
              ),
              /*new InputDatePickerFormField(
                  initialDate: DateTime.now(),
                ),*/
              new InputDatePickerFormField (
                firstDate: DateTime(2019),
                lastDate: DateTime(2025, 12, 12),
                //initialDate: selectedDate,
                initialDate: DateTime.now(),
                onDateSubmitted: (date) {
                  setState(() {
                    user['date_of_birth']= date.toString();
                  });
                },
              ),
              /*new TextField(
                  //initialDate: DateTime.now(),
                  keyboardType: TextInputType.datetime,
                  onChanged: (v){
                    debugPrint(v.toString());
                  },
                ),*/
              //new ListView(),
              //PersonalityType
              SizedBox(
                  height:60
              ),

              new FlatButton.icon(
                //mainAxisAlignment: MainAxisAlignment.center,
                onPressed: () async {
                  if (_formKey.currentState.validate()) {
                    // If the form is valid, display a snackbar. In the real world,
                    // you'd often call a server or save the information in a database.
                    //Navigator.of(context).showSnackBar(
                      const SnackBar(content: Text('Processing Data'));
                    //);
                    debugPrint('valid');
                  }else{
                    return showDialog(context: context, builder:(context) {
                      return AlertDialog(
                        title: new Text("Notice"),
                        content: new Text("Name Number are not unique"),
                      );
                    });

                  }
                  Location location = new Location();
                  debugPrint("Next Clicked");
                  var condn = (isUnique == true &&
                      (user["userName"].trim() == "" ||
                          user["phone_number"].trim() == "" ||
                          user["age"].trim() == "" ||
                          user["password"].trim() == "" ||
                          user["cpassword"].trim() == "" ||
                          user["userDescription"].trim() == "" ||
                          user["location_x"].trim() == "" ||
                          user["location_y"].trim() == "" ||
                          user["gender"].trim() == "" ||
                          user["sexuality"].trim() == ""));

                  debugPrint("condn" + condn.toString());
                  debugPrint("userName" + user["userName"].trim().toString());
                  debugPrint("phone_number" + user["phone_number"].trim().toString());
                  debugPrint("age" + user["age"].trim().toString());
                  debugPrint("password" + user["password"].trim().toString());
                  debugPrint("cpassword" + user["cpassword"].trim().toString());
                  debugPrint("userDescription" + user["userDescription"].trim().toString());
                  debugPrint("location_x" + user["location_x"].trim().toString());
                  debugPrint("location_y" + user["location_y"].trim().toString());
                  debugPrint("gender" + user["gender"].trim().toString());
                  debugPrint("sexuality" +  user["sexuality"].trim().toString());
                  if(
                  isUnique == false ||
                      (user["userName"].trim() == "" ||
                          user["phone_number"].trim() == "" ||
                          user["age"].trim() == "" ||
                          user["password"].trim() == "" ||
                          user["cpassword"].trim() == "" ||
                          user["userDescription"].trim() == "" ||
                          user["gender"].trim() == "" ||
                          user["sexuality"].trim() == "" ||
                          user["password"].trim() != user["cpassword"].trim()
                      )
                  ){
                    debugPrint(user.toString());
                    return showDialog(context: context, builder:(context){
                      return AlertDialog(
                        title:new Text("Notice"),
                        content: new Text("no Data should  be empty. And you must confirm your password."),
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
                  _http.Response res = await postRegistrationData(user);

                  if(res.statusCode == 200 )
                  {
                    //Map<String, dynamic> obj = TokenMdl.fromJson(jsonDecode(res.body));
                    Map<String, dynamic> obj = jsonDecode(res.body);
                    storage.setItem('id', obj["data"].toString());
                    storage.setItem('token', obj["data2"]);
                    //storage.setItem('token', jsonDecode(res.body));
                    //storage.setItem('id', user['id']);
                    debugPrint(user.toString());
                    Navigator.pop(context);
                    Navigator.pop(context);
                    Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) =>
                            LoginScreen())
                    );
                  }else{
                    return showDialog(context: context, builder:(context){
                      return AlertDialog(
                        title:new Text("Alert"),
                        content: new Text("Something went wrong"),
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
                  Navigator.push(context, MaterialPageRoute(builder:(context)=>LoginScreen()));
                  //Navigator.push(context, MaterialPageRoute(builder:(context)=>SelectInterests()));
                },
                icon: Icon(Icons.arrow_forward),
                label: new Text("Next"),

              )
              ]
          ),
        )

      ),

    );
  }
}
