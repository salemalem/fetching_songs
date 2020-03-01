import 'package:flutter/material.dart';
import 'utils/convertToHexColor.dart';
import 'widgets/appBarOfSearchMusic.dart';
import 'widgets/textFieldAndListViewColumn.dart';

void main() {
  runApp(MaterialApp(
    home: SearchMusic(),
  ));
}

class SearchMusic extends StatefulWidget {
  @override
  _SearchMusicState createState() => _SearchMusicState();
}
class _SearchMusicState extends State<SearchMusic> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: appBarOfSearchMusic,
      body: textFieldAndListViewColumn,
    );

  }
}
