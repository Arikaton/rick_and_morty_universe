import 'package:rickandmortyuniverse/models/models.dart';
import 'package:rickandmortyuniverse/repositories/api_client.dart';
import 'package:meta/meta.dart';
import 'dart:async';

class Repository{
  final ApiClient apiClient;

  Repository({@required this.apiClient})
      : assert (apiClient != null);

  Future<Character> getCharacter(int id) async {
    return apiClient.getCharacterInfo(id);
  }

  Future<Map<String, dynamic>> getCharacters(int page) async {
    return apiClient.getCharacters(page);
  }

  Future<String> getEpisodeName({String url, int id}) async {
    Episode episode;
    if (url != null){
      episode = await apiClient.getEpisodeFromUrl(url);
    } else {
      episode = await apiClient.getEpisodeFromId(id);
    }
    return episode.name;
  }
}