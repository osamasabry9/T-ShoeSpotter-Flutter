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
    apiKey: 'AIzaSyDcXq-tIiBC7QO3gqWYTny7VNW3AOHJuLE',
    appId: '1:410563000793:web:84e0f8b8cf4b068dd401c8',
    messagingSenderId: '410563000793',
    projectId: 'tshoe-spotter-flutter-28e87',
    authDomain: 'tshoe-spotter-flutter-28e87.firebaseapp.com',
    storageBucket: 'tshoe-spotter-flutter-28e87.appspot.com',
    measurementId: 'G-993GY57VCD',
  );

  static const FirebaseOptions android = FirebaseOptions(
    apiKey: 'AIzaSyBKC4dMludSfqHc0nXIN6PDpCrcyvEmh34',
    appId: '1:410563000793:android:99f4e8b2383040f9d401c8',
    messagingSenderId: '410563000793',
    projectId: 'tshoe-spotter-flutter-28e87',
    storageBucket: 'tshoe-spotter-flutter-28e87.appspot.com',
  );

  static const FirebaseOptions ios = FirebaseOptions(
    apiKey: 'AIzaSyC7RNKySatvk1Jh0ND9w394jqwv5molg1s',
    appId: '1:410563000793:ios:55678a7b8ab83fe5d401c8',
    messagingSenderId: '410563000793',
    projectId: 'tshoe-spotter-flutter-28e87',
    storageBucket: 'tshoe-spotter-flutter-28e87.appspot.com',
    iosBundleId: 'com.example.shoeSpotter',
  );

}