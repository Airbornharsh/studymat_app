import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:studymat_app/providers/StudyMats.dart';

class HomeScreen extends StatefulWidget {
  HomeScreen({super.key});
  bool start = true;

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    Future onLoad() async {
      final prefs = await SharedPreferences.getInstance();
      // prefs.setString("hopl_backend_uri", "http://localhost:3000");
      prefs.setString("studymat_backend_uri", "http://192.168.1.35:3000");
      // prefs.setString("studymat_backend_uri", "https://studymat.vercel.app");
    }

    onLoad();
  }

  @override
  Widget build(BuildContext context) {
    if (widget.start) {
      Provider.of<StudyMat>(context).loadMat().then(
            (value) {},
          );
      setState(() {
        widget.start = false;
      });
    }

    return Scaffold();
  }
}
