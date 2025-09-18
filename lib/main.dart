import 'package:flame/game.dart';
import 'package:flame/events.dart'; 
import 'package:flutter/material.dart';
import 'package:sprite_07/component/player_sprite_sheet_component_animation_full.dart';


class MyGame extends FlameGame with HasKeyboardHandlerComponents {
  @override
  void onLoad() {
    super.onLoad();
    add(PlayerSpriteSheetComponentAnimationFull());
  }
}

void main() async{
  runApp(GameWidget(game: MyGame()));
}
