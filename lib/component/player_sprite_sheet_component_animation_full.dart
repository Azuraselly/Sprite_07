import 'package:flame/sprite.dart';
import 'package:flame/flame.dart';
import 'package:flame/components.dart';
import 'package:flame/events.dart'; // untuk TapCallbacks
import 'package:flutter/services.dart';
import 'package:sprite_07/utils/create_animation_by_limit.dart';

class PlayerSpriteSheetComponentAnimationFull extends SpriteAnimationComponent 
    with HasGameReference, KeyboardHandler, TapCallbacks {  
  
  late double screenWidth;
  late double screenHeight;

  late double centerX;
  late double centerY;

  final double spriteSheetWidth = 680;
  final double spriteSheetHeight = 472;
  final double speed = 500;
  Vector2 velocity = Vector2.zero();
  double direction = 1;
  
  bool isMoving = false;

  late SpriteAnimation deadAnimation;
  late SpriteAnimation idleAnimation;
  late SpriteAnimation jumpAnimation;
  late SpriteAnimation runAnimation;
  late SpriteAnimation walkAnimation;

  /// index animasi untuk klik
  int _clickIndex = 0;

  @override
  void onLoad() async {
    final spriteImages = await Flame.images.load('dinofull.png');
    final spriteSheet = SpriteSheet(
      image: spriteImages,
      srcSize: Vector2(spriteSheetWidth, spriteSheetHeight),
    );

    //Animations created
    deadAnimation = spriteSheet.createAnimationByLimit(
        xInit: 0, yInit: 0, step: 8, sizeX: 5, stepTime: .08);
    idleAnimation = spriteSheet.createAnimationByLimit(
        xInit: 1, yInit: 2, step: 10, sizeX: 5, stepTime: .08);
    jumpAnimation = spriteSheet.createAnimationByLimit(
        xInit: 3, yInit: 2, step: 12, sizeX: 5, stepTime: .08);
    runAnimation = spriteSheet.createAnimationByLimit(
        xInit: 1, yInit: 4, step: 8, sizeX: 5, stepTime: .08);
    walkAnimation = spriteSheet.createAnimationByLimit(
        xInit: 6, yInit: 2, step: 10, sizeX: 5, stepTime: .08);
    //End

    animation = idleAnimation;

    screenWidth = game.size.x;
    screenHeight = game.size.y;

    size = Vector2(spriteSheetWidth, spriteSheetHeight);

    centerX = (screenWidth/2)-(spriteSheetWidth/2);
    centerY = (screenHeight/2)-(spriteSheetHeight/2);

    position = Vector2(centerX, centerY);
  }

  @override
  void update(double dt) {
    super.update(dt);
    
    // Update posisi berdasarkan velocity
    position += velocity * dt;
    
    // Batasi agar tidak keluar dari layar
    position.x = position.x.clamp((width/2) -20 , (screenWidth - (width/2)) +20);
    
    // Animasi default gerakan (hanya kalau tidak diklik)
    if (isMoving) {
      if (animation != walkAnimation) {
        animation = walkAnimation;
      }
    } else {
      if (_clickIndex == 0 && animation != idleAnimation) {
        animation = idleAnimation;
      }
    }
    
    // Flip sprite berdasarkan direction
    scale.x = (direction == -1) ? -1 : 1;
  }

  @override
  bool onKeyEvent(KeyEvent event, Set<LogicalKeyboardKey> keysPressed) {
    isMoving = false;
    velocity.x = 0;

    if (keysPressed.contains(LogicalKeyboardKey.arrowLeft)) {
      velocity.x = -speed;
      direction = -1;
      isMoving = true;
    }
    
    if (keysPressed.contains(LogicalKeyboardKey.arrowRight)) {
      velocity.x = speed;
      direction = 1;
      isMoving = true;
    }

    return true;
  }

  // klik dino → ganti animasi
  @override
  void onTapDown(TapDownEvent event) {
    _clickIndex = (_clickIndex + 1) % 5; // cycle 0-4

    switch (_clickIndex) {
      case 0:
        animation = idleAnimation;
        break;
      case 1:
        animation = walkAnimation;
        break;
      case 2:
        animation = runAnimation;
        break;
      case 3:
        animation = jumpAnimation;
        break;
      case 4:
        animation = deadAnimation;
        break;
    }
  }
}
