/*
import 'dart:core';
import 'dart:core';

import 'package:flutter/material.dart';
class Expt{
  String id;
  String name;
  bool selected;
  Expt(id, name, selected){
    this.id=id;
    this.name=name;
    this.selected=selected;
  }
}
class SelectInterests extends StatefulWidget {
  @override
  _SelectInterestsState createState() => _SelectInterestsState();
}

class _SelectInterestsState extends State<SelectInterests> {
  Object expt={
    "id":"",
    "name":"",
    "selected":""
  };
  var selectedList=[{"id":"1"},
    {"id":"2"},
    {"id":"3"},
    {"id":"4"},
  ];
  var exptListRenderer=[
    Expt("1","nm1",false),
    Expt("2","nm3",false),
    Expt("3","nm2",false)
  ];
  var selectedList2 = <Expt>[];

  //List<int> selectedList = [];
  List<Widget> mList; //you can't add equal
  createMenuWidget(List exptListRenderer) {
    for (int b = 0; b < exptListRenderer.length; b++) {
      Map cmap = exptListRenderer[b];
      mList.add(CheckboxListTile(
        onChanged: (bool value){
          setState(() {
            if(value){
              selectedList.add(cmap[expt].id);
            }else{
              selectedList.remove(cmap[expt].id);
            }
          });
        },
        value: selectedList.contains(cmap[expt].id),
        title: new Text(cmap[expt].name),
      ));
    }
  }
  bool _isChecked = true;
  @override
  Widget build(BuildContext context) {

    return Scaffold(
      body:StatefulBuilder(
        builder: (BuildContext context, StateSetter setState) {
          return ListView.builder(
          itemCount: exptListRenderer.length,
          itemBuilder: (BuildContext context, int index) {
            return CheckboxListTile(
              value: //exptListRenderer[index].selected,
              false,
              onChanged: (bool selected ) {
                debugPrint(selected.toString()+ " " +
                    exptListRenderer[index].id.toString()
                );
                if(selected){
                  setState(() {
                    selectedList2.add(exptListRenderer[index]);
                  });
                }else{
                  setState(() {
                    selectedList2.remove(exptListRenderer[index]);
                  });
                }
              },
              title: Text(exptListRenderer[index].name),
            );
          }
      );
        }
    )

        );
  }

}
*/
import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_pop/Models/models.dart';
import 'package:flutter_pop/Screens/HomePage.dart';
import 'package:http/http.dart' as _http;
//import 'package:localstorage/localstorage.dart' as LocalStorage;
import 'package:localstorage/localstorage.dart';
class SelectInterests extends StatefulWidget {
  @override
  DemoState createState() => new DemoState();
}
class Expt{
  int id;
  String name;
  bool selected;
  /*
  Expt({this.id, this.name, this.selected}){

    this.id=id;
    this.name=name;
    this.selected=selected;
  }
  */
  Expt(id, name, selected){
    this.id=id;
    this.name=name;
    this.selected=selected;
  }

}
class DemoState extends State<SelectInterests> {
  var selectedList=[{"id":"1"},
    {"id":"2"},
    {"id":"3"},
    {"id":"4"},
  ];
  var exptListRenderer_ = [new Expt(1,"Adventurous",false),new Expt(2,"Ambitious",false),new Expt(3,"Ambivert",false),new Expt(4,"Artist",false),new Expt(5,"BikeLover",false),new Expt(6,"Calm",false),new Expt(7,"Caring",false),new Expt(8,"CarLover",false),new Expt(9,"ChaiLover",false),new Expt(10,"Charming",false),new Expt(11,"Cheerful",false),new Expt(12,"Creative",false),new Expt(13,"Chocaholic",false),new Expt(14,"CoffeeLover",false),new Expt(15,"Curious",false),new Expt(16,"Danceholic",false),new Expt(17,"Divorced",false),new Expt(18,"DogLover",false),new Expt(19,"Dreamer",false),new Expt(20,"Emotional",false),new Expt(21,"Energetic",false),new Expt(22,"Entertainer",false),new Expt(23,"Entrepreneur",false),new Expt(24,"Extrovert",false),new Expt(25,"Faithful",false),new Expt(26,"Foodie",false),new Expt(27,"Friendly",false),new Expt(28,"Funny",false),new Expt(29,"GadgetLover",false),new Expt(30,"GameAdict",false),new Expt(31,"Geek",false),new Expt(32,"Independent",false),new Expt(33,"Intellectual",false),new Expt(34,"Introvert",false),new Expt(35,"Kind",false),new Expt(36,"Loyal",false),new Expt(37,"Moody",false),new Expt(38,"Motivated",false),new Expt(39,"MovieManiac",false),new Expt(40,"MusicLover",false),new Expt(41,"Mysterious",false),new Expt(42,"NatureLover",false),new Expt(43,"NightOwl",false),new Expt(44,"OpenMinded",false),new Expt(45,"Optimistic",false),new Expt(46,"PartyHooper",false),new Expt(47,"Reader",false),new Expt(48,"Romantic",false),new Expt(49,"Sapiosexual",false),new Expt(50,"Sarcastic",false),new Expt(51,"Sexi",false),new Expt(52,"Shopaholic",false),new Expt(53,"Shy",false),new Expt(54,"Simple",false),new Expt(55,"Spiritual",false),new Expt(56,"SportsFanatic",false),new Expt(57,"Stylish",false),new Expt(58,"Talkative",false),new Expt(59,"Techie",false),new Expt(60,"Traveller",false),new Expt(61,"Workaholic",false),new Expt(62,"Writer",false),new Expt(63,"OneNightStand",false),new Expt(64,"ShortTerm",false),new Expt(65,"LongTerm",false),new Expt(66,"LookingForMarriage",false),new Expt(67,"Artist",false),new Expt(68,"Engineer",false),new Expt(69,"Doctor",false),new Expt(70,"Activist",false),new Expt(71,"Accountant",false),new Expt(72,"Undecided",false),new Expt(73,"Smoker",false),new Expt(74,"Architect",false),new Expt(75,"Marketeer",false),new Expt(76,"Auctioneer",false),new Expt(77,"Cheff",false),new Expt(78,"Beautician",false),new Expt(79,"Expert/Consultant",false),new Expt(80,"Athlete",false),new Expt(81,"Mechanic",false)];
  var exptListRenderer=[
    new Expt(1,"nm1",false),
    /*Expt("2","nm3",false),
    Expt("3","nm2",false),
    Expt("4","nm4",false),
    Expt("5","nm5",false),
    Expt("6","nm6",false),
    Expt("7","nm7",false),
    Expt("8","nm8",false),
    Expt("9","nm29",false),
    Expt("10","nm10",false),
    Expt("11","nm11",false),
    Expt("12","nm12",false),
    Expt("13","nm13",false),
    Expt("14","nm14",false),
    Expt("15","nm15",false),
    Expt("11","nm11",false),
    Expt("12","nm12",false),
    Expt("13","nm13",false),
    Expt("14","nm14",false),
    Expt("15","nm15",false),*/
  ];
  var selectedList2 = <Expt>[];
  Map<String, bool> values = {
    'foo': true,
    'bar': false,
  };
  LocalStorage storage;
  insertExpt() async{
    final String pathUrl = serverPathUrl+"/api/match/insertAttributesListForUser";
    var data = [];
    for(var i=0; i< selectedList2.length; i++){
      data.add({
        "userId": storage.getItem('id'),
        "exptId" : selectedList2[i].id
      });
    }
    final _http.Response response = await _http.post(
        pathUrl,
        body : jsonEncode(data),
        headers : {
          HttpHeaders.contentTypeHeader : 'application/json; charset=utf-8',
          HttpHeaders.authorizationHeader : 'bearer '+ storage.getItem('token')
        }
    );
    //var res = response.body.substring(1, response.body.length-1).replace(new RegExp("\\/g"), "");
    var res = response.body;
    Iterable list = json.decode(res);
    //exptListRenderer = list.map((item)=> Attribute.fromJson(item)).toList();
    debugPrint(exptListRenderer_.toString());
  }
  getAttributesListByUser() async{
    var data = {'userId':storage.getItem('id')};
    final String pathUrl = serverPathUrl+"/api/match/getAttributesListByUser";
    final _http.Response response = await _http.post(
        pathUrl,
        body : jsonEncode(data),
        headers : {
          HttpHeaders.contentTypeHeader : 'application/json; charset=utf-8',
        }
    );
    var res = response.body;
    Iterable list = json.decode(res);
    //list.Map((e)=>SelectedList.add(e));
    debugPrint(selectedList.toString());
  }
  getExptList() async{
    //getAttributesList
    //var data = {'phone_number': user['country_code'] + user['phone_number'],'password':user['password'], 'location_x':user['location_x'],'location_y':user['location_y']};

    final String pathUrl = serverPathUrl+"/api/match/getAttributesList";
    final _http.Response response = await _http.post(
        pathUrl,
        //body : jsonEncode(data),
        headers : {
          HttpHeaders.contentTypeHeader : 'application/json; charset=utf-8',
        }
    );
    //var res = response.body.substring(1, response.body.length-1).replace(new RegExp("\\/g"), "");
    var res = response.body;
    Iterable list = json.decode(res);
    //exptListRenderer = list.map((item)=> Attribute.fromJson(item)).toList();
    debugPrint(exptListRenderer_.toString());
  }



