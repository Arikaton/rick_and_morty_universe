import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:rickandmortyuniverse/bloc/character/bloc.dart';
import 'package:rickandmortyuniverse/widgets/widgets.dart';

class Character extends StatelessWidget{
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<CharacterBloc, CharacterState>(
          builder: (context, state) {
            if (state is InitialCharacterState){
              return Scaffold(
                appBar: AppBar(title: Text("Character")),
                body: Center(child: Text("Press + button")),
                floatingActionButton: FloatingActionButton(
                  onPressed: () => BlocProvider.of<CharacterBloc>(context).add(CharacterRequested()),
                  child: Icon(Icons.add),
                ),
              );
            } else if (state is LoadInProgressCharacterState){
              return Scaffold(
                appBar: AppBar(title: Text("Loading...")),
                body: Center(child: CircularProgressIndicator()),
                floatingActionButton: FloatingActionButton(
                  onPressed: () => BlocProvider.of<CharacterBloc>(context).add(CharacterRequested()),
                  child: Icon(Icons.add),
                ),
              );
            } else if (state is LoadSuccessCharacterState){
              return Scaffold(
                appBar: AppBar(title: Text(state.character.name)),
                body: Center(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center, 
                    children: <Widget>[
                      Image.network(
                        state.character.image,
                      ),
                      Text(state.character.gender),
                      Text(state.character.type),
                      Text(state.character.species),
                      Text(state.character.status)
                    ],
                  ),
                ),
                floatingActionButton: FloatingActionButton(
                  onPressed: () => BlocProvider.of<CharacterBloc>(context).add(CharacterRequested()),
                  child: Icon(Icons.add),
                ),
              );
            } else {
              return Scaffold(
                appBar: AppBar(title: Text("Character")),
                body: Center(child: Text('Something went wrong!', style: TextStyle(color: Colors.red),)),
                floatingActionButton: FloatingActionButton(
                  onPressed: () => BlocProvider.of<CharacterBloc>(context).add(CharacterRequested()),
                  child: Icon(Icons.add),
                ),
              );
            }
          },
        );
  }

}