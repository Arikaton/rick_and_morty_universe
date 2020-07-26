import 'package:equatable/equatable.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class Character extends Equatable{
  final int id;
  final String name;
  final String status;
  final String species;
  final String type;
  final String gender;
  final Map<String, dynamic> origin;
  final Map<String, dynamic> location;
  final String image;
  final List<dynamic> episode;
  final String url;
  final String created;

  const Character({Key key, this.id, this.name, this.status, this.species, this.type, this.gender, this.origin, this.location, this.image, this.episode, this.url, this.created});

  @override
  List<Object> get props => [id, name, status, species, type, gender, origin, location, image, episode, url, created];

  static Character fromJson(dynamic json){
    Map<String, dynamic> origin = json['origin'];
    Map<String, dynamic> location = json['location'];
    List<dynamic> episode = json['episode'];

    return Character(
        id: json['id'],
        name: json['name'],
        status: json['status'],
        species: json['species'],
        type: json['type'],
        gender: json['gender'],
        origin: origin,
        location: location,
        image: json['image'],
        episode: episode,
        url: json['url'],
        created: json['created']
    );
  }

  @override
  String toString() {
    return "id: $id\nname: $name\nstatus: $status\nspecies: $species\ntype: $type\ngender: $gender\norigin: $origin\nlocation: $location\n" +
    "episodes: $episode\ncreated: $created";
  }

}