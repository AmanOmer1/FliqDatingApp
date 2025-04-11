import 'package:fliq_dating_app/Api/ApiRequest.dart';
import 'package:fliq_dating_app/Screens/ChatScreeen.dart';
import 'package:fliq_dating_app/Screens/OtpVerficatnsScreen.dart';
import 'package:fliq_dating_app/Screens/PhoneNumberScreen.dart';
import 'package:fliq_dating_app/Screens/SpalshScreen.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(theme: ThemeData.dark(), home: Splashscreen());
  }
}
