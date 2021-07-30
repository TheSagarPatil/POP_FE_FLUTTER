import 'dart:ui';

import 'package:flutter/foundation.dart';


//var serverPathUrl = "http://192.168.0.103:62435";
var serverPathUrl = "http://127.0.0.1:5000";
//var serverPathUrl = "http://192.168.1.106:5000";
var deployedMode = false;
var filePath = 'F:/uploads/';
var networkPath = 'http://127.0.0.1:5000/getImage/';

/*COLORS*/

var MODEL_SYSTEM_COLORS = {
  'COLOR_CHAT_PINK' : Color(0xFFFFEFEE)
};

class User{
  String userName;
  var id;
  String password;
  String phone_number;
  User({
    this.userName,
    this.id,
    this.password,
    this.phone_number,
    //@required this.title,
    //@required this.body,
  });

  factory User.fromJson(Map<String, dynamic> json) {
    return User(
      userName: json['userName'] as String,
      id: json['id'] as int,
      //title: json['title'] as String,
      //body: json['body'] as String,
    );
  }
  factory User.fromJsonForLogin(json) {
    return User(
      userName: json['userName'] as String,
      id: json['id'] as int,
      phone_number: json['phone_number'] as String,
      //title: json['title'] as String,
      //body: json['body'] as String,
    );
  }
}
class TrueFalseMsg{
  String message;
  TrueFalseMsg({this.message});
  factory TrueFalseMsg.fromJson(Map<String, dynamic> json){
    return TrueFalseMsg(
        message: json['message']
    );
  }
}
class TokenMdl{
  String message;
  String data;
  String data2;
  TokenMdl({this.message, this.data, this.data2});
  factory TokenMdl.fromJson(Map<String, dynamic> json){
    return TokenMdl(
        message: json['message'],
        data: json['data'],
        data2: json['data2']
    );
  }
}
class Attribute{
  int id;
  int exptId;
  String exptName;

  Attribute({this.id, this.exptId, this.exptName});
  factory Attribute.fromJson(Map<String, dynamic> json){
    return Attribute(
        id: json['id'],
        exptId: json['exptId'],
        exptName: json['exptName']
    );
  }
}
class MatchPerson{
  int id;
  String name;
  String imageURL;
  int age;
  String bio;
  int score;
  MatchPerson({this.id, this.name, this.imageURL,this.age, this.bio, this.score});

  factory MatchPerson.fromJson(Map<String, dynamic> json){
    return MatchPerson(
        id: json['id'],
        name: json['name'],
        imageURL: json['imageURL'],
        age: json['age'],
        bio: json['userdescription'],
        score: json['score']
    );
  }
}
class MatchPerson2{
  int id;
  String username;
  String imgid="";
  int age;
  String userdescription;
  int gender;
  MatchPerson2(this.id, this.username, this.age);

  factory MatchPerson2.fromJson(Map<String, dynamic> json){
    return MatchPerson2(
      json['id'],
      json['username'],
      json['age']
    );
  }

  toString(){
    return this.id.toString()
        + this.username
        + this.age.toString();
  }
}

class MessagePayload{
  int id=0;
  String username='';
  int msgcount=0;
  int converserid=0;
  MessagePayload(this.id,
      this.username,
      this.msgcount,
      this.converserid,
      );
  factory MessagePayload.fromJson(Map<String, dynamic> json){
    return MessagePayload(
        json['id'],
        json['username'],
        json['msgcount'],
        json['converserid']
    );
  }
  @override
  String toString() {
    // TODO: implement toString
    return "{$this.userId.toString()}, {$this.fromUserId.toString()}, {$this.toUserId.toString()}, {$this.converser.toString()}, {$this.message.toString()}";
  }
}
class Message{
  int conv_id;
  int fromUserId;
  int toUserId;
  String message;
  String time_stamp;
  String senttime;

  Message(this.conv_id,
      this.fromUserId,
      this.toUserId,
      this.message,
      this.time_stamp,
      this.senttime
      );
  factory Message.fromJson(Map<String, dynamic> json){
    return Message(
        json['conv_id'],
        json['fromUserId'],
        json['toUserId'],
        json['message'],
        json['time_stamp'],
        json['senttime']
    );
  }
  @override
  String toString() {
    // TODO: implement toString
    return "{$this.conv_id.toString()}, "
        + "{$this.fromUserId.toString()}, "
        + "{$this.toUserId.toString()}, "
        + "{$this.message.toString()}, "
        + "{$this.time_stamp.toString()}"
        + "{$this.senttime.toString()}"
    ;
  }

}
class userNotification{
  int id;
  int userId;
  String type="";
  String metadatajson;
  int relateduserid;
  String relatedusername;
  //int timestamp;
  userNotification(this.id, this.userId, this.type, this.metadatajson, this.relateduserid, this.relatedusername);

  factory userNotification.fromJson(Map<String, dynamic> json){
    return userNotification(
        json['id'], json['userId'], json['type'], json['metadatajson'], json['relateduserid'], json['relatedusername']
    );
  }

  toString(){
    return this.id.toString()
      + ' '+ this.userId.toString()
      + ' '+ this.type.toString()
      + ' '+ this.metadatajson
      + ' '+ this.relateduserid.toString()
      + ' '+ this.relatedusername.toString();
  }
}