import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart';
import 'package:shared_preferences/shared_preferences.dart';

class UserModel {
  String id;
  String name;
  String userName;
  bool isAdmin;
  List<String> institutions;

  UserModel(
      {required this.id,
      required this.name,
      required this.userName,
      required this.isAdmin,
      required this.institutions});
}

class User with ChangeNotifier {
  String _accessToken = "";
  bool _isAuth = false;

  bool get getIsAuth {
    return _isAuth;
  }

  Future<String> signIn(String userName, String password) async {
    var client = Client();
    final prefs = await SharedPreferences.getInstance();
    String domainUri = prefs.get("studymat_backend_uri") as String;

    try {
      var tokenRes = await client.post(
          Uri.parse("$domainUri/api/unsigned/login"),
          body: json.encode({"userName": userName, "password": password}),
          headers: {"Content-Type": "application/json"});

      if (tokenRes.statusCode != 200) {
        throw tokenRes.body;
      }

      var parsedBody = json.decode(tokenRes.body);
      prefs.setString("studymat_accessToken", parsedBody["accessToken"]);
      _accessToken = parsedBody["accessToken"];
      _isAuth = true;

      return "Done";
    } catch (e) {
      print(e);
      return "Error";
    } finally {
      client.close();
      notifyListeners();
    }
  }

  Future<String> signUp(
    String name,
    String userName,
    int phoneNumber,
    String emailId,
    String password,
    String confirmPasssword,
  ) async {
    var client = Client();
    final prefs = await SharedPreferences.getInstance();
    String domainUri = prefs.get("shore_backend_uri") as String;

    if (password != confirmPasssword) {
      return "Password are Different";
    }

    try {
      var res = await client.post(Uri.parse("$domainUri/api/unsigned/register"),
          body: json.encode({
            "name": name,
            "phoneNumber": phoneNumber,
            "userName": userName,
            "emailId": emailId,
            "password": password
          }),
          headers: {"Content-Type": "application/json"});

      if (res.statusCode != 200) {
        return json.decode(res.body)["message"];
      }

      var parsedBody = json.decode(res.body);

      return "Done";
    } catch (e) {
      print(e);
      return "Error";
    } finally {
      client.close();
      notifyListeners();
    }
  }
}
