import 'dart:convert';

import 'package:equatable/equatable.dart';

class Episode extends Equatable{
  final int id;
  final String name;
  final String airDate;
  final String episode;
  final List<dynamic> characters;
  final String url;
  final String created;

  const Episode({this.id, this.name, this.airDate, this.episode, this.characters, this.url, this.created});

  static Episode fromJson(String json){
    Map<String, dynamic> data = jsonDecode(json);
    return Episode(
      id: data['id'],
      name: data['name'],
      airDate: data['air_date'],
      episode: data['episode'],
      characters: data['characters'],
      url: data['url'],
      created: data['created']
    );
  }

  @override
  get props => [id, name, airDate, episode, characters, url, created];

}