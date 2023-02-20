import 'package:flutter/material.dart';

class UploadScreen extends StatefulWidget {
  static const String routeName = "upload";
  const UploadScreen({super.key});

  @override
  State<UploadScreen> createState() => _UploadScreenState();
}

class _UploadScreenState extends State<UploadScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Upload Mat"),
      ),
      body: Container(
        
      ),
    );
  }
}
