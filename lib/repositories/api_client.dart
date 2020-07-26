import 'dart:convert';
import 'package:meta/meta.dart';
import 'package:http/http.dart' as http;
import 'package:rickandmortyuniverse/models/models.dart';

class ApiClient {
  static const baseUrl = "https://rickandmortyapi.com/api";
  final http.Client httpClient;

  ApiClient({
    @required this.httpClient
  }) : assert(httpClient != null);

  Future<Character> getCharacterInfo(int id) async {
    final url = "$baseUrl/character/$id";
    final response = await this.httpClient.get(url);
    if (response.statusCode != 200){
      throw Exception("error getting character info");
    }
    final json = jsonDecode(response.body);
    return Character.fromJson(json);
  }

  Future<Map<String, dynamic>> getCharacters(int page) async {
    final url = "$baseUrl/character/?page=$page";
    final response = await this.httpClient.get(url);
    if (response.statusCode != 200){
      return null;
    }
    return jsonDecode(response.body);
  }

  Future<Episode> getEpisodeFromId(int id) async {
    final url = "$baseUrl/episode/$id";
    final response = await this.httpClient.get(url);
    if (response.statusCode != 200){
      throw "Error while getting episode";
    }

    return Episode.fromJson(response.body);
  }

  Future<Episode> getEpisodeFromUrl(String url) async {
    final response = await this.httpClient.get(url);
    if (response.statusCode != 200){
      throw "Error while getting episode";
    }

    return Episode.fromJson(response.body);
  }

}