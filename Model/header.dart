import 'package:flutter/material.dart';

/* -------------------------------------------------------------------------- */
/*                                   Header                                   */
/* -------------------------------------------------------------------------- */

class Header {
  late final String _id;
  late Card _card = _getCard();

  Header({required String id, Card? card}) {
    _id = id;
    _card = card ?? _card;
  }

  /* ---------------------------- Getters / Setters --------------------------- */

  String get id => _id;
  Card get card => _card;

  /* ---------------------------- Méthodes Privées ---------------------------- */

  /// Retourne la Card par défaut.
  Card _getCard() {
    return Card(
      color: Colors.teal,
      child: ListTile(
        dense: true,
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
        trailing: const Icon(
          Icons.sort,
          color: Colors.white,
          size: 30.0,
        ),
      ),
    );
  }
}
