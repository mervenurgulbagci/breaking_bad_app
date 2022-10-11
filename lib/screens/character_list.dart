import 'dart:convert';
import 'package:breaking_bad_app/screens/character_details.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart';
import 'package:breaking_bad_app/models/character.dart';

class CharactersPage extends StatefulWidget {
  const CharactersPage({Key? key}) : super(key: key);

  @override
  State<CharactersPage> createState() => _CharactersPageState();
}

class _CharactersPageState extends State<CharactersPage> {


  List<Character> characterList = [];

  void getCharacter() async{
    Response res= await get(Uri.parse('https://www.breakingbadapi.com/api/characters'));
    var data = await jsonDecode(res.body);
    setState(() {
      for (var i = 0; i < data.length; i++){
        Character c = Character();
        c.id = data[i]['char_id'];
        c.name = data[i]['name'];
        c.img = data[i]['img'];
        characterList.add(c);
      }
    });
  }

  @override
  void initState() {
    super.initState();
    getCharacter();
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Breaking Bad'),
      ),
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            colors: [Theme.of(context).backgroundColor,Theme.of(context).scaffoldBackgroundColor],
            tileMode: TileMode.mirror,
          )
        ),
        child: ListView.builder(
            itemCount: characterList.length,
            itemBuilder: (context,index){
              return GestureDetector(
                onTap: (){
                  Navigator.push(context, MaterialPageRoute(builder: (_)=> CharacterDetailsPage(
                    id: characterList[index].id)));
                },
                child: ListTile(
                  title: Text(characterList[index].name,
                    style: TextStyle(
                      color: Theme.of(context).secondaryHeaderColor,
                        fontSize: 20.0),
                  ),
                  leading: CircleAvatar(
                    backgroundImage: NetworkImage(characterList[index].img),
                  ),
                ),
              );
            }),

      )
    );
  }
}
