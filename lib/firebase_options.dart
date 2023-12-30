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
        throw UnsupportedError(
          'DefaultFirebaseOptions have not been configured for macos - '
          'you can reconfigure this by running the FlutterFire CLI again.',
        );
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
    apiKey: 'AIzaSyDmVXvqqtJ_Dje66MnuHlJaLkqxdNPPKp4',
    appId: '1:854919698924:web:aac5ac27c52de2981ac8c9',
    messagingSenderId: '854919698924',
    projectId: 'free-to-game-tutorial',
    authDomain: 'free-to-game-tutorial.firebaseapp.com',
    storageBucket: 'free-to-game-tutorial.appspot.com',
    measurementId: 'G-4YNGQ065BM',
  );

  static const FirebaseOptions android = FirebaseOptions(
    apiKey: 'AIzaSyAN2j1xmXADQDXvkekTHY13FzhlAzYZl8Y',
    appId: '1:854919698924:android:0b0907612bd52ba11ac8c9',
    messagingSenderId: '854919698924',
    projectId: 'free-to-game-tutorial',
    storageBucket: 'free-to-game-tutorial.appspot.com',
  );

  static const FirebaseOptions ios = FirebaseOptions(
    apiKey: 'AIzaSyA3-mS_VK00JzkMDdfgwFm_3qun811znB4',
    appId: '1:854919698924:ios:8cb68f6285e875631ac8c9',
    messagingSenderId: '854919698924',
    projectId: 'free-to-game-tutorial',
    storageBucket: 'free-to-game-tutorial.appspot.com',
    iosBundleId: 'com.example.freeToGame',
  );
}
