import 'package:flutter/material.dart';
import 'header.dart';

/* -------------------------------------------------------------------------- */
/*                                    Item                                    */
/* -------------------------------------------------------------------------- */

class Item {
  late final String _id;
  late Header _header;
  late Card _card = _getCard();
  late final Function? _behavior;

  Item(
      {required String id,
      required Header header,
      Card? card,
      Function? behavior}) {
    _id = id;
    _header = header;
    _card = card ?? _card;
    _behavior = behavior;
  }

  /* ---------------------------- Getters / Setters --------------------------- */

  String get id => _id;
  Header get header => _header;
  Card get card => _card;
  Function? get behavior => _behavior;

  set setHeader(Header header) => _header = header;

  /* ---------------------------- Méthodes Privées ---------------------------- */

  /// Retourne la Card par défaut.
  Card _getCard() {
    return Card(
      elevation: 8.0,
      margin: const EdgeInsets.symmetric(horizontal: 10.0, vertical: 6.0),
      child: Container(
        decoration: const BoxDecoration(
          color: Color.fromRGBO(64, 75, 96, .9),
        ),
        child: _getListTitle(),
      ),
    );
  }

  /// Retourne la ListTitle par défaut.
  ListTile _getListTitle() {
    return ListTile(
      contentPadding: const EdgeInsets.symmetric(
        horizontal: 20.0,
        vertical: 10.0,
      ),
      title: Text(
        _id,
        style: const TextStyle(
          color: Colors.white,
        ),
      ),
      subtitle: Text("Liste: ${_header.id}"),
      trailing: const Icon(
        Icons.sort,
        color: Colors.white,
        size: 30.0,
      ),
    );
  }
}
