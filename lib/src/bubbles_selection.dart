import 'package:bubbles_selection/src/bubble.dart';
import 'package:bubbles_selection/src/bubbles_selection_game.dart';
import 'package:flame/game.dart';
import 'package:flutter/material.dart';

class BubbleSelection extends StatefulWidget {
  BubbleSelection({
    Key? key,
    required this.onSelect,
    required this.onRemoved,
    required this.size,
    required this.bubbles,
    required this.selectedBubbles,
    this.backgroundColor = const Color(0xFFFFFFFF),
    this.borderColor = const Color(0x00000000),
  })  : assert(
          bubbles.isNotEmpty && checkForDuplicates(bubbles),
          "There should be atleast one item and every item should have unique value :"
          '\n'
          'Either zero or 2 or more same values were detected',
        ),
        assert(
          checkForDuplicates(selectedBubbles),
          "There should be atleast one item and every item should have unique value :"
          '\n'
          'Either zero or 2 or more same values were detected',
        ),
        assert(size.isFinite, "Size should be finite"),
        super(key: key);

  final Function(Bubble bubble) onSelect;
  final Function(Bubble bubble) onRemoved;
  final Size size;
  final List<Bubble> bubbles;
  final List<Bubble> selectedBubbles;
  final Color backgroundColor;
  final Color borderColor;

  @override
  State<BubbleSelection> createState() => _BubbleSelectionState();
}

class _BubbleSelectionState extends State<BubbleSelection> {
  late BubbleSelectionGame game;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    game = BubbleSelectionGame(
      onSelect: widget.onSelect,
      onRemoved: widget.onRemoved,
      bubbles: widget.bubbles,
      selectedBubbles: widget.selectedBubbles,
      borderColor: widget.borderColor,
    );
  }

  @override
  Widget build(BuildContext context) {
    final background = Container(
      color: widget.backgroundColor,
    );
    return SizedBox(
      height: widget.size.height,
      width: widget.size.width,
      child: GameWidget(
        errorBuilder: (context, error) {
          return Center(child: Text("Error occured: \n $error"));
        },
        loadingBuilder: (context) {
          return background;
        },
        backgroundBuilder: (context) {
          return background;
        },
        game: game,
      ),
    );
  }
}
