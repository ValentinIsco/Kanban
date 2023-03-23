part of '../Controller/kanban_controller.dart';

/* -------------------------------------------------------------------------- */
/*                                Kanban State                                */
/* -------------------------------------------------------------------------- */

class KanbanState extends State<Kanban> {
  late final LinkedHashMap<String, List<Item>> _board;
  late final Map<String, Header> _headers;
  late final double _tileHeight;
  late final double _headerHeight;
  late final double _tileWidth;

  @override
  void initState() {
    _board = widget._board.board;
    _headers = widget._board.headers;
    _tileHeight = widget._tileHeight;
    _headerHeight = widget._headerHeight;
    _tileWidth = widget._tileWidth;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: _board.keys.map((String key) {
          return SizedBox(
            width: _tileWidth,
            child: _buildKanbanList(key, _board[key]!),
          );
        }).toList());
  }

  /* ---------------------------- Méthodes Privées ---------------------------- */

  /// Construit la liste Kanban.
  SingleChildScrollView _buildKanbanList(String listId, List<Item> items) {
    return SingleChildScrollView(
      scrollDirection: Axis.vertical,
      child: Column(
        children: [
          _buildHeader(listId),
          ListView.builder(
            scrollDirection: Axis.vertical,
            shrinkWrap: true,
            itemCount: items.length,
            itemBuilder: (BuildContext context, int index) {
              return Stack(
                children: [
                  Draggable<Item>(
                    data: items[index],
                    childWhenDragging: Opacity(
                      opacity: 0.2,
                      child: items[index].card,
                    ),
                    feedback: SizedBox(
                      height: _tileHeight,
                      width: _tileWidth,
                      child: items[index].card,
                    ),
                    child: items[index].card,
                  ),
                  _buildItemDragTarget(listId, index, _tileHeight),
                ],
              );
            },
          ),
        ],
      ),
    );
  }

  /// Créer un header.
  Stack _buildHeader(String listId) {
    Widget header = SizedBox(
      height: _headerHeight,
      child: _headers[listId]!.card,
    );
    return Stack(
      children: [
        Draggable<String>(
          data: listId,
          childWhenDragging: Opacity(
            opacity: 0.2,
            child: header,
          ),
          feedback: SizedBox(
            width: _tileWidth,
            child: header,
          ),
          child: header,
        ),
        _buildItemDragTarget(listId, 0, _headerHeight),
        DragTarget<String>(
          onWillAccept: (String? incomingListId) {
            return listId != incomingListId;
          },
          onAccept: (String incomingListId) {
            setState(
              () {
                LinkedHashMap<String, List<Item>> reorderedBoard =
                    LinkedHashMap();
                for (String key in _board.keys) {
                  if (key == incomingListId) {
                    reorderedBoard[listId] = _board[listId]!;
                  } else if (key == listId) {
                    reorderedBoard[incomingListId] = _board[incomingListId]!;
                  } else {
                    reorderedBoard[key] = _board[key]!;
                  }
                }
                _board = reorderedBoard;
              },
            );
          },
          builder: (BuildContext context, List<String?> data,
              List<dynamic> rejectedData) {
            if (data.isEmpty) {
              return SizedBox(
                height: _headerHeight,
                width: _tileWidth,
              );
            } else {
              return Container(
                decoration: BoxDecoration(
                  border: Border.all(
                    width: 3,
                    color: Colors.blueAccent,
                  ),
                ),
                height: _headerHeight,
                width: _tileWidth,
              );
            }
          },
        )
      ],
    );
  }

  /// Créer un Item.
  DragTarget _buildItemDragTarget(
      String listId, int targetPosition, double height) {
    return DragTarget<Item>(
      onWillAccept: (Item? data) {
        return _board[listId]!.isEmpty ||
            data?.id != _board[listId]?[targetPosition].id;
      },
      onAccept: (Item data) {
        setState(() {
          if (data.behavior != null) {
            data.behavior!();
          }
          _board[data.header.id]?.remove(data);
          data.setHeader = Header(id: listId);
          if (_board[listId]!.length > targetPosition) {
            _board[listId]?.insert(targetPosition + 1, data);
          } else {
            _board[listId]?.add(data);
          }
        });
      },
      builder:
          (BuildContext context, List<Item?> data, List<dynamic> rejectedData) {
        if (data.isEmpty) {
          return Container(
            height: height,
          );
        } else {
          return Column(
            children: [
              Container(
                height: height,
              ),
              ...data.map((Item? item) {
                return Opacity(
                  opacity: 0.5,
                  child: item!.card,
                );
              }).toList()
            ],
          );
        }
      },
    );
  }
}
