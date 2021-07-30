import 'dart:convert';
import 'dart:developer';
import 'dart:io';
import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_pop/Models/models.dart';
import 'package:flutter_pop/Widgets/MatchCard.dart';
import 'package:flutter_screenutil/screenutil.dart';
import 'package:flutter_tindercard/flutter_tindercard.dart';
import 'package:location/location.dart';
import 'package:localstorage/localstorage.dart';
import 'package:http/http.dart' as _http;
//import 'package:location/get_location.dart';
//import 'package:location/listen_location.dart';
//import 'package:location/permission_status.dart';
//import 'package:location/service_enabled.dart';

class MatchTab extends StatefulWidget {
  @override
  _MatchTabState createState() => _MatchTabState();
}

class _MatchTabState extends State<MatchTab> with AutomaticKeepAliveClientMixin{
  @override
  bool get wantKeepAlive => true;
  List<MatchCard> peoples = [
    MatchCard(
        2, "user1", 'assets/images/person1.jpg', 21, 'software engg',3),
    /*MatchCard(
        3, "lewis hamilton", 'assets/images/person2.jpg', 25,'Mechatronic engg',3),
    MatchCard(
        4,"daniil ricciardo", 'assets/images/person3.jpg', 23, 'Photogrphr 📷',3),
    MatchCard(
        5,"seb vettel", 'assets/images/person4.jpg', 23, 'Camerogrph',3),
    MatchCard(
        6,"Risica Nibah", 'assets/images/person5.jpg', 26, 'studying in pune',3),
    MatchCard(
        7,"afdgadsf", 'assets/images/person6.jpg', 34, 'lawyer',3),
    MatchCard(
        8,"asfasf", 'assets/images/person7.jpg', 23, 'aerospace egg 🛫',3),
    MatchCard(
        9,"agafgas", 'assets/images/person8.jpg', 24, 'think tank guy 📚',3),*/
  ];
  Future<List<MatchCard>> matchList;
  Future __ppl;
  bool chng = true;
  bool atCenter = true;
  bool _triggerNotFound = false;
  bool _timeout = false;
  var swipe = "none";
  CardController _cardController;
  LocalStorage storage;

  Future<List<MatchPerson2>> getMatchesByUser() async{
    var data = {'userId' : storage.getItem('id'),'distance':10};
    final String pathUrl = serverPathUrl+"/api/match/findMatch";
    final _http.Response response = await _http.post(
        pathUrl,
        body : jsonEncode(data),
        headers : {
          HttpHeaders.contentTypeHeader : 'application/json; charset=utf-8',
          HttpHeaders.authorizationHeader : 'bearer '+ storage.getItem("token"),
        }
    );
    var jsonData = json.decode(response.body);
    /*List<MatchPerson> ppl = List<MatchPerson>.from(L.map((model)=> MatchPerson.fromJson(model)));
    for (var i=0; i<ppl.length ; i++){
      //matchList.add(new MatchCard(ppl[i].id, ppl[i].name,"", ppl[i].age, ppl[i].name, ppl[i].score));
      peoples.add(new MatchCard(ppl[i].id, ppl[i].name,"", ppl[i].age, ppl[i].name, ppl[i].score));
    }*/
    //debugPrint("pplLength"+ppl.length.toString());
    //debugPrint("peoplesLength"+peoples.length.toString());
    List<MatchPerson2> users = [];

    for(Map itm in jsonData){
      var obj = MatchPerson2.fromJson(itm);
      users.add(new MatchPerson2(obj.id, obj.username, obj.age));
      print(obj.toString());

      var obj2 = MatchCard.fromJson(itm);
      peoples.add(new MatchCard(obj.id, obj.username, 'assets/images/person1.jpg', obj.age, 'abc', 0));

    }
    /*for( var item in jsonData){
      MatchPerson2 matchPerson = MatchPerson2(item.id, item.name, item.imageURL,item.age, item.bio, item.score);
      //MatchPerson matchPerson = MatchPerson({id:item.id, name:item.name, imageURL:item.imageURL,age:item.age, bio:item.bio, score:item.score});
      users.add(matchPerson);
    }*/
    var len = users.length;
    debugPrint("usersLength"+len.toString());
    return users;



    //return users;
    //return peoples;
  }
  insertMatchByUser(swiped, swipe) async {
    //var data = {'phone_number': user['country_code'] + user['phone_number'],'password':user['password'], 'location_x':user['location_x'],'location_y':user['location_y']};
    var data = { 'swiper':storage.getItem('id'), 'swiped':swiped, 'swipe':swipe };
    //final String pathUrl = "http://localhost:62435/api/match/insertMatchByUser";
    final String pathUrl = serverPathUrl+"/api/match/insertMatchByUser";
    final _http.Response response = await _http.post(
      pathUrl,
      body : jsonEncode(data),
      //body: jsonEncode({'phone_number': user['country_code'] + user['phone_number'],'password':user['password'],'location_x':user['location_x'],'location_y':user['location_y']}),
      headers : {
        HttpHeaders.contentTypeHeader : 'application/json; charset=utf-8',
        HttpHeaders.authorizationHeader : 'bearer '+ storage.getItem("token"),
        //'Access-Control-Allow-Origin':'true'
      }
    );
    //debugPrint(TokenMdl.fromJson(jsonDecode(response.body)).toString());
    //return response;
  }
  var insertData={
    "swiper":"",
    "swiped":"",
    "swipe":""
  };
  final Location location = Location();

