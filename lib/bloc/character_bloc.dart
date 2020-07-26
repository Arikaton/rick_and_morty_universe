import 'dart:async';
import 'package:bloc/bloc.dart';
import 'package:flutter/cupertino.dart';
import 'package:rickandmortyuniverse/models/character.dart';
import 'package:rickandmortyuniverse/repositories/repository.dart';
import 'package:rickandmortyuniverse/bloc/bloc.dart';

class CharacterBloc extends Bloc<CharacterEvent, CharacterState> {
  final Repository characterRepository;
  int pressCount = 0;

  CharacterBloc({@required this.characterRepository}) : assert (characterRepository != null), super(InitialCharacterState());

  @override
  CharacterState get initialState => InitialCharacterState();

  @override
  Stream<CharacterState> mapEventToState(
    CharacterEvent event,
  ) async* {
    if (event is CharacterRequested){
      pressCount++;
      yield LoadInProgressCharacterState();
      try {
        final Character character = await characterRepository.getCharacter(pressCount);
        print(character.toString());
        yield LoadSuccessCharacterState(character: character);
      } catch (_) {
        print(_);
        yield LoadFailureCharacterState();
      }
    }
  }
}
