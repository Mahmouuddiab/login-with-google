import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'core/di/di.dart';
import 'features/google auth/presentation/screens/auth_page.dart';
import 'firebase_options.dart';

void main() async{
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  configureDependencies();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Google Auth',
      debugShowCheckedModeBanner: false,
      home: AuthPage(),
    );
  }
}

