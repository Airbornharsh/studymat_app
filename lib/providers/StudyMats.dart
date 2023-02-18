import 'dart:convert';
import 'dart:io';

import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:studymat_app/Utils/StudyMats/loadMat.dart';

class Institution {
  String id;
  String name;
  String photoLink;
  int pdfs;
  int videos;
  int playlists;

  Institution(
      {required this.id,
      required this.name,
      required this.photoLink,
      required this.pdfs,
      required this.playlists,
      required this.videos});
}

class Mat {
  String name;
  String institutionId;
  String link;
  String type;
  // List<String> courses;
  // List<String> branches;
  // List<String> years;
  // List<String> subjects;
  // List<String> modules;

  Mat({
    required this.type,
    required this.name,
    required this.institutionId,
    required this.link,
    // required this.courses,
    // required this.branches,
    // required this.years,
    // required this.subjects,
    // required this.modules,
  });
}

class StudyMat with ChangeNotifier {
  // List<Institution> _institutions = [];
  List<Institution> _institutions = [];
  Map<dynamic, dynamic> _institution = {};

  List<Institution> get getInstitutions {
    return _institutions;
  }

  int get getInstitutionsLength {
    return _institutions.length;
  }

  Map<dynamic, dynamic> getInstitution(String institutionId) {
    if (_institution.containsKey(institutionId)) {
      return _institution[institutionId];
    } else {
      return {};
    }
  }

  Future listInstitutes(String name) async {
    var client = Client();
    final prefs = await SharedPreferences.getInstance();
    String domainUri = prefs.getString("studymat_backend_uri") as String;
    try {
      var institutionRes = await client.post(
        Uri.parse("$domainUri/api/unsigned/institution/list?page=1&limit=20"),
        body: json.encode({"name": name}),
      );

      final parsedInstitutionBody = json.decode(institutionRes.body);
      _institutions.clear();

      print(parsedInstitutionBody);

      parsedInstitutionBody.forEach((institution) {
        _institutions.add(Institution(
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

  Future<bool> pdfCreate(
    String isFile,
    File file,
    String fileName,
    String destination,
    String institutionId,
    String name,
    String courses,
    String branches,
    String years,
    String subjects,
    String modules,
  ) async {
    var client = Client();
    final prefs = await SharedPreferences.getInstance();
    String domainUri = prefs.getString("studymat_backend_uri") as String;
    try {
      final fileUrl =
          isFile == "pdf" ? await fileUpload(file, destination) : "";

      print(fileUrl);

      if (fileUrl == "") {
        return false;
      }

      // final accessToken = prefs.getString("studymat_accessToken") as String;

      // var postRes =
      //     await client.post(Uri.parse("$domainUri/api/signed/pdf/create"),
      //         body: json.encode({
      //           "link": fileUrl,
      //           "institutionId": institutionId,
      //           "name": name,
      //           "courses": courses,
      //           "branches": branches,
      //           "years": years,
      //           "subjects": subjects,
      //           "modules": modules
      //         }),
      //         headers: {"authorization": "Bearer $accessToken"});

      // if (postRes.statusCode != 200) {
      //   throw postRes.body;
      // }

      // var postResBody = json.decode(postRes.body);

      return true;
    } catch (e) {
      print(e);
      return false;
    } finally {
      notifyListeners();
    }
  }

  Future<String> fileUpload(File file, String destination) async {
    try {
      final ref = FirebaseStorage.instance.ref(destination);

      final task = await ref.putFile(file);

      if (task == null) return "";

      final fileUrl = await task.ref.getDownloadURL();

      return fileUrl;
    } catch (e) {
      print(e);
      return "";
    } finally {}
  }
}
