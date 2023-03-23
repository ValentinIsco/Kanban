import 'dart:collection';
import 'package:flutter/material.dart';
import '../Model/header.dart';
import '../Model/item.dart';
import '../Model/board.dart';

part '../View/kanban_state.dart';

/* -------------------------------------------------------------------------- */
/*                              Kanban Controller                             */
/* -------------------------------------------------------------------------- */

class Kanban extends StatefulWidget {
  late final Board _board;
  late double _tileHeight = 100;
  late double _headerHeight = 80;
  late double _tileWidth = 300;

  Kanban(
      {super.key,
      required Board board,
      double? titleHeight,
      double? headerHeight,
      double? titleWidth}) {
    _board = board;
    _tileHeight = titleHeight ?? _tileHeight;
    _headerHeight = headerHeight ?? _headerHeight;
    _tileWidth = titleWidth ?? _tileWidth;
  }

  @override
  KanbanState createState() => KanbanState();
}
