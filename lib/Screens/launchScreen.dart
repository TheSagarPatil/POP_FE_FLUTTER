import 'dart:async';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_pop/Screens/LoginScreen.dart';
import 'HomePage.dart';

class LaunchScreen extends StatefulWidget {
  @override
  _LaunchScreenState createState() => _LaunchScreenState();
}

class _LaunchScreenState extends State<LaunchScreen> {
  @override
  void initState() {
    super.initState();
    Timer(new Duration(seconds: 1),(){
      Navigator.pop(context);
      //Navigator.pushNamed(context, '/');
      Navigator.push(context, MaterialPageRoute(builder: (context) {
        new Cookie("token","tokenData");
        if(true){
          //return HomePage();
          return LoginScreen();
        }else {
          return LoginScreen();
        }
      })) ;
    });
  }

  @override
  Widget build(BuildContext context) {
    ScreenUtil.init(context) ;

    return Scaffold(
      backgroundColor: Colors.white,
      body: new Center(
        child: new Image(
          width: ScreenUtil().setWidth(200.0),
          height: ScreenUtil().setHeight(200.0),
          image: new AssetImage('logos/POP_LOGO.png'),
        ),
      ),
    );
  }

  

}