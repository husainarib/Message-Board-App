// File generated by FlutterFire CLI.
// ignore_for_file: type=lint
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
        return windows;
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
    apiKey: 'AIzaSyCRna6LY2VNet2pW8dTmVGb4KTIA_b9lqc',
    appId: '1:152324229963:web:958eb7688b9b201af636ce',
    messagingSenderId: '152324229963',
    projectId: 'message-board-app-a1d6d',
    authDomain: 'message-board-app-a1d6d.firebaseapp.com',
    storageBucket: 'message-board-app-a1d6d.firebasestorage.app',
    measurementId: 'G-SCRP9P25M7',
  );

  static const FirebaseOptions android = FirebaseOptions(
    apiKey: 'AIzaSyDxhSJQWc7Ijp2HhrfjV0N4UYttBkf6B2c',
    appId: '1:152324229963:android:eeff213feeb9176af636ce',
    messagingSenderId: '152324229963',
    projectId: 'message-board-app-a1d6d',
    storageBucket: 'message-board-app-a1d6d.firebasestorage.app',
  );

  static const FirebaseOptions ios = FirebaseOptions(
    apiKey: 'AIzaSyAjY8-XOn4y1Vr07TwJNkbBHzfjeEB36tI',
    appId: '1:152324229963:ios:ba2e9d90b0e6fc35f636ce',
    messagingSenderId: '152324229963',
    projectId: 'message-board-app-a1d6d',
    storageBucket: 'message-board-app-a1d6d.firebasestorage.app',
    iosBundleId: 'com.example.messageBoardApp',
  );

  static const FirebaseOptions macos = FirebaseOptions(
    apiKey: 'AIzaSyAjY8-XOn4y1Vr07TwJNkbBHzfjeEB36tI',
    appId: '1:152324229963:ios:ba2e9d90b0e6fc35f636ce',
    messagingSenderId: '152324229963',
    projectId: 'message-board-app-a1d6d',
    storageBucket: 'message-board-app-a1d6d.firebasestorage.app',
    iosBundleId: 'com.example.messageBoardApp',
  );

  static const FirebaseOptions windows = FirebaseOptions(
    apiKey: 'AIzaSyCRna6LY2VNet2pW8dTmVGb4KTIA_b9lqc',
    appId: '1:152324229963:web:db56587c61930bc5f636ce',
    messagingSenderId: '152324229963',
    projectId: 'message-board-app-a1d6d',
    authDomain: 'message-board-app-a1d6d.firebaseapp.com',
    storageBucket: 'message-board-app-a1d6d.firebasestorage.app',
    measurementId: 'G-GK6ZWWWRE1',
  );
}
