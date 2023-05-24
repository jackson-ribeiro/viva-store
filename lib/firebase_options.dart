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
    apiKey: 'AIzaSyDaqu7hhZTssSZSWQdPfFP4j7HOi1uTUM0',
    appId: '1:923001938690:web:500ced825773f95eea981b',
    messagingSenderId: '923001938690',
    projectId: 'vivastore-bb7eb',
    authDomain: 'vivastore-bb7eb.firebaseapp.com',
    storageBucket: 'vivastore-bb7eb.appspot.com',
    measurementId: 'G-6CQRWB4QE8',
  );

  static const FirebaseOptions android = FirebaseOptions(
    apiKey: 'AIzaSyAbsEwdQQCb4qr3ElSqZtMUr_ImCRZ-7nM',
    appId: '1:923001938690:android:8ee56cda0468f67fea981b',
    messagingSenderId: '923001938690',
    projectId: 'vivastore-bb7eb',
    storageBucket: 'vivastore-bb7eb.appspot.com',
  );

  static const FirebaseOptions ios = FirebaseOptions(
    apiKey: 'AIzaSyDRNniE9ZAq4G6YpYg-bCGNgT98QtV1eSQ',
    appId: '1:923001938690:ios:6329233a61226b5bea981b',
    messagingSenderId: '923001938690',
    projectId: 'vivastore-bb7eb',
    storageBucket: 'vivastore-bb7eb.appspot.com',
    iosClientId: '923001938690-qjv1sotuge8pm7ejlbr66bmtgef5f85b.apps.googleusercontent.com',
    iosBundleId: 'com.example.vivaStore',
  );

  static const FirebaseOptions macos = FirebaseOptions(
    apiKey: 'AIzaSyDRNniE9ZAq4G6YpYg-bCGNgT98QtV1eSQ',
    appId: '1:923001938690:ios:6329233a61226b5bea981b',
    messagingSenderId: '923001938690',
    projectId: 'vivastore-bb7eb',
    storageBucket: 'vivastore-bb7eb.appspot.com',
    iosClientId: '923001938690-qjv1sotuge8pm7ejlbr66bmtgef5f85b.apps.googleusercontent.com',
    iosBundleId: 'com.example.vivaStore',
  );
}
