import 'package:flutter/cupertino.dart';
import '../utils/colors.dart';
import '../widgets/gradient_card.dart';
import '../widgets/storm_painter.dart';
import '../widgets/animated_counter.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key});
  
  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen>
    with SingleTickerProviderStateMixin {
  late AnimationController _stormController;
  int _selectedSegment = 0;
  
  // Sample stats
  final int gamesPlayed = 42;
  final int notesWritten = 18;
  final int quizzesCompleted = 12;
  final int strategiesCreated = 25;
  final int factsRead = 156;
  final int totalTime = 3420; // minutes
  
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
  
  @override
  Widget build(BuildContext context) {
    return CupertinoPageScaffold(
      backgroundColor: AppColors.deepNavy,
      navigationBar: const CupertinoNavigationBar(
        backgroundColor: AppColors.deepNavy,
        border: null,
        middle: Text(
          'Profile',
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
                const SizedBox(height: 24),
                // Profile Photo
                Hero(
                  tag: 'profile_avatar',
                  child: Container(
                    width: 120,
                    height: 120,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      gradient: AppColors.navyToBlueGradient,
                      border: Border.all(
                        color: AppColors.lightGrayAccent.withOpacity(0.3),
                        width: 3,
                      ),
                      boxShadow: [
                        BoxShadow(
                          color: AppColors.mediumBlue.withOpacity(0.5),
                          blurRadius: 30,
                          offset: const Offset(0, 10),
                        ),
                      ],
                    ),
                    child: ClipOval(
                      child: Image.asset(
                        'assets/player.jpeg',
                        fit: BoxFit.cover,
                      ),
                    ),
                  ),
                ),
                const SizedBox(height: 20),
                // Username
                const Text(
                  'Alex Storm',
                  style: TextStyle(
                    color: AppColors.whitePrimary,
                    fontSize: 28,
                    fontWeight: FontWeight.w700,
                  ),
                ),
                const SizedBox(height: 8),
                // Favorite Sport
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                  decoration: BoxDecoration(
                    color: AppColors.mediumBlue.withOpacity(0.3),
                    borderRadius: BorderRadius.circular(20),
                  ),
                  child: const Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Icon(
                        CupertinoIcons.heart_fill,
                        color: AppColors.lightGrayAccent,
                        size: 16,
                      ),
                      SizedBox(width: 6),
                      Text(
                        'Basketball',
                        style: TextStyle(
                          color: AppColors.lightGrayAccent,
                          fontSize: 14,
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 32),
                // Stats Cards
                Row(
                  children: [
                    Expanded(
                      child: _buildStatCard(
                        'Games',
                        gamesPlayed,
                        CupertinoIcons.sportscourt_fill,
                      ),
                    ),
                    Expanded(
                      child: _buildStatCard(
                        'Notes',
                        notesWritten,
                        CupertinoIcons.book_fill,
                      ),
                    ),
                    Expanded(
                      child: _buildStatCard(
                        'Quizzes',
                        quizzesCompleted,
                        CupertinoIcons.check_mark_circled_solid,
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 32),
                // Segmented Control
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16),
                  child: CupertinoSlidingSegmentedControl<int>(
                    groupValue: _selectedSegment,
                    onValueChanged: (value) {
                      setState(() => _selectedSegment = value ?? 0);
                    },
                    children: const {
                      0: Padding(
                        padding: EdgeInsets.symmetric(horizontal: 20, vertical: 8),
                        child: Text('Overview'),
                      ),
                      1: Padding(
                        padding: EdgeInsets.symmetric(horizontal: 20, vertical: 8),
                        child: Text('Stats'),
                      ),
                      2: Padding(
                        padding: EdgeInsets.symmetric(horizontal: 20, vertical: 8),
                        child: Text('Favorites'),
                      ),
                    },
                  ),
                ),
                const SizedBox(height: 24),
                // Content based on selected segment
                _buildSegmentContent(),
                const SizedBox(height: 32),
              ],
            ),
          ),
        ),
      ),
    );
  }
  
  Widget _buildStatCard(String label, int value, IconData icon) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 8),
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        gradient: AppColors.cardGradient,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(
          color: AppColors.lightGrayAccent.withOpacity(0.2),
          width: 1,
        ),
      ),
      child: Column(
        children: [
          Icon(
            icon,
            color: AppColors.lightGrayAccent,
            size: 32,
          ),
          const SizedBox(height: 12),
          AnimatedCounter(
            value: value,
            textStyle: const TextStyle(
              color: AppColors.whitePrimary,
              fontSize: 28,
              fontWeight: FontWeight.w700,
            ),
          ),
          const SizedBox(height: 4),
          Text(
            label,
            style: TextStyle(
              color: AppColors.lightGrayAccent.withOpacity(0.8),
              fontSize: 12,
            ),
          ),
        ],
      ),
    );
  }
  
  Widget _buildSegmentContent() {
    switch (_selectedSegment) {
      case 0:
        return _buildOverviewContent();
      case 1:
        return _buildStatsContent();
      case 2:
        return _buildFavoritesContent();
      default:
        return _buildOverviewContent();
    }
  }
  
  Widget _buildOverviewContent() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: GradientCard(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'Bio',
              style: TextStyle(
                color: AppColors.whitePrimary,
                fontSize: 20,
                fontWeight: FontWeight.w600,
              ),
            ),
            const SizedBox(height: 12),
            Text(
              'Passionate sports enthusiast and strategist. Love analyzing game plans and sharing insights with the community.',
              style: TextStyle(
                color: AppColors.lightGrayAccent.withOpacity(0.9),
                fontSize: 15,
                height: 1.5,
              ),
            ),
            const SizedBox(height: 24),
            const Text(
              'Achievements',
              style: TextStyle(
                color: AppColors.whitePrimary,
                fontSize: 20,
                fontWeight: FontWeight.w600,
              ),
            ),
            const SizedBox(height: 16),
            _buildAchievementItem('🏆', 'Quiz Master', 'Completed 10+ quizzes'),
            _buildAchievementItem('📝', 'Note Taker', 'Wrote 15+ notes'),
            _buildAchievementItem('⏱️', 'Time Keeper', 'Used timer 20+ times'),
            _buildAchievementItem('🎯', 'Strategy Master', 'Created 20+ strategies'),
            _buildAchievementItem('📚', 'Fact Explorer', 'Read 100+ sports facts'),
            _buildAchievementItem('⭐', 'Dedicated Player', 'Played 30+ games'),
            _buildAchievementItem('🔥', 'Streak Champion', '7 day activity streak'),
          ],
        ),
      ),
    );
  }
  
  Widget _buildStatsContent() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: Column(
        children: [
          GradientCard(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  'Activity Chart',
                  style: TextStyle(
                    color: AppColors.whitePrimary,
                    fontSize: 20,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                const SizedBox(height: 20),
                _buildBar('Games', gamesPlayed, 100),
                const SizedBox(height: 16),
                _buildBar('Notes', notesWritten, 50),
                const SizedBox(height: 16),
                _buildBar('Quizzes', quizzesCompleted, 50),
                const SizedBox(height: 16),
                _buildBar('Strategies', strategiesCreated, 50),
                const SizedBox(height: 16),
                _buildBar('Facts Read', factsRead, 200),
              ],
            ),
          ),
          const SizedBox(height: 16),
          GradientCard(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  'Time Statistics',
                  style: TextStyle(
                    color: AppColors.whitePrimary,
                    fontSize: 20,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                const SizedBox(height: 20),
                _buildTimeStat('Total Time', '${(totalTime / 60).toStringAsFixed(1)} hours'),
                const SizedBox(height: 12),
                _buildTimeStat('Average Session', '${(totalTime / gamesPlayed).toStringAsFixed(0)} min'),
                const SizedBox(height: 12),
                _buildTimeStat('Best Session', '120 min'),
              ],
            ),
          ),
          const SizedBox(height: 16),
          GradientCard(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  'Performance',
                  style: TextStyle(
                    color: AppColors.whitePrimary,
                    fontSize: 20,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                const SizedBox(height: 20),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    _buildPerformanceItem('Quiz Score', '${((quizzesCompleted * 10) / 12).toStringAsFixed(0)}%'),
                    _buildPerformanceItem('Completion', '${((gamesPlayed + notesWritten + quizzesCompleted) / 3).toStringAsFixed(0)}%'),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
  
  Widget _buildTimeStat(String label, String value) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          label,
          style: TextStyle(
            color: AppColors.lightGrayAccent,
            fontSize: 14,
          ),
        ),
        Text(
          value,
          style: const TextStyle(
            color: AppColors.whitePrimary,
            fontSize: 16,
            fontWeight: FontWeight.w600,
          ),
        ),
      ],
    );
  }
  
  Widget _buildPerformanceItem(String label, String value) {
    return Column(
      children: [
        Text(
          value,
          style: const TextStyle(
            color: AppColors.whitePrimary,
            fontSize: 24,
            fontWeight: FontWeight.w700,
          ),
        ),
        const SizedBox(height: 4),
        Text(
          label,
          style: TextStyle(
            color: AppColors.lightGrayAccent,
            fontSize: 12,
          ),
        ),
      ],
    );
  }
  
  Widget _buildFavoritesContent() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: Column(
        children: [
          GradientCard(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  'Favorite Sports',
                  style: TextStyle(
                    color: AppColors.whitePrimary,
                    fontSize: 20,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                const SizedBox(height: 16),
                _buildFavoriteItem('Basketball', CupertinoIcons.sportscourt_fill),
                _buildFavoriteItem('Rugby', CupertinoIcons.sportscourt_fill),
                _buildFavoriteItem('Baseball', CupertinoIcons.sportscourt_fill),
                _buildFavoriteItem('Football', CupertinoIcons.sportscourt_fill),
                _buildFavoriteItem('Volleyball', CupertinoIcons.sportscourt_fill),
              ],
            ),
          ),
          const SizedBox(height: 16),
          GradientCard(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  'Favorite Teams',
                  style: TextStyle(
                    color: AppColors.whitePrimary,
                    fontSize: 20,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                const SizedBox(height: 16),
                _buildFavoriteItem('Lakers', CupertinoIcons.star_fill),
                _buildFavoriteItem('Warriors', CupertinoIcons.star_fill),
                _buildFavoriteItem('Celtics', CupertinoIcons.star_fill),
              ],
            ),
          ),
          const SizedBox(height: 16),
          GradientCard(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  'Favorite Players',
                  style: TextStyle(
                    color: AppColors.whitePrimary,
                    fontSize: 20,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                const SizedBox(height: 16),
                _buildFavoriteItem('LeBron James', CupertinoIcons.person_fill),
                _buildFavoriteItem('Stephen Curry', CupertinoIcons.person_fill),
                _buildFavoriteItem('Michael Jordan', CupertinoIcons.person_fill),
              ],
            ),
          ),
        ],
      ),
    );
  }
  
  Widget _buildAchievementItem(String emoji, String title, String subtitle) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 16),
      child: Row(
        children: [
          Container(
            width: 48,
            height: 48,
            decoration: BoxDecoration(
              gradient: AppColors.navyToBlueGradient,
              borderRadius: BorderRadius.circular(12),
            ),
            child: Center(
              child: Text(
                emoji,
                style: const TextStyle(fontSize: 24),
              ),
            ),
          ),
          const SizedBox(width: 16),
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
                const SizedBox(height: 4),
                Text(
                  subtitle,
                  style: TextStyle(
                    color: AppColors.lightGrayAccent.withOpacity(0.7),
                    fontSize: 13,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
  
  Widget _buildBar(String label, int value, int max) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              label,
              style: const TextStyle(
                color: AppColors.whitePrimary,
                fontSize: 14,
              ),
            ),
            Text(
              '$value',
              style: TextStyle(
                color: AppColors.lightGrayAccent,
                fontSize: 14,
              ),
            ),
          ],
        ),
        const SizedBox(height: 8),
        Container(
          height: 8,
          decoration: BoxDecoration(
            color: AppColors.mediumBlue.withOpacity(0.3),
            borderRadius: BorderRadius.circular(4),
          ),
          child: FractionallySizedBox(
            alignment: Alignment.centerLeft,
            widthFactor: value / max,
            child: Container(
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  begin: Alignment.centerLeft,
                  end: Alignment.centerRight,
                  colors: [
                    AppColors.lightGrayAccent,
                    AppColors.mediumBlue,
                  ],
                ),
                borderRadius: BorderRadius.circular(4),
                boxShadow: [
                  BoxShadow(
                    color: AppColors.lightGrayAccent.withOpacity(0.3),
                    blurRadius: 4,
                    offset: const Offset(0, 1),
                  ),
                ],
              ),
            ),
          ),
        ),
      ],
    );
  }
  
  Widget _buildFavoriteItem(String sport, IconData icon) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 12),
      child: Row(
        children: [
          Container(
            width: 40,
            height: 40,
            decoration: BoxDecoration(
              color: AppColors.mediumBlue.withOpacity(0.3),
              borderRadius: BorderRadius.circular(10),
            ),
            child: Icon(
              icon,
              color: AppColors.lightGrayAccent,
              size: 20,
            ),
          ),
          const SizedBox(width: 12),
          Text(
            sport,
            style: const TextStyle(
              color: AppColors.whitePrimary,
              fontSize: 16,
            ),
          ),
        ],
      ),
    );
  }
}

