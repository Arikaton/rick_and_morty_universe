import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:rickandmortyuniverse/bloc/bloc.dart';
import 'package:rickandmortyuniverse/repositories/api_client.dart';
import 'package:rickandmortyuniverse/repositories/repository.dart';
import 'package:rickandmortyuniverse/simple_bloc_observer.dart';
import 'package:http/http.dart' as http;
import 'package:rickandmortyuniverse/widgets/character_list.dart';

void main() {
   Bloc.observer = SimpleBlocObserver();

  final Repository repository = Repository(
    apiClient: ApiClient(
      httpClient: http.Client(),
    )
  );

  runApp(MyApp(repository: repository));
}

class MyApp extends StatelessWidget {
  final Repository repository;

  MyApp({Key key, @required this.repository}) : assert(repository != null), super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData.dark(),
      home: BlocProvider(
        create: (context) => CharacterListBloc(repository: repository)..add(CharacterListFetched()),
        child: CharacterList(repository: repository,)
      )
    );
  }
}
