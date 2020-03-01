import 'package:flutter/material.dart';
import 'musicSearchTextField.dart';
import 'fetchedSongsListView.dart';

var textFieldAndListViewColumn = Column(
  children: <Widget>[
    musicSearchTextField,
    fetchedSongsListView,
  ],
);