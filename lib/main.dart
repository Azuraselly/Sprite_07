import 'package:flame/game.dart';
import 'package:flutter/material.dart';
import 'package:sprite_07/component/player_sprite_sheet_component_animation.dart';

class MyGame extends FlameGame {
  @override
  void onLoad() async {
    super.onLoad();
    add(PlayerSpriteSheetComponentAnimation());
  }
}

void main() async {
  runApp(GameWidget(game: MyGame()));
}