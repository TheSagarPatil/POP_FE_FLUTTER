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
import 'package:image_cropper/image_cropper.dart';
import 'package:image_picker/image_picker.dart';
import 'package:flutter_pop/Screens/imageCapture.dart';

class PhotoUpload extends StatefulWidget {
  @override
  DemoState createState() => new DemoState();
}
class DemoState extends State<PhotoUpload> {

  LocalStorage storage;

  @override
  void initState() {
    storage = new LocalStorage('pop');
    // TODO: implement initState
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return new Scaffold(
        appBar: new AppBar(
          title: new Text('Select A Picture'),
          backgroundColor: Colors.white,
          automaticallyImplyLeading: false,
          elevation: 0,
          /*actions: [
            new IconButton(
                icon: new Icon(Icons.arrow_forward,
                    //color:Colors.Theme.of(context).primaryColor
                    color: Colors.pinkAccent),
                onPressed: () {
                  Navigator.push(context, MaterialPageRoute(builder:(context)=>HomePage()));
                }
            )
          ],*/
          leading: new IconButton(
              icon: new Icon(
                  Icons.arrow_back,
                  color: Colors.pinkAccent
              ),
              onPressed: () {
                Navigator.pop(context);
              }
          ),
        ),
        body:new ImageCapture()
    );
  }
}

