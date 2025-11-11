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

  String _userName = 'User';
  int _selectedOverlayIndex = 0;
  double _overlayIntensity = 0.45;

  final List<List<Color>> _overlayPalettes = [
    [AppColors.mediumBlue, AppColors.deepNavy],
    [const Color.fromRGBO(123, 125, 143, 1.0), AppColors.deepNavy],
    [const Color.fromRGBO(95, 67, 178, 1.0), const Color.fromRGBO(34, 41, 120, 1.0)],
    [const Color.fromRGBO(189, 191, 199, 1.0), const Color.fromRGBO(57, 59, 88, 1.0)],
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

  LinearGradient _buildCurrentOverlayGradient(double? customIntensity, int? customIndex) {
    final colors = _overlayPalettes[customIndex ?? _selectedOverlayIndex];
    final intensity = customIntensity ?? _overlayIntensity;
    return LinearGradient(
      begin: Alignment.topLeft,
      end: Alignment.bottomRight,
      colors: colors
          .map((color) => color.withOpacity(intensity.clamp(0.2, 0.9)))
          .toList(),
    );
  }

  void _showEditProfileSheet() {
    final nameController = TextEditingController(text: _userName);
    int tempOverlayIndex = _selectedOverlayIndex;
    double tempIntensity = _overlayIntensity;

    showCupertinoModalPopup(
      context: context,
      builder: (context) {
        return StatefulBuilder(
          builder: (context, setSheetState) {
            final bottomInset = MediaQuery.of(context).viewInsets.bottom;
            return Padding(
              padding: EdgeInsets.only(bottom: bottomInset),
              child: Container(
                height: 430,
                decoration: BoxDecoration(
                  gradient: AppColors.cardGradient,
                  borderRadius: const BorderRadius.vertical(top: Radius.circular(24)),
                  border: Border.all(
                    color: AppColors.lightGrayAccent.withOpacity(0.2),
                    width: 1,
                  ),
                ),
                child: SafeArea(
                  top: false,
                  child: Column(
                    children: [
                      Padding(
                        padding: const EdgeInsets.fromLTRB(20, 16, 20, 8),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            const Text(
                              'Edit Profile',
                              style: TextStyle(
                                color: AppColors.whitePrimary,
                                fontSize: 18,
                                fontWeight: FontWeight.w700,
                              ),
                            ),
                            CupertinoButton(
                              padding: EdgeInsets.zero,
                              minSize: 0,
                              onPressed: () => Navigator.of(context).pop(),
                              child: const Icon(
                                CupertinoIcons.xmark_circle_fill,
                                color: AppColors.lightGrayAccent,
                                size: 26,
                              ),
                            ),
                          ],
                        ),
                      ),
                      Expanded(
                        child: SingleChildScrollView(
                          padding: const EdgeInsets.symmetric(horizontal: 20),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              const Text(
                                'Display Name',
                                style: TextStyle(
                                  color: AppColors.lightGrayAccent,
                                  fontSize: 14,
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                              const SizedBox(height: 8),
                              CupertinoTextField(
                                controller: nameController,
                                placeholder: 'Enter name',
                                padding: const EdgeInsets.all(14),
                                decoration: BoxDecoration(
                                  color: AppColors.mediumBlue.withOpacity(0.3),
                                  borderRadius: BorderRadius.circular(12),
                                  border: Border.all(
                                    color: AppColors.lightGrayAccent.withOpacity(0.25),
                                    width: 1,
                                  ),
                                ),
                                style: const TextStyle(
                                  color: AppColors.whitePrimary,
                                  fontSize: 16,
                                ),
                                placeholderStyle: TextStyle(
                                  color: AppColors.lightGrayAccent.withOpacity(0.5),
                                ),
                              ),
                              const SizedBox(height: 18),
                              const Text(
                                'Avatar Overlay',
                                style: TextStyle(
                                  color: AppColors.lightGrayAccent,
                                  fontSize: 14,
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                              const SizedBox(height: 12),
                              SizedBox(
                                height: 70,
                                child: ListView.builder(
                                  scrollDirection: Axis.horizontal,
                                  itemCount: _overlayPalettes.length,
                                  itemBuilder: (context, index) {
                                    final gradient = _buildCurrentOverlayGradient(tempIntensity, index);
                                    final isSelected = tempOverlayIndex == index;
                                    return GestureDetector(
                                      onTap: () {
                                        setSheetState(() => tempOverlayIndex = index);
                                      },
                                      child: AnimatedContainer(
                                        duration: const Duration(milliseconds: 250),
                                        margin: EdgeInsets.only(
                                          right: index == _overlayPalettes.length - 1 ? 0 : 14,
                                        ),
                                        width: 60,
                                        decoration: BoxDecoration(
                                          gradient: gradient,
                                          borderRadius: BorderRadius.circular(16),
                                          border: Border.all(
                                            color: isSelected
                                                ? AppColors.whitePrimary
                                                : AppColors.lightGrayAccent.withOpacity(0.2),
                                            width: isSelected ? 2 : 1,
                                          ),
                                          boxShadow: [
                                            BoxShadow(
                                              color: AppColors.mediumBlue.withOpacity(0.3),
                                              blurRadius: 12,
                                              offset: const Offset(0, 6),
                                            ),
                                          ],
                                        ),
                                      ),
                                    );
                                  },
                                  padding: EdgeInsets.zero,
                                ),
                              ),
                              const SizedBox(height: 24),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: [
                                  const Text(
                                    'Overlay Intensity',
                                    style: TextStyle(
                                      color: AppColors.lightGrayAccent,
                                      fontSize: 14,
                                      fontWeight: FontWeight.w600,
                                    ),
                                  ),
                                  Text(
                                    '${(tempIntensity * 100).round()}%',
                                    style: TextStyle(
                                      color: AppColors.lightGrayAccent.withOpacity(0.8),
                                      fontSize: 14,
                                    ),
                                  ),
                                ],
                              ),
                              CupertinoSlider(
                                value: tempIntensity,
                                min: 0.2,
                                max: 0.8,
                                onChanged: (value) {
                                  setSheetState(() => tempIntensity = value);
                                },
                                activeColor: AppColors.lightGrayAccent,
                              ),
                              const SizedBox(height: 12),
                            ],
                          ),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(20),
                        child: Row(
                          children: [
                            Expanded(
                              child: CupertinoButton(
                                color: AppColors.mediumBlue.withOpacity(0.3),
                                borderRadius: BorderRadius.circular(12),
                                onPressed: () {
                                  Navigator.of(context).pop();
                                },
                                child: const Text(
                                  'Cancel',
                                  style: TextStyle(color: AppColors.whitePrimary),
                                ),
                              ),
                            ),
                            const SizedBox(width: 12),
                            Expanded(
                              child: CupertinoButton(
                                color: AppColors.mediumBlue,
                                borderRadius: BorderRadius.circular(12),
                                onPressed: () {
                                  setState(() {
                                    final trimmed = nameController.text.trim();
                                    _userName = trimmed.isEmpty ? 'User' : trimmed;
                                    _selectedOverlayIndex = tempOverlayIndex;
                                    _overlayIntensity = tempIntensity;
                                  });
                                  Navigator.of(context).pop();
                                },
                                child: const Text(
                                  'Save',
                                  style: TextStyle(color: AppColors.whitePrimary),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            );
          },
        );
      },
    ).whenComplete(() => nameController.dispose());
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
                  child: GestureDetector(
                    onTap: _showEditProfileSheet,
                    child: Stack(
                      clipBehavior: Clip.none,
                      children: [
                        Container(
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
                            child: Stack(
                              children: [
                                Image.asset(
                                  'assets/player.jpeg',
                                  fit: BoxFit.cover,
                                  width: double.infinity,
                                  height: double.infinity,
                                ),
                                Container(
                                  decoration: BoxDecoration(
                                    gradient: _buildCurrentOverlayGradient(null, null),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                        Positioned(
                          bottom: -6,
                          right: 6,
                          child: Container(
                            padding: const EdgeInsets.all(6),
                            decoration: BoxDecoration(
                              color: AppColors.mediumBlue,
                              shape: BoxShape.circle,
                              border: Border.all(
                                color: AppColors.lightGrayAccent.withOpacity(0.8),
                                width: 1,
                              ),
                              boxShadow: [
                                BoxShadow(
                                  color: AppColors.mediumBlue.withOpacity(0.4),
                                  blurRadius: 10,
                                  offset: const Offset(0, 4),
                                ),
                              ],
                            ),
                            child: const Icon(
                              CupertinoIcons.pencil,
                              color: AppColors.whitePrimary,
                              size: 16,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                const SizedBox(height: 20),
                // Username
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Flexible(
                      child: Text(
                        _userName,
                        overflow: TextOverflow.ellipsis,
                        style: const TextStyle(
                          color: AppColors.whitePrimary,
                          fontSize: 28,
                          fontWeight: FontWeight.w700,
                        ),
                      ),
                    ),
                    const SizedBox(width: 8),
                    CupertinoButton(
                      padding: EdgeInsets.zero,
                      minSize: 0,
                      onPressed: _showEditProfileSheet,
                      child: const Icon(
                        CupertinoIcons.pencil_circle_fill,
                        color: AppColors.lightGrayAccent,
                        size: 26,
                      ),
                    ),
                  ],
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

