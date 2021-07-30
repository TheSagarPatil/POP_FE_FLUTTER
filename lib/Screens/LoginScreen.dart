import 'package:flutter/material.dart';
import 'package:flutter_pop/Screens/RegisterPage.dart';
import 'package:flutter_pop/Screens/phoneNumberScreen.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
//import 'package:tinder_clone/Models/tinder_clone_icons.dart';
//import 'package:tinder_clone/Screens/PhoneNumber.dart';

class LoginScreen extends StatefulWidget {
  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {

  GlobalKey<ScaffoldState> _scaffoldkey = new GlobalKey<ScaffoldState>() ;

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      body: new Container(
          decoration: new BoxDecoration(
              gradient: new LinearGradient(
                  colors: [
                    Theme.of(context).accentColor,
                    Theme.of(context).secondaryHeaderColor,
                    Theme.of(context).primaryColor
                  ],
                  begin: Alignment.topRight,
                  end: Alignment.bottomRight,
                  stops: [0.0, 0.35, 1.0])),
          child: new Column(
            children:<Widget>[
              new Expanded(
                  flex:5,
                  child: Center(
                    child:Column(
                      mainAxisAlignment:MainAxisAlignment.center,
                      children: [
                        new Text(
                          "PICK",
                          style: new TextStyle(
                              fontSize: ScreenUtil().setSp(150.0),
                              letterSpacing: 1.2,
                              fontWeight: FontWeight.w800,
                              color: Colors.white,
                              height: 0.8
                          ),
                        ),
                        new Text(
                          "OR",
                          style: new TextStyle(
                              fontSize: ScreenUtil().setSp(100.0),
                              letterSpacing: 1.2,
                              fontWeight: FontWeight.w800,
                              color: Colors.white,
                              height: 0.8
                          ),
                        ),new Text(
                          "PASS",
                          style: new TextStyle(
                              fontSize: ScreenUtil().setSp(140.0),
                              letterSpacing: 1.2,
                              fontWeight: FontWeight.w800,
                              color: Colors.white,
                              height: 0.8
                          ),
                        )
                      ],
                    )
                  )),
              new Expanded(
                  flex:3,
                  child: Center(
                    child : Column(
                      mainAxisAlignment:MainAxisAlignment.center,
                      children: [
                        new FlatButton(
                          shape: new RoundedRectangleBorder(
                          borderRadius:BorderRadius.circular(100)
                          ),
                          color:Colors.white,
                          onPressed: (){
                            debugPrint("Login Clicked");
                            Navigator.push(context, MaterialPageRoute(builder:(context)=>PhoneNumberScreen()));
                          },
                          child: new Text("Login",
                              style:new TextStyle(
                                  //fontSize: ScreenUtil().setSp(80)
                              )
                          )
                        ),
                        new FlatButton(
                            shape: new RoundedRectangleBorder(
                                borderRadius:BorderRadius.circular(100)
                            ),
                            color:Colors.white,
                            onPressed: (){
                              debugPrint("Register Clicked");
                              Navigator.push(context, MaterialPageRoute(builder:(context)=>RegisterPage()));
                            },
                            child: new Text("Register",
                                style:new TextStyle(
                                  //fontSize: ScreenUtil().setSp(80)
                                )
                            )
                        ),
                        new Text(
                          "Find your match",
                            style: new TextStyle(
                              color: Colors.white,
                            )
                        ),
                        new Text("by logging in You agree with terms and conditions",
                            style: new TextStyle(
                                color: Colors.white
                            )
                        )
                      ],
                    )
                  ))
            ],
          )),
    );
  }
}