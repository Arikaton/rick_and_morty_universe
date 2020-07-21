import 'dart:async';
import 'package:bloc/bloc.dart';
import 'package:flutter/cupertino.dart';
import 'package:rickandmortyuniverse/models/character.dart';
import 'package:rickandmortyuniverse/repositories/character_repository.dart';
import './bloc.dart';

class CharacterBloc extends Bloc<CharacterEvent, CharacterState> {
  final CharacterRepository characterRepository;
  int pressCount = 0;

  CharacterBloc({@required this.characterRepository}) : assert (characterRepository != null);

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
        yield LoadSuccessCharacterState(character: character);
      } catch (_) {
        print(_);
        yield LoadFailureCharacterState();
      }
    }
  }
}
