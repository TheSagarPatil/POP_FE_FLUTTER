import 'dart:async';
import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class Uploader extends StatefulWidget{
  final File file;
  Uploader({Key key, this.file}): super(key: key);

  createState() => _UploaderState();
}

class _UploaderState extends State<Uploader>{
  int _uploadTask;
  StreamController _controllerStream =StreamController();
  Stream _stream;

  void initState() {
    _controllerStream = StreamController();
    _stream = _controllerStream.stream;
  }

  @override
  Widget build(BuildContext context){
    if(_uploadTask != null){
      return StreamBuilder(
        stream: _stream,
        builder:(context, snapshot){
          var event = snapshot.data;

          double progressPercent = 1;
          return Column(
            children : <Widget>[
              if(event == 'COMPLETE')
                Text('Done'),
              if(event == 'INPROGRESS')
                Text('IN PROGRESS'),

            ]
          );

        }
      );
    }else{
      return FlatButton.icon(
        label:Text('Uploading to server'),
        icon : Icon(Icons.cloud_upload)
      );
    }
  }

  uploadFile() async{

  }
}