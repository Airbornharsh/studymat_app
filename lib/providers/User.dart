import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:studymat_app/Utils/StudyMats/loadMat.dart';
import 'package:studymat_app/providers/StudyMats.dart';

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
  List<Institution> _availableInstitutes = [];
  Map<dynamic, dynamic> _institution = {};

  bool get getIsAuth {
    return _isAuth;
  }

  int get getAvailableInstitutionsLength {
    return _availableInstitutes.length;
  }

  List<Institution> get getAvailableInstitutions {
    return _availableInstitutes;
  }

  Map<dynamic, dynamic> getAvailableInstitution(String institutionId) {
    if (_institution.containsKey(institutionId)) {
      return _institution[institutionId];
    } else {
      return {};
    }
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
    String domainUri = prefs.get("studymat_backend_uri") as String;

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

  void listAvailableInstitutes() async {
    var client = Client();
    final prefs = await SharedPreferences.getInstance();
    String domainUri = prefs.getString("studymat_backend_uri") as String;
    String? accessToken = prefs.getString("studymat_accessToken");
    try {
      var institutionRes = await client.post(
          Uri.parse("$domainUri/api/signed/institution/availablelist"),
          headers: {
            "authorization": "bearer $accessToken",
          });

      final parsedInstitutionBody = json.decode(institutionRes.body);
      _availableInstitutes.clear();

      parsedInstitutionBody.forEach((institution) {
        _availableInstitutes.add(Institution(
            id: institution["_id"],
            name: institution["name"],
            photoLink: institution["photoLink"],
            pdfs: institution["pdfs"],
            playlists: institution["playlists"],
            videos: institution["videos"]));
      });
    } catch (e) {
      print(e);
    } finally {
      notifyListeners();
    }
  }

  Future loadMat(String institutionId) async {
    try {
      final matData = await loadMatData(institutionId);

      _institution[institutionId] = matData;
    } catch (e) {
      print(e);
    }
  }

  Future postMat(
      {required institutionId,
      required name,
      required link,
      required course,
      required branch,
      required year,
      required subject,
      required module,
      required type}) async {
    var client = Client();
    final prefs = await SharedPreferences.getInstance();
    String domainUri = prefs.getString("studymat_backend_uri") as String;
    String? accessToken = prefs.getString("studymat_accessToken");
    try {
      var matRes =
          await client.post(Uri.parse("$domainUri/api/signed/$type/create"),
              body: json.encode({
                "institutionId": institutionId,
                "name": name,
                "link": link,
                "courses": [course],
                "branches": [branch],
                "years": [year],
                "subjects": [subject],
                "modules": [module]
              }),
              headers: {"authorization": "bearer $accessToken"});

      print(matRes);
    } catch (e) {
      print(e);
    } finally {
      notifyListeners();
    }
  }
}
