import 'package:flutter/material.dart';
import 'package:todoapp/screens/home.dart';
import 'screens/home.dart';


void main()
{
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Ztodo',
      home: Home(),

    );
  }
}
