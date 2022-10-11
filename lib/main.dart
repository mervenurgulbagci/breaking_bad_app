import 'package:flutter/material.dart';
import 'package:breaking_bad_app/screens/character_list.dart';
void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Breaking Bad App',
      theme: ThemeData(
        primarySwatch: Colors.orange,
        scaffoldBackgroundColor: const Color(0xffFFC107),
        //scaffoldBackgroundColor: const Color(0xFF67e6dc),

        secondaryHeaderColor: const  Color(0xff343A40),
      //  secondaryHeaderColor: const Color(0xFF222f3e),
        backgroundColor: const Color(0xffE1E8EB),
      ),
      home: const CharactersPage()
    );
  }
}
