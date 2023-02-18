// File generated by FlutterFire CLI.
// ignore_for_file: lines_longer_than_80_chars, avoid_classes_with_only_static_members
import 'package:firebase_core/firebase_core.dart' show FirebaseOptions;
import 'package:flutter/foundation.dart'
    show defaultTargetPlatform, kIsWeb, TargetPlatform;

/// Default [FirebaseOptions] for use with your Firebase apps.
///
/// Example:
/// ```dart
/// import 'firebase_options.dart';
/// // ...
/// await Firebase.initializeApp(
///   options: DefaultFirebaseOptions.currentPlatform,
/// );
/// ```
class DefaultFirebaseOptions {
  static FirebaseOptions get currentPlatform {
    if (kIsWeb) {
      return web;
    }
    switch (defaultTargetPlatform) {
      case TargetPlatform.android:
        return android;
      case TargetPlatform.iOS:
        return ios;
      case TargetPlatform.macOS:
        return macos;
      case TargetPlatform.windows:
        throw UnsupportedError(
          'DefaultFirebaseOptions have not been configured for windows - '
          'you can reconfigure this by running the FlutterFire CLI again.',
        );
      case TargetPlatform.linux:
        throw UnsupportedError(
          'DefaultFirebaseOptions have not been configured for linux - '
          'you can reconfigure this by running the FlutterFire CLI again.',
        );
      default:
        throw UnsupportedError(
          'DefaultFirebaseOptions are not supported for this platform.',
        );
    }
  }

  static const FirebaseOptions web = FirebaseOptions(
    apiKey: 'AIzaSyBXR9Kx1iuwUfABoZ7Dv5X0a11jyl_Pu_c',
    appId: '1:1020867390794:web:4a07b847e6a5599a9b65b3',
    messagingSenderId: '1020867390794',
    projectId: 'studymat-1',
    authDomain: 'studymat-1.firebaseapp.com',
    storageBucket: 'studymat-1.appspot.com',
  );

  static const FirebaseOptions android = FirebaseOptions(
    apiKey: 'AIzaSyByv4VQg3JHi_e28XXAy1Ny7rb8YQl1YBM',
    appId: '1:1020867390794:android:d168a84aa6bd0cfe9b65b3',
    messagingSenderId: '1020867390794',
    projectId: 'studymat-1',
    storageBucket: 'studymat-1.appspot.com',
  );

  static const FirebaseOptions ios = FirebaseOptions(
    apiKey: 'AIzaSyBzeYoB00aaDbMeNj_ShiwRKsQa5rBLkTg',
    appId: '1:1020867390794:ios:6c9f3932bff15beb9b65b3',
    messagingSenderId: '1020867390794',
    projectId: 'studymat-1',
    storageBucket: 'studymat-1.appspot.com',
    iosClientId: '1020867390794-tklmhl7mjjfanmk9ed00j1m4875pkj8s.apps.googleusercontent.com',
    iosBundleId: 'com.airbornharsh.studymatApp',
  );

  static const FirebaseOptions macos = FirebaseOptions(
    apiKey: 'AIzaSyBzeYoB00aaDbMeNj_ShiwRKsQa5rBLkTg',
    appId: '1:1020867390794:ios:6c9f3932bff15beb9b65b3',
    messagingSenderId: '1020867390794',
    projectId: 'studymat-1',
    storageBucket: 'studymat-1.appspot.com',
    iosClientId: '1020867390794-tklmhl7mjjfanmk9ed00j1m4875pkj8s.apps.googleusercontent.com',
    iosBundleId: 'com.airbornharsh.studymatApp',
  );
}