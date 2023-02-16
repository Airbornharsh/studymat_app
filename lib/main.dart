import 'package:flutter/material.dart';
import "package:provider/provider.dart";
import 'package:studymat_app/providers/Settings.dart';
import 'package:studymat_app/screens/HomeScreen.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider.value(value: Settings()),
      ],
      child: MaterialApp(
        title: 'MTrace',
        theme: ThemeData(
          colorScheme: ColorScheme.fromSwatch().copyWith(
            primary: const Color.fromARGB(255, 0, 190, 184),
          ),
        ),
        // home: const HomeScreen(),
        home: HomeScreen(),
        routes: {},
      ),
    );
  }
}
