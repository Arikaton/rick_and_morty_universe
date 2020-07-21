import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:rickandmortyuniverse/bloc/character/bloc.dart';
import 'package:rickandmortyuniverse/widgets/character.dart';
import 'package:rickandmortyuniverse/repositories/character_api_client.dart';
import 'package:rickandmortyuniverse/repositories/character_repository.dart';
import 'package:rickandmortyuniverse/simple_bloc_delegate.dart';
import 'package:http/http.dart' as http;
import 'package:bloc/bloc.dart';

void main() {
 /* Routes.createRoutes();*/
  BlocSupervisor.delegate = SimpleBlocDelegate();

  final CharacterRepository characterRepository = CharacterRepository(
    characterApiClient: CharacterApiClient(
      httpClient: http.Client(),
    )
  );

  runApp(MyApp(characterRepository: characterRepository));
}

class MyApp extends StatelessWidget {
  final CharacterRepository characterRepository;

  MyApp({Key key, @required this.characterRepository}) : assert(characterRepository != null), super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
/*      onGenerateRoute: Routes.sailor.generator(),
      navigatorKey: Routes.sailor.navigatorKey,*/
      home: BlocProvider(
        create: (context) => CharacterBloc(characterRepository: characterRepository),
        child: Character(),
      ),
    );
  }
}
