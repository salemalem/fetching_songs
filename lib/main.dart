import 'dart:io';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

import 'package:path_provider/path_provider.dart';
import 'package:dio/dio.dart';

import 'utils/returnBuiltUrl.dart';
import 'utils/fetchSongs.dart';
import 'package:http/http.dart' as http;

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
  bool downloading = false;
  var progressString = "";


  Future<dynamic> downloadFile(String url, filename) async {
//      String dir = (await getApplicationDocumentsDirectory()).path;
    File file = new File(filename);
    var request = await http.get(url,);
    var bytes = await request.bodyBytes;//close();
    await file.writeAsBytes(bytes);
    print(file.path);
  }

  @override
  Future<void> initState() {
    // TODO: implement initState
    super.initState();

    _searchMusicController.addListener(() => widget.onTextChanged != null ? widget.onTextChanged(_searchMusicController.text) : null);
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'WidgetX Музыка Ойнатқышы',
        ),
        backgroundColor: Colors.green,
      ),
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
                      songsLinksList = [''];
                    }
                  }));
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
                    onPressed: () async {
                      // download pressed
                      String filename = songsNamesList[index] + " - " + songsArtistsList[index];
//                      downloadMp3FromUrl(songsLinksList[index], filename);
                      var dir = await getExternalStorageDirectory();
                      filename = dir.path + "/" + filename + ".mp3";
                        downloadFile(songsLinksList[index], filename);
                    },
                  ),
                  onTap: () {

                  },
                );
              },
              itemCount: songsNamesList.length,
            ),
          ),
          downloading ? Container(
            child: Card(
              color: Colors.white,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  CircularProgressIndicator(),
                  Text(
                    "Жазылуда: $progressString",
                    style: TextStyle(
                      color: Colors.black,
                    ),
                  )
                ],
              ),
            ),
            color: Colors.white,
          )
          :
          Container(),
        ],
      ),
    );
  }
}
