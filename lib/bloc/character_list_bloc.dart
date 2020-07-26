import 'package:http/http.dart' as http;
import 'package:meta/meta.dart';
import 'package:bloc/bloc.dart';
import 'package:rickandmortyuniverse/bloc/bloc.dart';
import 'package:rickandmortyuniverse/repositories/repository.dart';
import 'package:rickandmortyuniverse/models/models.dart';

class CharacterListBloc extends Bloc<CharacterListEvent, CharacterListState>{
  final Repository repository;
  int page = 0;

  CharacterListBloc({@required this.repository}) : assert(repository != null), super(CharacterListInitial());

  @override
  Stream<CharacterListState> mapEventToState(CharacterListEvent event) async* {
    final currentState = state;
    if (event is CharacterListFetched && !_hasReachedMax(state)) {
      try {
        if (currentState is CharacterListInitial) {
          final characters = await _fetchCharacters();
          yield CharacterListSuccess(characters: characters, hasReachedMax: false);
        } else if (currentState is CharacterListSuccess) {
          final characters = await _fetchCharacters();
          if (characters == null) {
            yield currentState.copyWith(hasReachedMax: true);
          } else {
            yield currentState.copyWith(characters: currentState.characters + characters, hasReachedMax: false);
          }
        }
      } catch (_) {
        yield CharacterListFailure();
      }
    }
  }

  bool _hasReachedMax(CharacterListState state){
    return state is CharacterListSuccess && state.hasReachedMax;
  }

  Future<List<Character>> _fetchCharacters() async {
    this.page += 1;
    final charactersData = await repository.getCharacters(page);
    if (charactersData == null){
      return null;
    }
    final characters = charactersData['results'] as List;
    return characters.map((e) => Character.fromJson(e)).toList();
  }

}