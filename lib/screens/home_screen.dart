import 'package:flutter/cupertino.dart';
import '../utils/colors.dart';
import '../widgets/gradient_card.dart';
import '../widgets/storm_painter.dart';
import 'sports_facts_screen.dart';
import 'sports_notes_screen.dart';
import 'league_quiz_screen.dart';
import 'game_timer_screen.dart';
import 'game_plan_screen.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});
  
  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen>
    with SingleTickerProviderStateMixin {
  late AnimationController _stormController;
  
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
  
  void _navigateToScreen(Widget screen) {
    Navigator.of(context).push(
      CupertinoPageRoute(builder: (_) => screen),
    );
  }
  
  @override
  Widget build(BuildContext context) {
    return CupertinoPageScaffold(
      backgroundColor: AppColors.deepNavy,
      navigationBar: const CupertinoNavigationBar(
        backgroundColor: AppColors.deepNavy,
        border: null,
        middle: Text(
          "Rainbet's Storm",
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
          child: SingleChildScrollView(
            child: Column(
              children: [
                const SizedBox(height: 20),
                // Brand Image
                Hero(
                  tag: 'brand_image',
                  child: Container(
                    width: double.infinity,
                    height: 200,
                    margin: const EdgeInsets.symmetric(horizontal: 16),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(20),
                      boxShadow: [
                        BoxShadow(
                          color: AppColors.mediumBlue.withOpacity(0.5),
                          blurRadius: 30,
                          offset: const Offset(0, 15),
                        ),
                      ],
                    ),
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(20),
                      child: Image.asset(
                        'assets/player.jpeg',
                        fit: BoxFit.cover,
                      ),
                    ),
                  ),
                ),
                const SizedBox(height: 32),
                // Interactive Options List
                _buildOptionCard(
                  icon: CupertinoIcons.sportscourt_fill,
                  title: 'Facts',
                  subtitle: 'Discover interesting sports facts',
                  onTap: () => _navigateToScreen(const SportsFactsScreen()),
                ),
                _buildOptionCard(
                  icon: CupertinoIcons.book_fill,
                  title: 'Notes',
                  subtitle: 'Write and save your notes',
                  onTap: () => _navigateToScreen(const SportsNotesScreen()),
                ),
                _buildOptionCard(
                  icon: CupertinoIcons.question_circle_fill,
                  title: 'Quiz',
                  subtitle: 'Test your sports knowledge',
                  onTap: () => _navigateToScreen(const LeagueQuizScreen()),
                ),
                _buildOptionCard(
                  icon: CupertinoIcons.timer_fill,
                  title: 'Timer',
                  subtitle: 'Countdown timer for training',
                  onTap: () => _navigateToScreen(const GameTimerScreen()),
                ),
                _buildOptionCard(
                  icon: CupertinoIcons.pencil_ellipsis_rectangle,
                  title: 'Strategy',
                  subtitle: 'Draw plays and strategies',
                  onTap: () => _navigateToScreen(const GamePlanScreen()),
                ),
                const SizedBox(height: 32),
              ],
            ),
          ),
        ),
      ),
    );
  }
  
  Widget _buildOptionCard({
    required IconData icon,
    required String title,
    required String subtitle,
    required VoidCallback onTap,
  }) {
    return GradientCard(
      onTap: onTap,
      padding: const EdgeInsets.all(20),
      child: Row(
        children: [
          Container(
            width: 56,
            height: 56,
            decoration: BoxDecoration(
              gradient: AppColors.navyToBlueGradient,
              shape: BoxShape.circle,
              boxShadow: [
                BoxShadow(
                  color: AppColors.mediumBlue.withOpacity(0.4),
                  blurRadius: 15,
                  offset: const Offset(0, 5),
                ),
              ],
            ),
            child: Icon(
              icon,
              color: AppColors.whitePrimary,
              size: 28,
            ),
          ),
          const SizedBox(width: 20),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: const TextStyle(
                    color: AppColors.whitePrimary,
                    fontSize: 20,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  subtitle,
                  style: TextStyle(
                    color: AppColors.lightGrayAccent.withOpacity(0.8),
                    fontSize: 14,
                  ),
                ),
              ],
            ),
          ),
          const Icon(
            CupertinoIcons.chevron_right,
            color: AppColors.lightGrayAccent,
            size: 20,
          ),
        ],
      ),
    );
  }
}

