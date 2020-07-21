import 'dart:convert';
import 'package:meta/meta.dart';
import 'package:http/http.dart' as http;
import 'package:rickandmortyuniverse/models/character.dart';

class CharacterApiClient {
  static const baseUrl = "https://rickandmortyapi.com/api/character/";
  final http.Client httpClient;

  CharacterApiClient({
    @required this.httpClient
  }) : assert(httpClient != null);

  Future<Character> getCharacterInfo(int id) async {
    final url = "$baseUrl$id";
    final response = await this.httpClient.get(url);
    if (response.statusCode != 200){
      throw Exception("error getting character info");
    }

    final json = jsonDecode(response.body);
    return Character.fromJson(json);
  }

}