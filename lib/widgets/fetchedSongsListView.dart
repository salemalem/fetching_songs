import 'package:flutter/material.dart';
import '../main.dart';

var fetchedSongsListView = Expanded(
  child: ListView.builder(itemBuilder: (context, index) {
    return ListTile(
      title: Text(songsNamesList[index]),
      subtitle: Text(songsArtistsList[index]),
      trailing: IconButton(
        icon: Icon(Icons.file_download),
        onPressed: () {
          // on pressed statement
        },
      ),
      onTap: () {

      },
    );
  },
  itemCount: songsNamesList.length,
  ),
);