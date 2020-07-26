import 'package:equatable/equatable.dart';
import 'package:rickandmortyuniverse/models/character.dart';

class CharacterListState extends Equatable{
  const CharacterListState();

  @override
  List<Object> get props => [];
}

class CharacterListInitial extends CharacterListState{}

class CharacterListFailure extends CharacterListState{}

class CharacterListSuccess extends CharacterListState{
  final List<Character> characters;
  final bool hasReachedMax;

  CharacterListSuccess({this.characters, this.hasReachedMax});

  CharacterListSuccess copyWith({List<Character> characters, bool hasReachedMax}){
    return CharacterListSuccess(characters: characters ?? this.characters, hasReachedMax: hasReachedMax ?? this.hasReachedMax);
  }

  @override List<Object> get props => [characters, hasReachedMax];
}

