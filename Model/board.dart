import 'dart:collection';
import 'header.dart';
import 'item.dart';

/* -------------------------------------------------------------------------- */
/*                                    Board                                   */
/* -------------------------------------------------------------------------- */

class Board {
  final LinkedHashMap<String, List<Item>> _board = LinkedHashMap();
  late final Map<String, Header> _headers;
  late final List<Item> _items;

  Board({required List<Header> headers, required List<Item> items}) {
    _headers = _generateHeaders(headers);
    _items = items;
    _generateBoard();
  }

  /* ---------------------------- Getters / Setters --------------------------- */

  LinkedHashMap<String, List<Item>> get board => _board;
  Map<String, Header> get headers => _headers;

  /* ---------------------------- Méthodes Privées ---------------------------- */

  /// Créer le Board.
  void _generateBoard() {
    _headers.forEach((String key, Header value) {
      _board.addAll({value.id: []});
    });
    for (Item item in _items) {
      if (_board.containsKey(item.header.id)) {
        List<Item> items = _board[item.header.id]!;
        items.add(item);
        _board.update(item.header.id, (value) => value);
      }
    }
  }

  /// Retourne une Map de Headers.
  Map<String, Header> _generateHeaders(List<Header> headers) {
    Map<String, Header> headersMap = {};
    for (Header header in headers) {
      headersMap.addAll({header.id: header});
    }
    return headersMap;
  }
}
