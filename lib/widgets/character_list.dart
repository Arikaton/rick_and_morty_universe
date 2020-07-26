import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:rickandmortyuniverse/bloc/bloc.dart';
import 'package:rickandmortyuniverse/repositories/repository.dart';
import 'package:rickandmortyuniverse/widgets/widgets.dart' as widgets;

class CharacterList extends StatefulWidget{
  final Repository repository;

  const CharacterList({Key key, this.repository}) : super(key: key);

  _CharacterListState createState() => _CharacterListState();
}

class _CharacterListState extends State<CharacterList>{
  final scrollController = ScrollController();
  final double scrollThreshold = 100.0;
  CharacterListBloc listBloc;

  @override
  void initState() {
    listBloc = BlocProvider.of<CharacterListBloc>(context);
    scrollController.addListener(_onScroll);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Characters"),),
      body: BlocBuilder<CharacterListBloc, CharacterListState> (
        builder: (context, state) {
          if (state is CharacterListInitial){
            return Center(
              child: CircularProgressIndicator(),
            );
          } else if (state is CharacterListSuccess){
            return ListView.builder(
              controller: scrollController,
              itemCount: state.hasReachedMax ? state.characters.length : state.characters.length + 1,
              itemBuilder: (context, index){
                return index >= state.characters.length ? BottomLoader() : widgets.CharacterCard(character: state.characters[index], repository: widget.repository,);
              },
            );
          } else {
            return Center(
              child:  Text("Something went wrong", style: TextStyle(color: Colors.red)),
            );
          }
        },
      ),
    );
  }

  @override
  void dispose() {
    scrollController.dispose();
    super.dispose();
  }

  void _onScroll() {
    final maxScroll = scrollController.position.maxScrollExtent;
    final currentScroll = scrollController.position.pixels;
    if (maxScroll - currentScroll <= scrollThreshold) {
      listBloc.add(CharacterListFetched());
    }
  }
}

class BottomLoader extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      alignment: Alignment.center,
      child: Center(
        child: SizedBox(
          width: 33,
          height: 33,
          child: CircularProgressIndicator(
            strokeWidth: 1.5,
          ),
        ),
      ),
    );
  }
}