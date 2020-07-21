import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';
import 'package:rickandmortyuniverse/models/character.dart';

@immutable
abstract class CharacterState extends Equatable{
  const CharacterState();

  @override
  List<Object> get props => [];
}

class InitialCharacterState extends CharacterState {}

class LoadInProgressCharacterState extends CharacterState {}

class LoadSuccessCharacterState extends CharacterState{
  final Character character;

  LoadSuccessCharacterState({@required this.character}) : assert(character != null);

  @override
  List<Object> get props => [character];
}

class LoadFailureCharacterState extends CharacterState {}