  @override
  void initState() {
    // TODO: implement initState
    storage = new LocalStorage('pop');
    //matchList = getMatchesByUser();
    //this.getDevLocation();
    super.initState();
    //getMatchesByUser();
    //matchList = await getMatchesByUser();
    //this.getDevLocation();
  }
  /*

  var res = await getMatchesByUser();
    for (Map i in res){
      var obj = MatchPerson.fromJson(i);
      peoples.add(new MatchCard(obj.id, obj.name, obj.imageURL, obj.age, obj.bio, obj.score));
      //peoples.add(new MatchCard(obj["id"], obj["name"], obj["imageURL"], obj["age"], obj["bio"], obj["score"]));
    }

  * */
  @override
  Widget build(BuildContext context) {
    log("Match intiated");
    /*
    var res = await getMatchesByUser();
    for (Map i in res){
      var obj = MatchPerson.fromJson(i);
      peoples.add(new MatchCard(obj.id, obj.name, obj.imageURL, obj.age, obj.bio, obj.score));
      //peoples.add(new MatchCard(obj["id"], obj["name"], obj["imageURL"], obj["age"], obj["bio"], obj["score"]));
    }
    */
    debugPrint('Peoples length');
    debugPrint(peoples.length.toString());
    //getMatchesByUser();
    return FutureBuilder(
        future: getMatchesByUser(),
        builder: (context, snapshot){
          switch(snapshot.connectionState){
            case ConnectionState.done:
              //debugPrint(matchList.toString());
              if(snapshot.data == null ){
                return Text('Null');
              }else{
                debugPrint(snapshot.data[0].username);
                /*return ListView.builder(
                  itemCount: snapshot.data.length,
                  itemBuilder: (BuildContext context, int index){
                    return ListTile(
                        title:Text(snapshot.data[index].username)
                    );
                  },
                );*/



              /*return new AnimatedContainer(
                  duration : new Duration(milliseconds: 600),
                  color: swipe=="left"
                      ? Colors.teal[200]
                      : Colors.pinkAccent[200],
                  child : new Align(
                      alignment: Alignment.topCenter,
                      child : new TinderSwapCard(
                        cardBuilder: (context, index){
                          debugPrint('peoplesLength on widget');
                          debugPrint(snapshot.data.length.toString());
                          return snapshot.data[index];
                        },
                        totalNum: snapshot.data.length,
                        stackNum: 4,
                        swipeEdge: 4.0,
                        maxWidth: MediaQuery.of(context).size.width - 10.0,
                        maxHeight: MediaQuery.of(context).size.height * 0.74,
                        minWidth: MediaQuery.of(context).size.width - 50.0,
                        minHeight: MediaQuery.of(context).size.height * 0.73,
                        cardController: _cardController,
                        swipeUpdateCallback: (DragUpdateDetails details, Alignment align){
                          bool swipeFlg;
                          if(align.x >0 ){
                            debugPrint("or > 0 Right");
                            setState((){
                              swipe = "right";
                              swipeFlg = true;
                            });
                          }else if(align.x < 0){
                            debugPrint("or < 0 Left");
                            swipe = "left";
                            swipeFlg = false;
                          }else{
                            debugPrint("or = 0");
                          }
                          insertData["swipe"] = swipeFlg.toString();
                          //debugPrint(index);
                        },
                        swipeCompleteCallback: (CardSwipeOrientation orientation, int index){

                          insertMatchByUser(snapshot.data[index].id, insertData["swipe"]);
                          setState((){
                            atCenter = true;
                            if(index == snapshot.data.length -1){
                              _triggerNotFound = true;
                              debugPrint("index = " + index.toString());
                              //setState(() {});
                            }
                          });
                        },
                      )
                  )
              );*/
                //var peoples = snapshot.data;
                return Stack(
                    children : <Widget>[
                      new AnimatedContainer(
                        duration : new Duration(milliseconds: 600),
                        color: swipe=="left"
                          ? Colors.teal[200]
                          : Colors.pinkAccent[200],
                          child : new Align(
                            alignment: Alignment.topCenter,
                            child : new TinderSwapCard(
                              cardBuilder: (context, index){
                                debugPrint('peoplesLength on widget');
                                debugPrint(peoples.length.toString());
                                return peoples[index];
                              },
                              totalNum: peoples.length,
                              stackNum: 4,
                              swipeEdge: 4.0,
                              maxWidth: MediaQuery.of(context).size.width - 10.0,
                              maxHeight: MediaQuery.of(context).size.height * 0.74,
                              minWidth: MediaQuery.of(context).size.width - 50.0,
                              minHeight: MediaQuery.of(context).size.height * 0.73,
                              cardController: _cardController,
                              swipeUpdateCallback: (DragUpdateDetails details, Alignment align){
                                bool swipeFlg;
                                if(align.x >0 ){
                                  debugPrint("or > 0 Right");
                                  //setState((){
                                    swipe = "right";
                                    swipeFlg = true;
                                  //});
                                }else if(align.x < 0){
                                  debugPrint("or < 0 Left");
                                  swipe = "left";
                                  swipeFlg = false;
                                }else{
                                  debugPrint("or = 0");
                                }
                                insertData["swipe"] = swipeFlg.toString();
                                debugPrint(insertData['swipe']);
                              },
                              swipeCompleteCallback: (CardSwipeOrientation orientation, int index){

                                insertMatchByUser(peoples[index].id, insertData["swipe"]);
                                //setState((){
                                atCenter = true;
                                if(index == peoples.length -1){
                                  _triggerNotFound = true;
                                  debugPrint("index = " + index.toString());
                                  //setState(() {});
                                }
                                //});
                              },
                            )
                          )
                      )
                    ]
                );
            }
            break;
            default:
              return Text('Fail');
          }

        }
    );

    /*return Stack(
      children : <Widget>[
        /*new AnimatedContainer(
          duration : new Duration(milliseconds: 600),
          color: swipe=="left"
            ? Colors.teal[200]
            : Colors.pinkAccent[200],
            child : new Align(
              alignment: Alignment.topCenter,
              child : new TinderSwapCard(
                cardBuilder: (context, index){
                  debugPrint('peoplesLength on widget');
                  debugPrint(peoples.length.toString());
                  return peoples[index];
                },
                totalNum: peoples.length,
                stackNum: 4,
                swipeEdge: 4.0,
                maxWidth: MediaQuery.of(context).size.width - 10.0,
                maxHeight: MediaQuery.of(context).size.height * 0.74,
                minWidth: MediaQuery.of(context).size.width - 50.0,
                minHeight: MediaQuery.of(context).size.height * 0.73,
                cardController: _cardController,
                swipeUpdateCallback: (DragUpdateDetails details, Alignment align){
                  bool swipeFlg;
                  if(align.x >0 ){
                    debugPrint("or > 0 Right");
                    setState((){
                      swipe = "right";
                      swipeFlg = true;
                    });
                  }else if(align.x < 0){
                    debugPrint("or < 0 Left");
                    swipe = "left";
                    swipeFlg = false;
                  }else{
                    debugPrint("or = 0");
                  }
                  insertData["swipe"] = swipeFlg.toString();
                  //debugPrint(index);
                },
                swipeCompleteCallback: (CardSwipeOrientation orientation, int index){

                  insertMatchByUser(peoples[index].id, insertData["swipe"]);
                  setState((){
                    atCenter = true;
                    if(index == peoples.length -1){
                      _triggerNotFound = true;
                      debugPrint("index = " + index.toString());
                      //setState(() {});
                    }
                  });
                },
              )
            )
        )*/
      ]
    );*/
  }

  void getDevLocation() async{
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
  }
}
