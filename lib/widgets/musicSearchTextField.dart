import 'package:flutter/material.dart';
import '../main.dart';
import '../utils/returnBuiltUrl.dart';

var musicSearchTextField = TextField(
  controller: searchMusicController,
  decoration: InputDecoration(
    hintText: 'Іздеу',
    suffix: IconButton(
        icon: Icon(Icons.close),
        onPressed: () {
          // clear query text
          WidgetsBinding.instance.addPostFrameCallback((_) => searchMusicController.clear());
        }
    ),
    contentPadding: EdgeInsets.only(left: 30.0, right: 10.0),
  ),
  cursorColor: Colors.greenAccent,
  onSubmitted: (query) {
    String builtUrl = returnBuildUrl(query).toString();
  },
);