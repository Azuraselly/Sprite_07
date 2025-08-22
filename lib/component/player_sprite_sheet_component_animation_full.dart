import 'package:flame/sprite.dart';
import 'package:flame/flame.dart';
import 'package:flame/components.dart';
import 'package:sprite_07/utils/create_animation_by_limit.dart';

class PlayerSpriteSheetComponentAnimationFull extends SpriteAnimationComponent with HasGameReference {
  late double screenWidth;
  late double screenHeight;

  late double centerX;
  late double centerY;

  final double spriteSheetWidth = 680;
  final double spriteSheetHeight = 472;

  late SpriteAnimation deadAnimation;
  late SpriteAnimation idleAnimation;
  late SpriteAnimation jumpAnimation;
  late SpriteAnimation runAnimation;
  late SpriteAnimation walkAnimation;

  @override
  void onLoad() async {
    final spriteImage = await Flame.images.load('dinofull.png');

    final spriteSheet = SpriteSheet(
      image: spriteImage,
      srcSize: Vector2(spriteSheetWidth, spriteSheetHeight),
    );

    deadAnimation = spriteSheet.createAnimationByLimit(xInit: 0, yInit: 0, step: 8, sizeX: 5, stepTime: 0.8);
    idleAnimation = spriteSheet.createAnimationByLimit(xInit: 1, yInit: 2, step: 10, sizeX: 5, stepTime: 0.8);
    jumpAnimation = spriteSheet.createAnimationByLimit(xInit: 3, yInit: 0, step: 12, sizeX: 5, stepTime: 0.8);
    runAnimation = spriteSheet.createAnimationByLimit(xInit: 5, yInit: 0, step: 8, sizeX: 5, stepTime: 0.8);
    walkAnimation = spriteSheet.createAnimationByLimit(xInit: 6, yInit: 2, step: 10, sizeX: 5, stepTime: 0.8);

    animation = walkAnimation;

    screenWidth = game.size.x;
    screenHeight = game.size.y;

    size = Vector2(spriteSheetWidth, spriteSheetHeight);

    centerX = (screenWidth/2) - (spriteSheetWidth/2);
    centerY = (screenHeight/2) - (spriteSheetHeight/2);

    position = Vector2(centerX, centerY);
  }
}