import 'dart:math' as math;
import 'package:flutter/cupertino.dart';
import '../utils/colors.dart';

class StormPainter extends CustomPainter {
  final Animation<double> animation;
  
  StormPainter(this.animation) : super(repaint: animation);
  
  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..style = PaintingStyle.fill
      ..maskFilter = const MaskFilter.blur(BlurStyle.normal, 20);
    
    final centerX = size.width / 2;
    final centerY = size.height / 2;
    
    // Create fluid, storm-like abstract shapes
    final path1 = Path();
    final path2 = Path();
    final path3 = Path();
    
    final wave1 = animation.value * 2 * math.pi;
    final wave2 = (animation.value * 2 * math.pi) + math.pi / 3;
    final wave3 = (animation.value * 2 * math.pi) + 2 * math.pi / 3;
    
    // First fluid shape
    path1.moveTo(0, size.height * 0.3);
    for (double x = 0; x <= size.width; x += 5) {
      final y = size.height * 0.3 + 
          math.sin((x / size.width * 4 * math.pi) + wave1) * 40 +
          math.cos((x / size.width * 2 * math.pi) + wave1) * 20;
      path1.lineTo(x, y);
    }
    path1.lineTo(size.width, size.height);
    path1.lineTo(0, size.height);
    path1.close();
    
    // Second fluid shape
    path2.moveTo(0, size.height * 0.6);
    for (double x = 0; x <= size.width; x += 5) {
      final y = size.height * 0.6 + 
          math.sin((x / size.width * 3 * math.pi) + wave2) * 50 +
          math.cos((x / size.width * 1.5 * math.pi) + wave2) * 30;
      path2.lineTo(x, y);
    }
    path2.lineTo(size.width, size.height);
    path2.lineTo(0, size.height);
    path2.close();
    
    // Third fluid shape (smaller, accent)
    path3.moveTo(size.width * 0.2, size.height * 0.1);
    for (double x = size.width * 0.2; x <= size.width * 0.8; x += 5) {
      final y = size.height * 0.1 + 
          math.sin((x / size.width * 5 * math.pi) + wave3) * 30 +
          math.cos((x / size.width * 3 * math.pi) + wave3) * 15;
      path3.lineTo(x, y);
    }
    path3.lineTo(size.width * 0.8, size.height * 0.4);
    path3.lineTo(size.width * 0.2, size.height * 0.4);
    path3.close();
    
    // Draw shapes with gradients
    final gradient1 = LinearGradient(
      begin: Alignment.topLeft,
      end: Alignment.bottomRight,
      colors: [
        AppColors.mediumBlue.withOpacity(0.3),
        AppColors.neutralGrayBlue.withOpacity(0.2),
        AppColors.deepNavy.withOpacity(0.1),
      ],
    );
    
    final gradient2 = LinearGradient(
      begin: Alignment.topRight,
      end: Alignment.bottomLeft,
      colors: [
        AppColors.neutralGrayBlue.withOpacity(0.25),
        AppColors.mediumBlue.withOpacity(0.15),
        AppColors.deepNavy.withOpacity(0.1),
      ],
    );
    
    final gradient3 = LinearGradient(
      begin: Alignment.topCenter,
      end: Alignment.bottomCenter,
      colors: [
        AppColors.lightGrayAccent.withOpacity(0.2),
        AppColors.mediumBlue.withOpacity(0.1),
      ],
    );
    
    paint.shader = gradient1.createShader(
      Rect.fromLTWH(0, 0, size.width, size.height),
    );
    canvas.drawPath(path1, paint);
    
    paint.shader = gradient2.createShader(
      Rect.fromLTWH(0, 0, size.width, size.height),
    );
    canvas.drawPath(path2, paint);
    
    paint.shader = gradient3.createShader(
      Rect.fromLTWH(0, 0, size.width, size.height),
    );
    canvas.drawPath(path3, paint);
    
    // Add some floating particles
    final particlePaint = Paint()
      ..color = AppColors.lightGrayAccent.withOpacity(0.3)
      ..style = PaintingStyle.fill;
    
    for (int i = 0; i < 8; i++) {
      final angle = (animation.value * 2 * math.pi) + (i * math.pi / 4);
      final radius = 50 + (i * 10);
      final x = centerX + math.cos(angle) * radius;
      final y = centerY + math.sin(angle) * radius;
      canvas.drawCircle(
        Offset(x, y),
        3 + (math.sin(animation.value * 2 * math.pi + i) * 2),
        particlePaint,
      );
    }
  }
  
  @override
  bool shouldRepaint(StormPainter oldDelegate) => true;
}

