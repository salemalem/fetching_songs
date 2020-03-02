import 'package:flutter/material.dart';
import 'widgets/appBarOfSearchMusic.dart';

import 'utils/returnBuiltUrl.dart';
import 'utils/fetchSongs.dart';


void main() {
  runApp(MaterialApp(
    home: SearchMusic(),
  ));
}


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
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: appBarOfSearchMusic,
      body: Column(
        children: <Widget>[
          TextField(
            controller: _searchMusicController,
            decoration: InputDecoration(
              hintText: 'Іздеу',
              suffix: IconButton(
                  icon: Icon(Icons.close),
                  onPressed: () {
                    // clear query text
                    WidgetsBinding.instance.addPostFrameCallback((_) => _searchMusicController.clear());
                  }
              ),
              contentPadding: EdgeInsets.only(left: 30.0, right: 10.0),
            ),
            cursorColor: Colors.greenAccent,
            onSubmitted: (query) {
              String builtUrl = returnBuildUrl(query).toString();
                  fetchSongs(builtUrl).then((val) => setState(() {
                    if (val[1].length > 0) {
                      songsNamesList = val[1];
                      songsArtistsList = val[2];
                      songsLinksList = val[4];
                    } else {
                      songsNamesList = ['Іздегеніңіз Табылмады'];
                      songsArtistsList = ['Басқаша іздеп көріңіз'];
                      songsLinksList = [];
                    }
                  }));
              //      songsNamesList = val[1];
              //      songsArtistsList = val[2];
              //      songsLinksList = val[4];
            },
          ),
          Expanded(
            child: ListView.builder(
              itemBuilder: (context, index) {
                return ListTile(
                  title: Text(songsNamesList[index]),
                  subtitle: Text(songsArtistsList[index]),
                  trailing: IconButton(
                    icon: Icon(Icons.file_download),
                    onPressed: () {
                      // download pressed

                    },
                  ),
                  onTap: () {

                  },
                );
              },
              itemCount: songsNamesList.length,
            ),
          ),
        ],
      ),
    );
  }
}
