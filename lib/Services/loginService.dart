import 'package:flutter_pop/Models/conf.dart';
//
// import 'package:http/http.dart';
// class LoginService {
//   final String postsURL = "https://jsonplaceholder.typicode.com/posts";
//
//   Future<List<Post>> getPosts() async {
//     Response res = await get(postsURL);
//
//     if (res.statusCode == 200) {
//       List<dynamic> body = jsonDecode(res.body);
//
//       List<Post> posts = body
//           .map(
//             (dynamic item) => Post.fromJson(item),
//       )
//           .toList();
//
//       return posts;
//     } else {
//       throw "Can't get posts.";
//     }
//   }
// }


import 'dart:convert';
import 'package:flutter_pop/Models/models.dart';
import 'package:http/http.dart' as _http;
class LoginService {
  final String postsURL = "https://jsonplaceholder.typicode.com/posts";
  Future<List<User>> getPosts() async {
    _http.Response res = await _http.get(postsURL);
    if (res.statusCode == 200) {

      List<dynamic> body = jsonDecode(res.body);
      List<User> posts = body.map((dynamic item) => User.fromJson(item),).toList();
      return posts;
    } else {
      throw "Can't get posts.";
    }
  }
}
class LoginServiceS {
  User user;
  LoginServiceS(User user){
    this.user = user;
  }

  final String url_getUsers = "http://localhost:"+portNumber.toString()+"/api/Token/GetToken";
  Future<List<User>> getUsers() async {
    _http.Response res = await _http.get(url_getUsers);

    if (res.statusCode == 200) {
      List<dynamic> body = jsonDecode(res.body);

      List<User> userList = body
          .map(
            (dynamic item) => User.fromJson(item),
      ).toList();

      return userList;
    } else {
      throw "Can't get posts.";
    }
  }




}
