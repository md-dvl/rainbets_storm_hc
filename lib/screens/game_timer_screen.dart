import 'package:flutter/cupertino.dart';
import 'package:flutter/services.dart';
import 'dart:async';
import '../utils/colors.dart';
import '../widgets/gradient_card.dart';
import '../widgets/storm_painter.dart';

class GameTimerScreen extends StatefulWidget {
  const GameTimerScreen({super.key});
  
  @override
  State<GameTimerScreen> createState() => _GameTimerScreenState();
}

class _GameTimerScreenState extends State<GameTimerScreen>
    with SingleTickerProviderStateMixin {
  late AnimationController _stormController;
  Timer? _timer;
  int _totalSeconds = 0;
  bool _isRunning = false;
  bool _isPaused = false;
  
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
    _timer?.cancel();
    super.dispose();
  }
  
  void _startTimer() {
    if (_isPaused) {
      _isPaused = false;
    } else {
      _totalSeconds = 0;
    }
    
    setState(() => _isRunning = true);
    HapticFeedback.mediumImpact();
    
    _timer = Timer.periodic(const Duration(seconds: 1), (timer) {
      setState(() => _totalSeconds++);
    });
  }
  
  void _pauseTimer() {
    setState(() {
      _isRunning = false;
      _isPaused = true;
    });
    _timer?.cancel();
    HapticFeedback.lightImpact();
  }
  
  void _resetTimer() {
    setState(() {
      _isRunning = false;
      _isPaused = false;
      _totalSeconds = 0;
    });
    _timer?.cancel();
    HapticFeedback.mediumImpact();
  }
  
  String _formatTime(int seconds) {
    final hours = seconds ~/ 3600;
    final minutes = (seconds % 3600) ~/ 60;
    final secs = seconds % 60;
    
    if (hours > 0) {
      return '${hours.toString().padLeft(2, '0')}:'
          '${minutes.toString().padLeft(2, '0')}:'
          '${secs.toString().padLeft(2, '0')}';
    }
    return '${minutes.toString().padLeft(2, '0')}:'
        '${secs.toString().padLeft(2, '0')}';
  }
  
  @override
  Widget build(BuildContext context) {
    return CupertinoPageScaffold(
      backgroundColor: AppColors.deepNavy,
      navigationBar: const CupertinoNavigationBar(
        backgroundColor: AppColors.deepNavy,
        border: null,
        middle: Text(
          'Game Timer',
          style: TextStyle(
            color: AppColors.whitePrimary,
            fontSize: 20,
            fontWeight: FontWeight.w600,
          ),
        ),
      ),
      child: CustomPaint(
        painter: StormPainter(_stormController),
        child: SafeArea(
          child: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                // Timer Display
                GradientCard(
                  padding: const EdgeInsets.all(40),
                  child: Column(
                    children: [
                      Text(
                        _formatTime(_totalSeconds),
                        style: const TextStyle(
                          color: AppColors.whitePrimary,
                          fontSize: 64,
                          fontWeight: FontWeight.w700,
                          fontFeatures: [FontFeature.tabularFigures()],
                        ),
                      ),
                      const SizedBox(height: 16),
                      Text(
                        _isRunning
                            ? 'Running'
                            : _isPaused
                                ? 'Paused'
                                : 'Ready',
                        style: TextStyle(
                          color: AppColors.lightGrayAccent,
                          fontSize: 18,
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 48),
                // Control Buttons
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    if (!_isRunning)
                      CupertinoButton(
                        padding: EdgeInsets.zero,
                        onPressed: _startTimer,
                        child: Container(
                          width: 80,
                          height: 80,
                          decoration: BoxDecoration(
                            gradient: AppColors.navyToBlueGradient,
                            shape: BoxShape.circle,
                            boxShadow: [
                              BoxShadow(
                                color: AppColors.mediumBlue.withOpacity(0.5),
                                blurRadius: 20,
                                offset: const Offset(0, 10),
                              ),
                            ],
                          ),
                          child: const Icon(
                            CupertinoIcons.play_fill,
                            color: AppColors.whitePrimary,
                            size: 36,
                          ),
                        ),
                      )
                    else
                      CupertinoButton(
                        padding: EdgeInsets.zero,
                        onPressed: _pauseTimer,
                        child: Container(
                          width: 80,
                          height: 80,
                          decoration: BoxDecoration(
                            gradient: AppColors.navyToBlueGradient,
                            shape: BoxShape.circle,
                            boxShadow: [
                              BoxShadow(
                                color: AppColors.mediumBlue.withOpacity(0.5),
                                blurRadius: 20,
                                offset: const Offset(0, 10),
                              ),
                            ],
                          ),
                          child: const Icon(
                            CupertinoIcons.pause_fill,
                            color: AppColors.whitePrimary,
                            size: 36,
                          ),
                        ),
                      ),
                    const SizedBox(width: 24),
                    CupertinoButton(
                      padding: EdgeInsets.zero,
                      onPressed: _resetTimer,
                      child: Container(
                        width: 80,
                        height: 80,
                        decoration: BoxDecoration(
                          color: AppColors.mediumBlue.withOpacity(0.3),
                          shape: BoxShape.circle,
                          border: Border.all(
                            color: AppColors.lightGrayAccent.withOpacity(0.3),
                            width: 1,
                          ),
                        ),
                        child: const Icon(
                          CupertinoIcons.arrow_counterclockwise,
                          color: AppColors.whitePrimary,
                          size: 36,
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

