import 'package:rickandmortyuniverse/models/character.dart';
import 'package:rickandmortyuniverse/repositories/character_api_client.dart';
import 'package:meta/meta.dart';
import 'dart:async';

class CharacterRepository{
  final CharacterApiClient characterApiClient;

  CharacterRepository({@required this.characterApiClient})
      : assert (characterApiClient != null);

  Future<Character> getCharacter(int id) async {
    return characterApiClient.getCharacterInfo(id);

  }
}