  @override
  void initState() {
    storage = new LocalStorage('pop');
    // TODO: implement initState
    //getExptList();
    //exptListRenderer.add(Expt('4','abc','false'));
    super.initState();
    //exptListRenderer = getExptList();
    //debugPrint(exptListRenderer.toString());
  }
  @override
  Widget build(BuildContext context) {
    return new Scaffold(
        appBar: new AppBar(
          //title: new Text('Select Your')
          backgroundColor: Colors.white,
          automaticallyImplyLeading: false,
          elevation: 0,
          actions: [
            new IconButton(
                icon: new Icon(Icons.arrow_forward,
                    //color:Colors.Theme.of(context).primaryColor
                    color: Colors.pinkAccent),
                onPressed: () {
                  Navigator.push(context, MaterialPageRoute(builder:(context)=>HomePage()));
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
          ),



        ),
        body: new Stack(
            children: <Widget>[
              ListView(
                children:
                exptListRenderer_.map((e) {
                  return new CheckboxListTile(
                    title: new Text(e.name),
                    value: e.selected,
                    onChanged: (bool value) {
                      /*setState(() {
                        e.selected = value;
                      });*/
                      debugPrint("SelectedList Length "+selectedList2.length.toString());
                      setState((){
                        if(value){
                          e.selected = value;
                          selectedList2.add(e);
                        }else{
                          e.selected = value;
                          selectedList2.remove(e);
                        }
                      });


                    },
                  );
                }).toList(),

              ),
              SizedBox(
                  height:300
              ),
              FlatButton.icon(onPressed: (){
                debugPrint("Next Clicked");
                insertExpt();
                Navigator.push(context, MaterialPageRoute(builder:(context)=>HomePage()));
              },
                  icon: Icon(Icons.arrow_forward),
                  label: new Text("Next")
              ),
            ]
        )
    );
  }
}
