import 'package:flame/sprite.dart';
import 'package:flame/flame.dart';
import 'package:flame/components.dart';
import 'package:flutter/services.dart';
import 'package:sprite_07/utils/create_animation_by_limit.dart';

class PlayerSpriteSheetComponentAnimationFull extends SpriteAnimationComponent 
    with HasGameReference,KeyboardHandler {  
  
  late double screenWidth;
  late double screenHeight;

  late double centerX;
  late double centerY;

  final double spriteSheetWidth = 680;
  final double spriteSheetHeight = 472;
  final double speed = 500; //kecepatan bergerak
  Vector2 velocity = Vector2.zero(); //gambar bergerak
  double direction = 1; // kanan kiri
  
  bool isMoving = false;  // TAMBAHKAN VARIABEL INI

  late SpriteAnimation deadAnimation;
  late SpriteAnimation idleAnimation;
  late SpriteAnimation jumpAnimation;
  late SpriteAnimation runAnimation;
  late SpriteAnimation walkAnimation;

  @override
  void onLoad() async {
    final spriteImages = await Flame.images.load('dinofull.png');
    final spriteSheet = SpriteSheet(image: spriteImages, srcSize: Vector2(spriteSheetWidth, spriteSheetHeight));

    //Animations created
    deadAnimation = spriteSheet.createAnimationByLimit(xInit: 0, yInit: 0, step: 8, sizeX: 5, stepTime: .08);
    idleAnimation = spriteSheet.createAnimationByLimit(xInit: 1, yInit: 2, step: 10, sizeX: 5, stepTime: .08);
    jumpAnimation = spriteSheet.createAnimationByLimit(xInit: 3, yInit: 2, step: 12, sizeX: 5, stepTime: .08);
    runAnimation = spriteSheet.createAnimationByLimit(xInit: 1, yInit: 4, step: 8, sizeX: 5, stepTime: .08);
    walkAnimation = spriteSheet.createAnimationByLimit(xInit: 6, yInit: 2, step: 10, sizeX: 5, stepTime: .08);
    //End

    animation = runAnimation;

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
    
    // Update animasi berdasarkan state
    if (isMoving) {
      if (animation != walkAnimation) {
        animation = walkAnimation;
      }
    } else {
      if (animation != idleAnimation) {
        animation = idleAnimation;
      }
    }
    
    // Flip sprite berdasarkan direction
    if (direction == -1) {
      // Menghadap kiri
      scale.x = -1;
    } else {
      // Menghadap kanan
      scale.x = 1;
    }
  }

  @override
  bool onKeyEvent(KeyEvent event, Set<LogicalKeyboardKey> keysPressed) {
    isMoving = false;
    velocity.x = 0;

    // Cek tombol yang ditekan
    if (keysPressed.contains(LogicalKeyboardKey.arrowLeft)) {
      velocity.x = -speed;
      direction = -1; // Menghadap kiri
      isMoving = true;
    }
    
    if (keysPressed.contains(LogicalKeyboardKey.arrowRight)) {
      velocity.x = speed;
      direction = 1; // Menghadap kanan
      isMoving = true;
    }

    return true;
  }
}
