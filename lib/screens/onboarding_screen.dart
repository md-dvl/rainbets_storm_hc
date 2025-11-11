import 'package:flutter/cupertino.dart';
import '../utils/colors.dart';
import '../widgets/storm_painter.dart';

class OnboardingScreen extends StatefulWidget {
  const OnboardingScreen({super.key});

  @override
  State<OnboardingScreen> createState() => _OnboardingScreenState();
}

class _OnboardingScreenState extends State<OnboardingScreen>
    with TickerProviderStateMixin {
  late final PageController _pageController;
  late final AnimationController _stormController;
  late final AnimationController _iconPulseController;
  int _currentPage = 0;

  @override
  void initState() {
    super.initState();
    _pageController = PageController();
    _stormController = AnimationController(
      duration: const Duration(seconds: 10),
      vsync: this,
    )..repeat();
    _iconPulseController = AnimationController(
      duration: const Duration(milliseconds: 1600),
      vsync: this,
    )..repeat(reverse: true);
  }

  @override
  void dispose() {
    _pageController.dispose();
    _stormController.dispose();
    _iconPulseController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return CupertinoPageScaffold(
      backgroundColor: AppColors.deepNavy,
      child: Stack(
        children: [
          CustomPaint(
            painter: StormPainter(_stormController),
            size: Size.infinite,
          ),
          SafeArea(
            child: Column(
              children: [
                Padding(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 24,
                    vertical: 16,
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      const Text(
                        'Storm Nexus',
                        style: TextStyle(
                          color: AppColors.whitePrimary,
                          fontSize: 22,
                          fontWeight: FontWeight.w700,
                        ),
                      ),
                      CupertinoButton(
                        padding: EdgeInsets.zero,
                        onPressed: _currentPage == 1
                            ? null
                            : () => _goToMain(context),
                        child: Text(
                          _currentPage == 1 ? '' : 'Skip',
                          style: TextStyle(
                            color: AppColors.lightGrayAccent.withOpacity(0.8),
                            fontSize: 16,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                Expanded(
                  child: PageView(
                    controller: _pageController,
                    onPageChanged: (index) {
                      setState(() => _currentPage = index);
                    },
                    children: [_buildFirstPage(), _buildSecondPage(context)],
                  ),
                ),
                const SizedBox(height: 12),
                _buildIndicator(),
                const SizedBox(height: 32),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildFirstPage() {
    return LayoutBuilder(
      builder: (context, constraints) {
        final bool isActive = _currentPage == 0;
        return SingleChildScrollView(
          physics: const BouncingScrollPhysics(),
          child: ConstrainedBox(
            constraints: BoxConstraints(minHeight: constraints.maxHeight),
            child: AnimatedOpacity(
              duration: const Duration(milliseconds: 400),
              opacity: isActive ? 1.0 : 0.4,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  SizedBox(height: constraints.maxHeight * 0.05),
                  ScaleTransition(
                    scale: Tween<double>(begin: 0.95, end: 1.05).animate(
                      CurvedAnimation(
                        parent: _iconPulseController,
                        curve: Curves.easeInOut,
                      ),
                    ),
                    child: Hero(
                      tag: 'brand_icon',
                      child: Container(
                        width: constraints.maxWidth * 0.45,
                        height: constraints.maxWidth * 0.45,
                        decoration: BoxDecoration(
                          gradient: AppColors.navyToBlueGradient,
                          borderRadius: BorderRadius.circular(32),
                          border: Border.all(
                            color: AppColors.lightGrayAccent.withOpacity(0.3),
                            width: 2,
                          ),
                          boxShadow: [
                            BoxShadow(
                              color: AppColors.mediumBlue.withOpacity(0.4),
                              blurRadius: 30,
                              offset: const Offset(0, 18),
                            ),
                          ],
                        ),
                        child: Padding(
                          padding: const EdgeInsets.all(24),
                          child: Image.asset(
                            'assets/ic.png',
                            fit: BoxFit.contain,
                          ),
                        ),
                      ),
                    ),
                  ),
                  SizedBox(height: constraints.maxHeight * 0.06),
                  AnimatedDefaultTextStyle(
                    duration: const Duration(milliseconds: 300),
                    style: TextStyle(
                      color: AppColors.whitePrimary,
                      fontSize: isActive ? 34 : 30,
                      fontWeight: FontWeight.w700,
                      letterSpacing: 0.8,
                    ),
                    child: const Text('Command the Storm'),
                  ),
                  const SizedBox(height: 16),
                  SizedBox(
                    width: constraints.maxWidth * 0.8,
                    child: Text(
                      'Experience storm-crafted sports intelligence wrapped in a surge of dynamic visuals, motion, and strategic inspiration.',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        color: AppColors.lightGrayAccent.withOpacity(0.85),
                        fontSize: 16,
                        height: 1.5,
                      ),
                    ),
                  ),
                  const SizedBox(height: 32),
                  _buildHighlightChips([
                    'Real-time energy',
                    'Storm-crafted palette',
                    'Fluid, animated journeys',
                  ], isActive),
                  const SizedBox(height: 32),
                ],
              ),
            ),
          ),
        );
      },
    );
  }

  Widget _buildSecondPage(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        final bool isActive = _currentPage == 1;
        return SingleChildScrollView(
          physics: const BouncingScrollPhysics(),
          child: ConstrainedBox(
            constraints: BoxConstraints(minHeight: constraints.maxHeight),
            child: AnimatedOpacity(
              duration: const Duration(milliseconds: 400),
              opacity: isActive ? 1.0 : 0.4,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  SizedBox(height: constraints.maxHeight * 0.05),
                  AnimatedScale(
                    duration: const Duration(milliseconds: 400),
                    scale: isActive ? 1.0 : 0.9,
                    child: Container(
                      padding: const EdgeInsets.all(20),
                      decoration: BoxDecoration(
                        color: AppColors.mediumBlue.withOpacity(0.25),
                        borderRadius: BorderRadius.circular(24),
                        border: Border.all(
                          color: AppColors.lightGrayAccent.withOpacity(0.25),
                          width: 1,
                        ),
                      ),
                      child: Column(
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: const [
                              Icon(
                                CupertinoIcons.sparkles,
                                color: AppColors.lightGrayAccent,
                                size: 24,
                              ),
                              SizedBox(width: 8),
                              Text(
                                'Your Elite Sports Toolkit',
                                style: TextStyle(
                                  color: AppColors.lightGrayAccent,
                                  fontSize: 16,
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                            ],
                          ),
                          const SizedBox(height: 20),
                          _buildFeatureRow(
                            constraints,
                            'Notebook brilliance',
                            'Capture tactics, reflections, and insights with graceful, glassmorphic surfaces.',
                          ),
                          const SizedBox(height: 20),
                          _buildFeatureRow(
                            constraints,
                            'Storm quiz motion',
                            'Interactive knowledge drills with animated feedback and hero transitions.',
                          ),
                          const SizedBox(height: 20),
                          _buildFeatureRow(
                            constraints,
                            'Game plan canvas',
                            'Sketch plays across storm-crafted courts wrapped in dynamic motion gradients.',
                          ),
                        ],
                      ),
                    ),
                  ),
                  SizedBox(height: constraints.maxHeight * 0.08),
                  CupertinoButton.filled(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 48,
                      vertical: 16,
                    ),
                    borderRadius: BorderRadius.circular(28),
                    onPressed: () => _goToMain(context),
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: const [
                        Text(
                          'Dive into the Storm Experience',
                          style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                        SizedBox(width: 8),
                        Icon(CupertinoIcons.arrow_right_circle_fill, size: 22),
                      ],
                    ),
                  ),
                  SizedBox(height: constraints.maxHeight * 0.05),
                  Hero(
                    tag: 'brand_icon',
                    child: Container(
                      width: 72,
                      height: 72,
                      decoration: BoxDecoration(
                        gradient: AppColors.navyToBlueGradient,
                        shape: BoxShape.circle,
                        border: Border.all(
                          color: AppColors.lightGrayAccent.withOpacity(0.4),
                          width: 1.5,
                        ),
                      ),
                      child: Padding(
                        padding: const EdgeInsets.all(12),
                        child: Image.asset(
                          'assets/ic.png',
                          fit: BoxFit.contain,
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
      },
    );
  }

  Widget _buildFeatureRow(
    BoxConstraints constraints,
    String title,
    String subtitle,
  ) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          width: 46,
          height: 46,
          decoration: BoxDecoration(
            gradient: AppColors.navyToBlueGradient,
            borderRadius: BorderRadius.circular(12),
            border: Border.all(
              color: AppColors.lightGrayAccent.withOpacity(0.2),
            ),
            boxShadow: [
              BoxShadow(
                color: AppColors.mediumBlue.withOpacity(0.3),
                blurRadius: 12,
                offset: const Offset(0, 6),
              ),
            ],
          ),
          child: const Icon(
            CupertinoIcons.sparkles,
            color: AppColors.whitePrimary,
            size: 22,
          ),
        ),
        const SizedBox(width: 14),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                title,
                style: const TextStyle(
                  color: AppColors.whitePrimary,
                  fontSize: 16,
                  fontWeight: FontWeight.w600,
                ),
              ),
              const SizedBox(height: 6),
              Text(
                subtitle,
                style: TextStyle(
                  color: AppColors.lightGrayAccent.withOpacity(0.8),
                  fontSize: 14,
                  height: 1.4,
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildHighlightChips(List<String> labels, bool isActive) {
    return Wrap(
      alignment: WrapAlignment.center,
      spacing: 12,
      runSpacing: 12,
      children: List.generate(labels.length, (index) {
        return AnimatedContainer(
          duration: Duration(milliseconds: 300 + (index * 80)),
          curve: Curves.easeOutCubic,
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
          decoration: BoxDecoration(
            color: isActive
                ? AppColors.mediumBlue.withOpacity(0.35)
                : AppColors.mediumBlue.withOpacity(0.2),
            borderRadius: BorderRadius.circular(24),
            border: Border.all(
              color: AppColors.lightGrayAccent.withOpacity(
                isActive ? 0.5 : 0.2,
              ),
            ),
            boxShadow: isActive
                ? [
                    BoxShadow(
                      color: AppColors.mediumBlue.withOpacity(0.25),
                      blurRadius: 12,
                      offset: const Offset(0, 6),
                    ),
                  ]
                : null,
          ),
          child: Text(
            labels[index],
            style: const TextStyle(
              color: AppColors.whitePrimary,
              fontSize: 14,
              fontWeight: FontWeight.w500,
            ),
          ),
        );
      }),
    );
  }

  Widget _buildIndicator() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: List.generate(2, (index) {
        final bool isActive = _currentPage == index;
        return AnimatedContainer(
          duration: const Duration(milliseconds: 350),
          curve: Curves.easeOutCubic,
          margin: const EdgeInsets.symmetric(horizontal: 8),
          padding: EdgeInsets.symmetric(
            horizontal: isActive ? 18 : 6,
            vertical: 6,
          ),
          decoration: BoxDecoration(
            gradient: isActive
                ? LinearGradient(
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                    colors: [AppColors.lightGrayAccent, AppColors.mediumBlue],
                  )
                : null,
            color: isActive
                ? null
                : AppColors.neutralGrayBlue.withOpacity(0.25),
            borderRadius: BorderRadius.circular(20),
            border: Border.all(
              color: isActive
                  ? AppColors.whitePrimary.withOpacity(0.9)
                  : AppColors.neutralGrayBlue.withOpacity(0.4),
              width: isActive ? 1.6 : 1,
            ),
            boxShadow: isActive
                ? [
                    BoxShadow(
                      color: AppColors.lightGrayAccent.withOpacity(0.45),
                      blurRadius: 16,
                      spreadRadius: 2,
                      offset: const Offset(0, 6),
                    ),
                  ]
                : null,
          ),
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              AnimatedContainer(
                duration: const Duration(milliseconds: 350),
                width: isActive ? 10 : 8,
                height: isActive ? 10 : 8,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: isActive
                      ? AppColors.deepNavy
                      : AppColors.lightGrayAccent.withOpacity(0.5),
                ),
              ),
              if (isActive) ...[
                const SizedBox(width: 8),
                Text(
                  index == 0 ? 'Intro' : 'Explore',
                  style: const TextStyle(
                    color: AppColors.deepNavy,
                    fontSize: 12,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ],
            ],
          ),
        );
      }),
    );
  }

  void _goToMain(BuildContext context) {
    Navigator.of(context).pushReplacementNamed('/main');
  }
}
