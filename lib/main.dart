import 'package:flutter/material.dart';
import 'package:flutter_pop/Screens/launchScreen.dart';
import 'package:flutter_pop/Screens/MessageTab.dart';
void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Pick Or Pass',
      theme: ThemeData(
        primaryColor: Color.fromRGBO(253, 41, 123, 1.0),
        secondaryHeaderColor: Color.fromRGBO(255, 88, 100, 1.0),
        accentColor: Color.fromRGBO(255, 101, 91, 1.0),
          //textWhite: Color.fromRGBO(255, 255, 255, 1.0)
      ),
      home: LaunchScreen(),
      /*routes:{
        '/': (context) => LaunchScreen(),
        '/messages': (context) => MessageTab(),
      }*/
    );
  }
}
