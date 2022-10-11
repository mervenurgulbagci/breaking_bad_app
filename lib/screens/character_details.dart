import 'dart:convert';

import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:breaking_bad_app/functions/card.dart';
import 'package:breaking_bad_app/models/character.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:http/http.dart';
import 'package:image_fade/image_fade.dart';

class CharacterDetailsPage extends StatefulWidget {
  final int id;
  const CharacterDetailsPage({super.key, required this.id});


  @override
  State<CharacterDetailsPage> createState() => _CharacterDetailsPageState();
}

class _CharacterDetailsPageState extends State<CharacterDetailsPage> {

  Character c = Character();
  bool loading = false;


  void getCharacter() async{
    Response res = await get(Uri.parse('https://www.breakingbadapi.com/api/characters/${widget.id}'));
    var data = await jsonDecode(res.body);

    setState(() {
      c.name = data[0]['name'];
      c.img = data[0]['img'];
      c.id = data[0]['char_id'];
      c.artist = data[0]['portrayed'];
      c.nickname = data[0]['nickname'];
      c.status = data[0]['status'];
      c.birthday = data[0]['birthday'];
      loading = true;
    });

  }

  @override
  void initState() {
    super.initState();
    getCharacter();
  }

  @override
  Widget build(BuildContext context) {
    return loading == false
        ? const Scaffold(
            body: Center(
              child: SpinKitSpinningLines(color: Colors.black, size: 150.0),
    ))
        : Scaffold(
            appBar: AppBar(
              title: AnimatedTextKit(animatedTexts: [
                TypewriterAnimatedText(c.name,
                  speed: const Duration(milliseconds: 500),
                ),
              ],
              ),
            ),
        body: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.center,
        children:<Widget> [
          Center(
            child: ImageFade(
              image: NetworkImage(c.img),
              height: 350,
              alignment: Alignment.center,
              fit: BoxFit.cover,
            ),
          ),
          SizedBox(
            height: 10.0,
              width: 150.0,
              child: Divider(
                color: Theme.of(context).secondaryHeaderColor,
              ),
          ),
          createCard('Name: ', c.name, context),
          createCard('Nickname: ', c.nickname, context),
          createCard('Artist: ', c.artist, context),
          createCard('Status: ', c.status, context),
          createCard('Birthday: ', c.birthday, context),
        ],
      )
        );
  }
}
