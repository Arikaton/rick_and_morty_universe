import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';

@immutable
abstract class CharacterEvent extends Equatable{}

class CharacterRequested extends CharacterEvent{

  @override
  List<Object> get props => [];


}
