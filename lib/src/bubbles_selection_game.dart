import 'dart:developer';
import 'dart:math' as math;
import 'dart:ui';

import 'package:bubbles_selection/src/boundaries.dart';
import 'package:bubbles_selection/src/bubble.dart';
import 'package:collection/collection.dart';
import 'package:flame/components.dart' as components;
import 'package:flame/components.dart';
import 'package:flame/events.dart';
import 'package:flame/game.dart';
import 'package:flame_forge2d/flame_forge2d.dart';
import 'package:flutter/gestures.dart' as gestures;

bool checkForDuplicates(List<Bubble> bubbles) {
  List<Bubble> filteredList = [];
  for (Bubble bubble in bubbles) {
    final isPresent =
        filteredList.firstWhereOrNull((item) => item.text == bubble.text) !=
            null;

    if (!isPresent) {
      filteredList.add(bubble);
    } else {
      return false;
    }
  }
  return true;
}

class BubbleSelectionGame extends Forge2DGame with HasTappables, HasDraggables {
  BubbleSelectionGame({
    required this.onSelect,
    required this.onRemoved,
    required this.bubbles,
    required this.selectedBubbles,
    required this.borderColor,
  }) : super();

  final void Function(Bubble bubble) onSelect;
  final void Function(Bubble bubble) onRemoved;
  final List<Bubble> bubbles;
  final List<Bubble> selectedBubbles;
  final Color borderColor;
  @override
  @override
  Future<void>? onLoad() {
    world.setGravity(Vector2(0, -0.1));
    // TODO: implement onLoad
    final boundaries = createBoundaries(this, borderColor);

    boundaries.forEach(add);
    final bubbleConcrete = bubbles
        .map((bubble) => BubbleBody(
              bubble: bubble,
            ))
        .toList();
    addAll(bubbleConcrete);
    return super.onLoad();
  }
}

class BubbleBody extends BodyComponent<BubbleSelectionGame>
    with Tappable, components.Draggable {
  late double textWidth;
  final Bubble bubble;
  late double textHeight;
  late Vector2 position;
  BubbleBody({
    required this.bubble,
  });

  @override
  Future<void> onLoad() {
    // TODO: implement onLoad

    position = Vector2(
      math.Random().nextInt(gameRef.size.x.toInt()).toDouble(),
      math.Random().nextInt(gameRef.size.y.toInt()).toDouble(),
    );
    final textPaint = TextPaint(
      style: bubble.textStyle,
    );

    // final textRenderer = TextRenderer.createDefault();
    // final textElement =
    //     (textRenderer as FormatterTextRenderer).formatter.format(bubble.label);
    // final measurements = textElement.lastLine.metrics;
    // final scale = Vector2.all(
    //   lerpDouble(0, 0.1, bubble.scale)!,
    // );

    textWidth = textPaint.measureTextWidth(bubble.text);
    textHeight = textPaint.measureTextHeight(bubble.text);
    // final originalTextWidth = textPaint.measureTextWidth(bubble.text) * 0.1;
    // final originalTextHeight = textPaint.measureTextHeight(bubble.text) * 0.1;
    // originalTextPaint = textPaint.measureTextHeight(bubble.text) * scale.y;

    //math.Random().nextInt(8).toDouble().clamp(4, 6);
    final scaledTextSize = Vector2(
          textWidth,
          textHeight,
        ) *
        0.1;
    addAll([
      TextComponent(
          text: bubble.text,
          textRenderer: textPaint,
          scale: Vector2.all(0.1),
          // size: textSize,
          position: -scaledTextSize / 2
          // Vector2(
          //   //    (label.length.toDouble() / 2) +
          //   (textSize.x / 2),
          //   //(textWidth / 2) * scale.x + (label.length) / 2,
          //   textSize.y / 2,
          // ),
          )
    ]);
    return super.onLoad();
  }

  @override
  Body createBody() {
    final scale = Vector2.all(
      lerpDouble(0, 0.1, bubble.scale)!,
    );
    final circleScale = textWidth * scale.x;
    final bodySize = circleScale / 1.5 + 1;
    final fixture = FixtureDef(
      CircleShape()..radius = bodySize.toDouble(),
      restitution: 0.5,
    );
    final isSelected = gameRef.selectedBubbles.contains(bubble);
    paint.color = isSelected ? bubble.activeColor : bubble.inactiveColor;

    final body = BodyDef(
      type: BodyType.dynamic,
      position: position,
    );

    return world.createBody(body)..createFixture(fixture);
  }

  @override
  void update(double dt) {
    // TODO: implement update
    final direction = math.Random().nextBool() ? 1 : -1;
    body.applyLinearImpulse(
      Vector2(
        direction * math.Random().nextDouble() * 0.01,
        direction * math.Random().nextDouble() * 0.005,
      ),
    );
    position = body.position;
    super.update(dt);
  }

  @override
  bool onTapUp(TapUpInfo info) {
    final items =
        gameRef.bubbles.where((item) => item.text == bubble.text).toList();

    if (items.isEmpty) {
      throw Exception("No such item for given value found.");
    }

    if (items.length > 1) {
      throw Exception(
          "All items should have unique values :\n More than one item for given value found.");
    }

    final isSelected = gameRef.selectedBubbles.contains(items[0]);

    if (!isSelected) {
      paint.color = bubble.activeColor;
      gameRef.onSelect(items[0]);
    } else {
      paint.color = bubble.inactiveColor;
      gameRef.onRemoved(items[0]);
    }
    return true;
  }

  @override
  bool onDragUpdate(DragUpdateInfo info) {
    log(info.delta.game.toString());

    // final dragVector = info.delta.game;
    final pointerVelocity = gestures.Velocity(
      pixelsPerSecond: info.delta.game.toOffset(),
    );

    body.applyLinearImpulse(
      Vector2(
        pointerVelocity.pixelsPerSecond.dx,
        pointerVelocity.pixelsPerSecond.dy,
      ), // dragVector * 1.5,
    );
    return super.onDragUpdate(info);
  }

  @override
  bool onDragEnd(DragEndInfo info) {
    // TODO: implement onDragEnd
    body.linearVelocity = info.velocity;
    return super.onDragEnd(info);
  }
}
