import 'package:flame_forge2d/flame_forge2d.dart';
import 'package:flutter/material.dart';

List<Wall> createBoundaries(Forge2DGame game, Color borderColor) {
  final topLeft = Vector2.zero();
  final bottomRight = game.screenToWorld(game.camera.viewport.effectiveSize);
  final topRight = Vector2(bottomRight.x, topLeft.y);
  final bottomLeft = Vector2(topLeft.x, bottomRight.y);

  return [
    Wall(topLeft, topRight, borderColor),
    Wall(topRight, bottomRight, borderColor),
    Wall(bottomRight, bottomLeft, borderColor),
    Wall(bottomLeft, topLeft, borderColor),
  ];
}

class Wall extends BodyComponent {
  final Vector2 start;
  final Vector2 end;
  final Color borderColor;

  Wall(this.start, this.end, this.borderColor);

  @override
  Body createBody() {
    paint = Paint()..color = borderColor;
    final shape = EdgeShape()..set(start, end);
    final fixtureDef = FixtureDef(shape, friction: 0.3);
    final bodyDef = BodyDef(
      userData: this, // To be able to determine object in collision
      position: Vector2.zero(),
    );

    return world.createBody(bodyDef)..createFixture(fixtureDef);
  }
}
