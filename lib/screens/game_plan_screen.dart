import 'package:flutter/cupertino.dart';
import 'package:flutter/services.dart';
import '../utils/colors.dart';
import '../widgets/storm_painter.dart';

class GamePlanScreen extends StatefulWidget {
  const GamePlanScreen({super.key});
  
  @override
  State<GamePlanScreen> createState() => _GamePlanScreenState();
}

class _GamePlanScreenState extends State<GamePlanScreen>
    with SingleTickerProviderStateMixin {
  late AnimationController _stormController;
  String? _selectedSport;
  final List<Offset> _points = [];
  
  @override
  void initState() {
    super.initState();
    _stormController = AnimationController(
      duration: const Duration(seconds: 8),
      vsync: this,
    )..repeat();
  }
  
  @override
  void dispose() {
    _stormController.dispose();
    super.dispose();
  }
  
  void _selectSport(String sport) {
    setState(() {
      _selectedSport = sport;
      _points.clear();
    });
    HapticFeedback.selectionClick();
  }
  
  void _clearDrawing() {
    setState(() => _points.clear());
    HapticFeedback.mediumImpact();
  }
  
  @override
  Widget build(BuildContext context) {
    return CupertinoPageScaffold(
      backgroundColor: AppColors.deepNavy,
      navigationBar: CupertinoNavigationBar(
        backgroundColor: AppColors.deepNavy,
        border: null,
        middle: const Text(
          'Game Plan',
          style: TextStyle(
            color: AppColors.whitePrimary,
            fontSize: 20,
            fontWeight: FontWeight.w600,
          ),
        ),
        trailing: CupertinoButton(
          padding: EdgeInsets.zero,
          onPressed: _clearDrawing,
          child: const Icon(
            CupertinoIcons.delete,
            color: AppColors.whitePrimary,
            size: 24,
          ),
        ),
      ),
      child: CustomPaint(
        painter: StormPainter(_stormController),
        child: SafeArea(
          child: Column(
            children: [
              const SizedBox(height: 20),
              // Sport Selection
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    _buildSportButton('Basketball'),
                    _buildSportButton('Football'),
                    _buildSportButton('Volleyball'),
                  ],
                ),
              ),
              const SizedBox(height: 24),
              // Drawing Board
              Expanded(
                child: Container(
                  margin: const EdgeInsets.symmetric(horizontal: 16),
                  decoration: BoxDecoration(
                    color: AppColors.mediumBlue.withOpacity(0.2),
                    borderRadius: BorderRadius.circular(20),
                    border: Border.all(
                      color: AppColors.lightGrayAccent.withOpacity(0.3),
                      width: 2,
                    ),
                  ),
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(20),
                    child: LayoutBuilder(
                      builder: (context, constraints) {
                        return GestureDetector(
                          onPanUpdate: (details) {
                            setState(() {
                              final localPosition = details.localPosition;
                              _points.add(localPosition);
                            });
                          },
                          onPanEnd: (details) {
                            setState(() {
                              _points.add(const Offset(-1, -1)); // Marker for line break
                            });
                          },
                          child: CustomPaint(
                            painter: DrawingPainter(_points, _selectedSport),
                            size: Size(constraints.maxWidth, constraints.maxHeight),
                          ),
                        );
                      },
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 24),
            ],
          ),
        ),
      ),
    );
  }
  
  Widget _buildSportButton(String sport) {
    final isSelected = _selectedSport == sport;
    return GestureDetector(
      onTap: () => _selectSport(sport),
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 200),
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
        decoration: BoxDecoration(
          gradient: isSelected
              ? AppColors.navyToBlueGradient
              : null,
          color: isSelected ? null : AppColors.mediumBlue.withOpacity(0.3),
          borderRadius: BorderRadius.circular(12),
          border: Border.all(
            color: isSelected
                ? AppColors.lightGrayAccent.withOpacity(0.5)
                : AppColors.neutralGrayBlue.withOpacity(0.3),
            width: 1,
          ),
        ),
        child: Text(
          sport,
          style: TextStyle(
            color: AppColors.whitePrimary,
            fontSize: 14,
            fontWeight: isSelected ? FontWeight.w600 : FontWeight.normal,
          ),
        ),
      ),
    );
  }
}

