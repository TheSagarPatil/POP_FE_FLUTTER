import 'dart:convert';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter_pop/Screens/uploader.dart';
import 'package:http/http.dart' as _http;
import 'package:localstorage/localstorage.dart';
import 'package:flutter_pop/Models/models.dart';
import 'package:image_cropper/image_cropper.dart';
import 'package:image_picker/image_picker.dart';

class ImageCapture extends StatefulWidget {
  @override
  DemoState createState() => new DemoState();
}

class DemoState extends State<ImageCapture> {

  LocalStorage storage;
  File _imageFile;
  @override
  void initState() {
    storage = new LocalStorage('pop');
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return new Scaffold(
      bottomNavigationBar: BottomAppBar(
        child: Row(
          children : <Widget>[
            IconButton(
              icon: Icon(Icons.photo_camera),
              onPressed:()=> pickImage(ImageSource.camera),
            ),
            IconButton(
                icon: Icon(Icons.photo_library),
                onPressed:()=> pickImage(ImageSource.gallery),
            ),

          ]
        )
      ),
      body:ListView(
        children:<Widget>[
          if(_imageFile != null) ...[
            Image.file(_imageFile),
            Row(
              children: <Widget>[
                FlatButton(
                  child : Icon(Icons.crop),
                  onPressed: _cropImage,
                ),
                FlatButton(
                  child : Icon(Icons.refresh),
                  onPressed: _clear,
                ),

              ]
            ),
            Uploader(file: _imageFile)
          ]
        ]
      )
    );
  }

  Future<void> pickImage(ImageSource source) async{
    File selected = await ImagePicker.pickImage(source : source);

    setState(()=>{
      _imageFile = selected
    });
  }
  void _clear() {
    setState(()=>_imageFile=null);
  }

  Future<void> _cropImage() async{
    File cropped = await ImageCropper.cropImage(
      sourcePath: _imageFile.path,
      //ratioX:1.0,
      //ratioY:1.0,
      //maxWidth:512,
      //maxHeight:512,
      toolbarColor:Colors.purple,
      toolbarWidgetColor: Colors.white,
      toolbarTitle:'Crop it'
    );

    setState(() {
      _imageFile = cropped ?? _imageFile;
    });
  }
}