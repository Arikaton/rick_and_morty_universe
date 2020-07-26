import 'package:flutter/material.dart';
import 'package:rickandmortyuniverse/models/character.dart';
import 'package:rickandmortyuniverse/repositories/repository.dart';

class CharacterCard extends StatelessWidget{
  final Character character;
  final Repository repository;

  const CharacterCard({Key key, @required this.character, this.repository}) : assert(character != null), super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 5, vertical: 3),
      width: double.infinity,
      height: 140,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(8),
        color: Theme.of(context).backgroundColor
      ),
      child: Row(
        children: <Widget>[
          ClipRRect(
            borderRadius: BorderRadius.circular(8),
            child: Image.network(character.image, height: 140,),
          ),
          Padding(
            padding: EdgeInsets.all(5),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Text(character.name, style: TextStyle(fontWeight: FontWeight.w500, fontSize: 16),),
                Row(
                  children: <Widget>[
                    Icon(Icons.brightness_1, size: 10, color: _mapAliveToColor(character.status),),
                    Text(character.status),
                    Text(" - "),
                    Text(character.species)
                  ],
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 6),
                  child: Text("Last known location:", style: TextStyle(fontWeight: FontWeight.w500, fontStyle: FontStyle.italic),),
                ),
                Text(character.location['name']),
                Padding(
                  padding: const EdgeInsets.only(top: 6),
                  child: Text("First seen in:", style: TextStyle(fontWeight: FontWeight.w500, fontStyle: FontStyle.italic),),
                ),
                FutureBuilder(
                  future: repository?.getEpisodeName(url: character.episode[0].toString()),
                  builder: (context, snapshot){
                    if (snapshot.connectionState == ConnectionState.waiting){
                      return Text("...");
                    } else if (snapshot.connectionState == ConnectionState.done){
                      return SizedBox(child: Text(snapshot.data, maxLines: 2,), width: 220,);
                    } else {
                      return Text("Unknown");
                    }
                  },
                )
              ],
            ),
          )
        ],
      ),
    );
  }

  Color _mapAliveToColor(String alive){
    Color color;
    switch (alive){
      case "Alive":
        color = Colors.green;
        break;
      case "unknown":
        color = Colors.grey;
        break;
      default:
        color = Colors.red;
    }
    return color;
  }

}