import 'package:flutter/material.dart';
import 'widgets/appBarOfSearchMusic.dart';
import 'widgets/textFieldAndListViewColumn.dart';

void main() {
  runApp(MaterialApp(
    home: SearchMusic(),
  ));
}

// Global variables
var searchMusicController;
var songsNamesList = [];
var songsArtistsList = [];
var songsLinksList = [];

class SearchMusic extends StatefulWidget {
  @override
  _SearchMusicState createState() => _SearchMusicState();

  onTextChanged(String text) {}
}
class _SearchMusicState extends State<SearchMusic> {
  TextEditingController _searchMusicController = TextEditingController();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    _searchMusicController.addListener(() => widget.onTextChanged != null ? widget.onTextChanged(_searchMusicController.text) : null);
    searchMusicController = _searchMusicController;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: appBarOfSearchMusic,
      body: textFieldAndListViewColumn,
    );

  }
}