class DrawingPainter extends CustomPainter {
  final List<Offset> points;
  final String? sport;
  
  DrawingPainter(this.points, this.sport);
  
  @override
  void paint(Canvas canvas, Size size) {
    // Draw field background based on sport
    final fieldPaint = Paint()
      ..color = AppColors.mediumBlue.withOpacity(0.1)
      ..style = PaintingStyle.fill;
    
    if (sport == 'Basketball') {
      // Basketball court
      canvas.drawRect(Rect.fromLTWH(0, 0, size.width, size.height), fieldPaint);
      
      // Court lines
      final linePaint = Paint()
        ..color = AppColors.lightGrayAccent.withOpacity(0.3)
        ..style = PaintingStyle.stroke
        ..strokeWidth = 2;
      
      // Center line
      canvas.drawLine(
        Offset(size.width / 2, 0),
        Offset(size.width / 2, size.height),
        linePaint,
      );
      
      // Free throw circles
      canvas.drawCircle(
        Offset(size.width / 4, size.height / 2),
        size.width / 8,
        linePaint,
      );
      canvas.drawCircle(
        Offset(size.width * 3 / 4, size.height / 2),
        size.width / 8,
        linePaint,
      );
    } else if (sport == 'Football') {
      // Football field
      canvas.drawRect(Rect.fromLTWH(0, 0, size.width, size.height), fieldPaint);
      
      final linePaint = Paint()
        ..color = AppColors.lightGrayAccent.withOpacity(0.3)
        ..style = PaintingStyle.stroke
        ..strokeWidth = 2;
      
      // Center line
      canvas.drawLine(
        Offset(size.width / 2, 0),
        Offset(size.width / 2, size.height),
        linePaint,
      );
      
      // Goal areas
      canvas.drawRect(
        Rect.fromLTWH(0, size.height / 3, size.width / 6, size.height / 3),
        linePaint,
      );
      canvas.drawRect(
        Rect.fromLTWH(size.width * 5 / 6, size.height / 3, size.width / 6, size.height / 3),
        linePaint,
      );
    } else if (sport == 'Volleyball') {
      // Volleyball court
      canvas.drawRect(Rect.fromLTWH(0, 0, size.width, size.height), fieldPaint);
      
      final linePaint = Paint()
        ..color = AppColors.lightGrayAccent.withOpacity(0.3)
        ..style = PaintingStyle.stroke
        ..strokeWidth = 2;
      
      // Center line
      canvas.drawLine(
        Offset(size.width / 2, 0),
        Offset(size.width / 2, size.height),
        linePaint,
      );
      
      // Attack lines
      canvas.drawLine(
        Offset(0, size.height / 3),
        Offset(size.width, size.height / 3),
        linePaint,
      );
      canvas.drawLine(
        Offset(0, size.height * 2 / 3),
        Offset(size.width, size.height * 2 / 3),
        linePaint,
      );
    }
    
    // Draw user's drawing
    if (points.isEmpty) return;
    
    final paint = Paint()
      ..color = AppColors.whitePrimary
      ..strokeWidth = 3
      ..strokeCap = StrokeCap.round
      ..style = PaintingStyle.stroke;
    
    for (int i = 0; i < points.length - 1; i++) {
      if (points[i].dx < 0 || points[i + 1].dx < 0) continue;
      canvas.drawLine(points[i], points[i + 1], paint);
    }
  }
  
  @override
  bool shouldRepaint(DrawingPainter oldDelegate) =>
      oldDelegate.points.length != points.length ||
      oldDelegate.sport != sport;
}

