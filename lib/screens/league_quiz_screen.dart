import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import '../utils/colors.dart';
import '../widgets/gradient_card.dart';
import '../widgets/storm_painter.dart';

class LeagueQuizScreen extends StatefulWidget {
  const LeagueQuizScreen({super.key});
  
  @override
  State<LeagueQuizScreen> createState() => _LeagueQuizScreenState();
}

class _LeagueQuizScreenState extends State<LeagueQuizScreen>
    with SingleTickerProviderStateMixin {
  late AnimationController _stormController;
  int _currentQuestion = 0;
  int? _selectedAnswer;
  int _score = 0;
  bool _showResult = false;
  
  final List<Map<String, dynamic>> _questions = [
    {
      'question': 'Who scored 100 points in a single NBA game?',
      'answers': ['Wilt Chamberlain', 'Michael Jordan', 'Kobe Bryant', 'LeBron James'],
      'correct': 0,
    },
    {
      'question': 'When was basketball invented?',
      'answers': ['1885', '1891', '1900', '1895'],
      'correct': 1,
    },
    {
      'question': 'How many players are on the court per team in basketball?',
      'answers': ['4', '5', '6', '7'],
      'correct': 1,
    },
    {
      'question': 'What is the diameter of a basketball hoop?',
      'answers': ['16 inches', '18 inches', '20 inches', '22 inches'],
      'correct': 1,
    },
    {
      'question': 'Which team has won the most NBA championships?',
      'answers': ['Chicago Bulls', 'Los Angeles Lakers', 'Boston Celtics', 'Golden State Warriors'],
      'correct': 2,
    },
    {
      'question': 'What is the height of a basketball hoop from the floor?',
      'answers': ['8 feet', '9 feet', '10 feet', '11 feet'],
      'correct': 2,
    },
    {
      'question': 'How long is a regulation NBA game?',
      'answers': ['40 minutes', '48 minutes', '50 minutes', '60 minutes'],
      'correct': 1,
    },
    {
      'question': 'Which player is known as "The King"?',
      'answers': ['Kobe Bryant', 'LeBron James', 'Michael Jordan', 'Stephen Curry'],
      'correct': 1,
    },
    {
      'question': 'What is the three-point line distance in the NBA?',
      'answers': ['22 feet', '23 feet 9 inches', '24 feet', '25 feet'],
      'correct': 1,
    },
    {
      'question': 'How many quarters are in an NBA game?',
      'answers': ['2', '3', '4', '5'],
      'correct': 2,
    },
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
  
  void _selectAnswer(int index) {
    setState(() {
      _selectedAnswer = index;
    });
    HapticFeedback.mediumImpact();
    
    Future.delayed(const Duration(milliseconds: 500), () {
      if (_selectedAnswer == _questions[_currentQuestion]['correct']) {
        setState(() => _score++);
      }
      
      if (_currentQuestion < _questions.length - 1) {
        setState(() {
          _currentQuestion++;
          _selectedAnswer = null;
        });
      } else {
        setState(() => _showResult = true);
      }
    });
  }
  
  void _resetQuiz() {
    setState(() {
      _currentQuestion = 0;
      _selectedAnswer = null;
      _score = 0;
      _showResult = false;
    });
  }
  
  @override
  Widget build(BuildContext context) {
    return CupertinoPageScaffold(
      backgroundColor: AppColors.deepNavy,
      navigationBar: const CupertinoNavigationBar(
        backgroundColor: AppColors.deepNavy,
        border: null,
        middle: Text(
          'League Quiz',
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
          child: _showResult
              ? _buildResultScreen()
              : _buildQuestionScreen(),
        ),
      ),
    );
  }
  
  Widget _buildQuestionScreen() {
    final question = _questions[_currentQuestion];
    
    return Padding(
      padding: const EdgeInsets.all(16),
      child: Column(
        children: [
          const SizedBox(height: 20),
          // Progress indicator
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                'Question ${_currentQuestion + 1}/${_questions.length}',
                style: TextStyle(
                  color: AppColors.lightGrayAccent,
                  fontSize: 14,
                ),
              ),
              Text(
                'Score: $_score',
                style: const TextStyle(
                  color: AppColors.whitePrimary,
                  fontSize: 16,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ],
          ),
          const SizedBox(height: 16),
          Container(
            height: 4,
            decoration: BoxDecoration(
              color: AppColors.mediumBlue.withOpacity(0.3),
              borderRadius: BorderRadius.circular(2),
            ),
            child: FractionallySizedBox(
              alignment: Alignment.centerLeft,
              widthFactor: (_currentQuestion + 1) / _questions.length,
              child: Container(
                decoration: BoxDecoration(
                  gradient: AppColors.navyToBlueGradient,
                  borderRadius: BorderRadius.circular(2),
                ),
              ),
            ),
          ),
          const SizedBox(height: 40),
          // Question
          GradientCard(
            child: Text(
              question['question'],
              style: const TextStyle(
                color: AppColors.whitePrimary,
                fontSize: 22,
                fontWeight: FontWeight.w700,
                height: 1.4,
              ),
              textAlign: TextAlign.center,
            ),
          ),
          const SizedBox(height: 32),
          // Answers
          Expanded(
            child: ListView.builder(
              itemCount: (question['answers'] as List).length,
              itemBuilder: (context, index) {
                final answer = question['answers'][index];
                final isSelected = _selectedAnswer == index;
                final isCorrect = index == question['correct'];
                
                return Padding(
                  padding: const EdgeInsets.only(bottom: 12),
                  child: GestureDetector(
                    onTap: _selectedAnswer == null
                        ? () => _selectAnswer(index)
                        : null,
                    child: AnimatedContainer(
                      duration: const Duration(milliseconds: 200),
                      padding: const EdgeInsets.all(20),
                      decoration: BoxDecoration(
                        gradient: isSelected
                            ? (isCorrect
                                ? AppColors.navyToBlueGradient
                                : LinearGradient(
                                    colors: [
                                      Colors.red.withOpacity(0.3),
                                      Colors.red.withOpacity(0.1),
                                    ],
                                  ))
                            : null,
                        color: isSelected
                            ? null
                            : AppColors.mediumBlue.withOpacity(0.3),
                        borderRadius: BorderRadius.circular(16),
                        border: Border.all(
                          color: isSelected
                              ? (isCorrect
                                  ? AppColors.lightGrayAccent
                                  : Colors.red)
                              : AppColors.neutralGrayBlue.withOpacity(0.3),
                          width: isSelected ? 2 : 1,
                        ),
                      ),
                      child: Row(
                        children: [
                          Container(
                            width: 32,
                            height: 32,
                            decoration: BoxDecoration(
                              color: isSelected
                                  ? (isCorrect
                                      ? AppColors.lightGrayAccent
                                      : Colors.red)
                                  : AppColors.neutralGrayBlue.withOpacity(0.3),
                              shape: BoxShape.circle,
                            ),
                            child: Center(
                              child: Text(
                                String.fromCharCode(65 + index), // A, B, C, D
                                style: TextStyle(
                                  color: isSelected
                                      ? AppColors.deepNavy
                                      : AppColors.whitePrimary,
                                  fontSize: 16,
                                  fontWeight: FontWeight.w700,
                                ),
                              ),
                            ),
                          ),
                          const SizedBox(width: 16),
                          Expanded(
                            child: Text(
                              answer,
                              style: TextStyle(
                                color: AppColors.whitePrimary,
                                fontSize: 16,
                                fontWeight: isSelected
                                    ? FontWeight.w600
                                    : FontWeight.normal,
                              ),
                            ),
                          ),
                          if (isSelected)
                            Icon(
                              isCorrect
                                  ? CupertinoIcons.check_mark_circled_solid
                                  : CupertinoIcons.clear_circled_solid,
                              color: isCorrect
                                  ? AppColors.lightGrayAccent
                                  : Colors.red,
                              size: 24,
                            ),
                        ],
                      ),
                    ),
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
  
  Widget _buildResultScreen() {
    final percentage = (_score / _questions.length * 100).round();
    
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(24),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              width: 120,
              height: 120,
              decoration: BoxDecoration(
                gradient: AppColors.navyToBlueGradient,
                shape: BoxShape.circle,
                boxShadow: [
                  BoxShadow(
                    color: AppColors.mediumBlue.withOpacity(0.5),
                    blurRadius: 30,
                    offset: const Offset(0, 10),
                  ),
                ],
              ),
              child: const Icon(
                CupertinoIcons.check_mark_circled_solid,
                color: AppColors.whitePrimary,
                size: 64,
              ),
            ),
            const SizedBox(height: 32),
            Text(
              'Quiz Complete!',
              style: const TextStyle(
                color: AppColors.whitePrimary,
                fontSize: 32,
                fontWeight: FontWeight.w700,
              ),
            ),
            const SizedBox(height: 16),
            GradientCard(
              child: Column(
                children: [
                  Text(
                    '$_score / ${_questions.length}',
                    style: const TextStyle(
                      color: AppColors.whitePrimary,
                      fontSize: 48,
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                  const SizedBox(height: 8),
                  Text(
                    '$percentage% Correct',
                    style: TextStyle(
                      color: AppColors.lightGrayAccent,
                      fontSize: 18,
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 32),
            CupertinoButton(
              padding: EdgeInsets.zero,
              onPressed: _resetQuiz,
              child: Container(
                width: double.infinity,
                padding: const EdgeInsets.all(16),
                decoration: BoxDecoration(
                  gradient: AppColors.navyToBlueGradient,
                  borderRadius: BorderRadius.circular(16),
                ),
                child: const Text(
                  'Try Again',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    color: AppColors.whitePrimary,
                    fontSize: 18,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

