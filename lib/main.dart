import 'package:happy_bite/service/constant.dart';
import 'package:happy_bite/login_screen.dart';
import 'package:flutter/material.dart';
void main ()
{
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        scaffoldBackgroundColor: kBackgroundColor,
        fontFamily: 'Poppins',
      ),
      home:loginScreen(),
    );
  }
}
