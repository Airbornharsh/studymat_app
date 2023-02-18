import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import "package:provider/provider.dart";
import 'package:studymat_app/firebase_options.dart';
import 'package:studymat_app/providers/Settings.dart';
import 'package:studymat_app/providers/StudyMats.dart';
import 'package:studymat_app/screens/HomeScreen.dart';
import 'package:studymat_app/screens/InstitutionScreen.dart';
import 'package:studymat_app/screens/PdfViewerPage.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);

  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  // This widget is the root of your application
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider.value(value: Settings()),
        ChangeNotifierProvider.value(value: StudyMat()),
      ],
      child: MaterialApp(
        title: 'MTrace',
        theme: ThemeData(
          colorScheme: ColorScheme.fromSwatch().copyWith(
            primary: const Color.fromARGB(255, 0, 190, 184),
          ),
        ),
        home: HomeScreen(),
        routes: {
          InstitutionScreen.routeName: (context) => InstitutionScreen(),
          PdfViewerPage.routeName: (context) =>  PdfViewerPage()
        },
      ),
    );
  }
}
