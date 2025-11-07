import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import '../utils/colors.dart';
import '../widgets/storm_painter.dart';

class SettingsScreen extends StatefulWidget {
  const SettingsScreen({super.key});
  
  @override
  State<SettingsScreen> createState() => _SettingsScreenState();
}

class _SettingsScreenState extends State<SettingsScreen>
    with SingleTickerProviderStateMixin {
  late AnimationController _stormController;
  bool _notificationsEnabled = true;
  bool _hapticsEnabled = true;
  double _themeIntensity = 0.7;
  int _selectedColorIndex = 0;
  
  final List<Color> _paletteColors = [
    AppColors.deepNavy,
    AppColors.mediumBlue,
    AppColors.neutralGrayBlue,
    AppColors.lightGrayAccent,
    AppColors.whitePrimary,
  ];
  
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
  
  Color _getActiveColor() {
    return _paletteColors[_selectedColorIndex];
  }
  
  Color _getBackgroundColor() {
    final baseColor = _getActiveColor();
    return Color.lerp(
      AppColors.deepNavy,
      baseColor,
      _themeIntensity * 0.3,
    ) ?? AppColors.deepNavy;
  }
  
  Color _getCardColor() {
    final baseColor = _getActiveColor();
    return Color.lerp(
      AppColors.mediumBlue,
      baseColor,
      _themeIntensity,
    ) ?? AppColors.mediumBlue;
  }
  
  Color _getTextColor() {
    final baseColor = _getActiveColor();
    return Color.lerp(
      AppColors.whitePrimary,
      baseColor,
      _themeIntensity * 0.2,
    ) ?? AppColors.whitePrimary;
  }
  
  Color _getAccentColor() {
    final baseColor = _getActiveColor();
    return Color.lerp(
      AppColors.lightGrayAccent,
      baseColor,
      _themeIntensity * 0.5,
    ) ?? AppColors.lightGrayAccent;
  }
  
  LinearGradient _getCardGradient() {
    final baseColor = _getActiveColor();
    return LinearGradient(
      begin: Alignment.topLeft,
      end: Alignment.bottomRight,
      colors: [
        _getCardColor(),
        Color.lerp(
          AppColors.deepNavy,
          baseColor,
          _themeIntensity * 0.5,
        ) ?? AppColors.deepNavy,
        AppColors.deepNavy,
      ],
    );
  }
  
  @override
  Widget build(BuildContext context) {
    final backgroundColor = _getBackgroundColor();
    final textColor = _getTextColor();
    final accentColor = _getAccentColor();
    final cardGradient = _getCardGradient();
    
    return CupertinoPageScaffold(
      backgroundColor: backgroundColor,
      navigationBar: CupertinoNavigationBar(
        backgroundColor: backgroundColor,
        border: null,
        middle: Text(
          'Settings',
          style: TextStyle(
            color: textColor,
            fontSize: 20,
            fontWeight: FontWeight.w600,
          ),
        ),
      ),
      child: CustomPaint(
        painter: StormPainter(_stormController),
        child: SafeArea(
          child: SingleChildScrollView(
            child: Column(
              children: [
                const SizedBox(height: 24),
                // Theme Intensity
                Container(
                  margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                  padding: const EdgeInsets.all(20),
                  decoration: BoxDecoration(
                    gradient: cardGradient,
                    borderRadius: BorderRadius.circular(16),
                    border: Border.all(
                      color: accentColor.withOpacity(0.2 * _themeIntensity + 0.2),
                      width: 1,
                    ),
                    boxShadow: [
                      BoxShadow(
                        color: _getActiveColor().withOpacity(0.3 * _themeIntensity),
                        blurRadius: 20,
                        offset: const Offset(0, 10),
                      ),
                    ],
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            'Theme Intensity',
                            style: TextStyle(
                              color: textColor,
                              fontSize: 18,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                          Text(
                            '${(_themeIntensity * 100).toInt()}%',
                            style: TextStyle(
                              color: accentColor,
                              fontSize: 16,
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 16),
                      CupertinoSlider(
                        value: _themeIntensity,
                        onChanged: (value) {
                          setState(() => _themeIntensity = value);
                        },
                        activeColor: accentColor,
                      ),
                    ],
                  ),
                ),
                // Notifications Toggle
                Container(
                  margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                  padding: const EdgeInsets.all(20),
                  decoration: BoxDecoration(
                    gradient: cardGradient,
                    borderRadius: BorderRadius.circular(16),
                    border: Border.all(
                      color: accentColor.withOpacity(0.2 * _themeIntensity + 0.2),
                      width: 1,
                    ),
                    boxShadow: [
                      BoxShadow(
                        color: _getActiveColor().withOpacity(0.3 * _themeIntensity),
                        blurRadius: 20,
                        offset: const Offset(0, 10),
                      ),
                    ],
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Row(
                        children: [
                          Icon(
                            CupertinoIcons.bell_fill,
                            color: accentColor,
                            size: 24,
                          ),
                          const SizedBox(width: 16),
                          Text(
                            'Notifications',
                            style: TextStyle(
                              color: textColor,
                              fontSize: 18,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        ],
                      ),
                      CupertinoSwitch(
                        value: _notificationsEnabled,
                        onChanged: (value) {
                          setState(() => _notificationsEnabled = value);
                        },
                        activeColor: _getCardColor(),
                      ),
                    ],
                  ),
                ),
                // Haptics Toggle
                Container(
                  margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                  padding: const EdgeInsets.all(20),
                  decoration: BoxDecoration(
                    gradient: cardGradient,
                    borderRadius: BorderRadius.circular(16),
                    border: Border.all(
                      color: accentColor.withOpacity(0.2 * _themeIntensity + 0.2),
                      width: 1,
                    ),
                    boxShadow: [
                      BoxShadow(
                        color: _getActiveColor().withOpacity(0.3 * _themeIntensity),
                        blurRadius: 20,
                        offset: const Offset(0, 10),
                      ),
                    ],
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Row(
                        children: [
                          Icon(
                            CupertinoIcons.hand_thumbsup_fill,
                            color: accentColor,
                            size: 24,
                          ),
                          const SizedBox(width: 16),
                          Text(
                            'Haptics',
                            style: TextStyle(
                              color: textColor,
                              fontSize: 18,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        ],
                      ),
                      CupertinoSwitch(
                        value: _hapticsEnabled,
                        onChanged: (value) {
                          setState(() => _hapticsEnabled = value);
                        },
                        activeColor: _getCardColor(),
                      ),
                    ],
                  ),
                ),
                // Palette Selector
                Container(
                  margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                  padding: const EdgeInsets.all(20),
                  decoration: BoxDecoration(
                    gradient: cardGradient,
                    borderRadius: BorderRadius.circular(16),
                    border: Border.all(
                      color: accentColor.withOpacity(0.2 * _themeIntensity + 0.2),
                      width: 1,
                    ),
                    boxShadow: [
                      BoxShadow(
                        color: _getActiveColor().withOpacity(0.3 * _themeIntensity),
                        blurRadius: 20,
                        offset: const Offset(0, 10),
                      ),
                    ],
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Color Palette',
                        style: TextStyle(
                          color: textColor,
                          fontSize: 18,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                      const SizedBox(height: 20),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: List.generate(
                          _paletteColors.length,
                          (index) => GestureDetector(
                            onTap: () {
                              setState(() => _selectedColorIndex = index);
                            },
                            child: AnimatedContainer(
                              duration: const Duration(milliseconds: 200),
                              width: 50,
                              height: 50,
                              decoration: BoxDecoration(
                                color: _paletteColors[index],
                                shape: BoxShape.circle,
                                border: Border.all(
                                  color: _selectedColorIndex == index
                                      ? textColor
                                      : Colors.transparent,
                                  width: 3,
                                ),
                                boxShadow: _selectedColorIndex == index
                                    ? [
                                        BoxShadow(
                                          color: _paletteColors[index]
                                              .withOpacity(0.5 * _themeIntensity + 0.3),
                                          blurRadius: 15,
                                          offset: const Offset(0, 5),
                                        ),
                                      ]
                                    : null,
                              ),
                            ),
                          ),
                        ),
                      ),
                      const SizedBox(height: 16),
                      Center(
                        child: Text(
                          _getColorName(_selectedColorIndex),
                          style: TextStyle(
                            color: accentColor,
                            fontSize: 14,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                // Preview Card
                Container(
                  margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                  padding: const EdgeInsets.all(20),
                  decoration: BoxDecoration(
                    gradient: cardGradient,
                    borderRadius: BorderRadius.circular(16),
                    border: Border.all(
                      color: accentColor.withOpacity(0.2 * _themeIntensity + 0.2),
                      width: 1,
                    ),
                    boxShadow: [
                      BoxShadow(
                        color: _getActiveColor().withOpacity(0.3 * _themeIntensity),
                        blurRadius: 20,
                        offset: const Offset(0, 10),
                      ),
                    ],
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Preview',
                        style: TextStyle(
                          color: textColor,
                          fontSize: 18,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                      const SizedBox(height: 16),
                      Text(
                        'This is how your selected palette and intensity look.',
                        style: TextStyle(
                          color: accentColor,
                          fontSize: 14,
                          height: 1.5,
                        ),
                      ),
                      const SizedBox(height: 12),
                      Container(
                        padding: const EdgeInsets.all(12),
                        decoration: BoxDecoration(
                          color: _getActiveColor().withOpacity(0.2 * _themeIntensity),
                          borderRadius: BorderRadius.circular(8),
                        ),
                        child: Row(
                          children: [
                            Icon(
                              CupertinoIcons.paintbrush_fill,
                              color: accentColor,
                              size: 20,
                            ),
                            const SizedBox(width: 8),
                            Text(
                              'Active Color: ${_getColorName(_selectedColorIndex)}',
                              style: TextStyle(
                                color: textColor,
                                fontSize: 14,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 32),
              ],
            ),
          ),
        ),
      ),
    );
  }
  
  String _getColorName(int index) {
    switch (index) {
      case 0:
        return 'Deep Navy';
      case 1:
        return 'Medium Blue';
      case 2:
        return 'Neutral Gray-Blue';
      case 3:
        return 'Light Gray Accent';
      case 4:
        return 'White Primary';
      default:
        return '';
    }
  }
}

