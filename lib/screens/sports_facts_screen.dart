import 'package:flutter/cupertino.dart';
import 'package:flutter/services.dart';
import '../utils/colors.dart';
import '../widgets/gradient_card.dart';
import '../widgets/storm_painter.dart';

class SportsFact {
  final String shortText;
  final String expandedText;
  
  SportsFact({
    required this.shortText,
    required this.expandedText,
  });
}

class SportsFactsScreen extends StatefulWidget {
  const SportsFactsScreen({super.key});
  
  @override
  State<SportsFactsScreen> createState() => _SportsFactsScreenState();
}

class _SportsFactsScreenState extends State<SportsFactsScreen>
    with SingleTickerProviderStateMixin {
  late AnimationController _stormController;
  final Set<int> _expandedFacts = {};
  
  final List<SportsFact> _facts = [
    SportsFact(
      shortText: 'Basketball was invented in 1891 by Dr. James Naismith as a way to keep students active during winter.',
      expandedText: 'Basketball was invented in 1891 by Dr. James Naismith, a Canadian physical education instructor at the International YMCA Training School in Springfield, Massachusetts. He created the game as a way to keep his students active during the cold winter months when outdoor activities were difficult. The original game had 13 basic rules and was played with a soccer ball and two peach baskets nailed to the gymnasium balcony. The first game was played on December 21, 1891, with 18 players (9 per team).',
    ),
    SportsFact(
      shortText: 'The first basketball game was played with a soccer ball and two peach baskets as goals.',
      expandedText: 'The first basketball game was played on December 21, 1891, using a soccer ball and two peach baskets that were nailed to the gymnasium balcony at a height of 10 feet. The baskets still had their bottoms, so after each score, someone had to climb a ladder to retrieve the ball. It wasn\'t until 1906 that metal hoops with open-ended nets were introduced, allowing the ball to fall through after scoring. The game was originally called "Naismith\'s game" before it was officially named basketball.',
    ),
    SportsFact(
      shortText: 'Michael Jordan missed more than 9,000 shots in his career, but he never gave up.',
      expandedText: 'Michael Jordan, widely considered the greatest basketball player of all time, missed over 9,000 shots in his career, lost almost 300 games, and failed 26 times on game-winning shots. However, he famously said, "I\'ve failed over and over and over again in my life. And that is why I succeed." This mindset of perseverance and learning from failure is what made him a 6-time NBA champion, 5-time MVP, and 14-time All-Star. His career shooting percentage was 49.7%, proving that even the best miss more than they make.',
    ),
    SportsFact(
      shortText: 'The fastest recorded basketball shot was 109.2 mph by a professional player.',
      expandedText: 'The fastest recorded basketball shot speed is 109.2 mph (175.7 km/h), achieved by professional basketball player during a shooting competition. For comparison, the average NBA player shoots at around 50-60 mph. This incredible speed demonstrates the power and technique required at the professional level. The speed of a shot is measured using specialized radar equipment, similar to what\'s used in baseball. Fast shots are particularly important for three-pointers and free throws, where speed can help overcome defensive pressure.',
    ),
    SportsFact(
      shortText: 'Basketball became an Olympic sport in 1936 at the Berlin Games.',
      expandedText: 'Basketball made its Olympic debut at the 1936 Berlin Games, 45 years after the sport was invented. The first Olympic basketball tournament was held outdoors on a tennis court, and the United States won the gold medal by defeating Canada 19-8 in the final. The game was played in front of Adolf Hitler, who left before the medal ceremony. Since then, basketball has been a permanent fixture at the Summer Olympics, with the United States dominating the men\'s competition (winning 15 of 19 gold medals) and the women\'s competition (winning 8 of 10 gold medals).',
    ),
    SportsFact(
      shortText: 'The tallest NBA player ever was Gheorghe Mureșan at 7 feet 7 inches.',
      expandedText: 'Gheorghe Mureșan, a Romanian center, holds the record as the tallest player in NBA history at 7 feet 7 inches (2.31 meters). He played in the NBA from 1993 to 2000, primarily for the Washington Bullets/Wizards and New Jersey Nets. Mureșan\'s incredible height was due to a pituitary gland condition called gigantism. Despite his height advantage, he averaged 9.8 points and 6.4 rebounds per game over his career. He won the NBA\'s Most Improved Player award in 1996. Other notable tall players include Manute Bol (7\'7"), Shawn Bradley (7\'6"), and Yao Ming (7\'6").',
    ),
    SportsFact(
      shortText: 'A regulation basketball court is 94 feet long and 50 feet wide.',
      expandedText: 'A regulation NBA basketball court measures exactly 94 feet (28.65 meters) in length and 50 feet (15.24 meters) in width. The court is divided into two main sections by the midcourt line, with each team defending one basket. The three-point line is 23 feet 9 inches from the basket at the top of the arc and 22 feet in the corners. The free-throw line is 15 feet from the backboard. The key (paint area) is 16 feet wide and extends 19 feet from the baseline. These dimensions are standardized across all NBA arenas, though international courts (FIBA) are slightly smaller at 28 meters by 15 meters.',
    ),
    SportsFact(
      shortText: 'The three-point line was introduced to the NBA in 1979.',
      expandedText: 'The three-point line was introduced to the NBA in the 1979-80 season, revolutionizing the game and adding a new strategic dimension. The first three-pointer in NBA history was made by Chris Ford of the Boston Celtics on October 12, 1979. Initially, the three-point line was 23 feet 9 inches from the basket (22 feet in the corners). The distance was shortened to 22 feet all around from 1994-1997 to encourage more three-point shooting, but was later restored to the original distance. Today, three-pointers account for over 35% of all field goal attempts in the NBA, with teams like the Golden State Warriors revolutionizing the game with their emphasis on long-range shooting.',
    ),
    SportsFact(
      shortText: 'Wilt Chamberlain scored 100 points in a single NBA game in 1962.',
      expandedText: 'On March 2, 1962, Wilt Chamberlain achieved the most unbreakable record in NBA history by scoring 100 points in a single game while playing for the Philadelphia Warriors against the New York Knicks. The game was played in Hershey, Pennsylvania, and Chamberlain made 36 of 63 field goals and 28 of 32 free throws. He also grabbed 25 rebounds in the game. This record has stood for over 60 years, with Kobe Bryant\'s 81-point game in 2006 being the closest anyone has come. Chamberlain averaged 50.4 points per game that entire season, another record that will likely never be broken. The game ended with the Warriors winning 169-147.',
    ),
    SportsFact(
      shortText: 'Basketball is played by over 450 million people worldwide.',
      expandedText: 'Basketball is one of the most popular sports globally, with over 450 million people playing the game worldwide. It\'s the second most popular sport in the United States (after American football) and has a massive following in countries like China, the Philippines, Spain, and throughout Europe. The NBA has expanded its global reach significantly, with games broadcast in over 200 countries and territories in more than 40 languages. The sport\'s popularity continues to grow, especially with the rise of international players in the NBA and the success of leagues like the EuroLeague. Basketball\'s accessibility (only needing a ball and a hoop) makes it one of the most played sports in the world.',
    ),
    SportsFact(
      shortText: 'The first basketball was brown, not orange. Orange was introduced in the 1950s.',
      expandedText: 'The original basketballs used in the early days of the sport were brown, made of leather panels stitched together. These balls were difficult to see on television and in dimly lit gymnasiums. In the 1950s, Tony Hinkle, a coach at Butler University, developed the now-familiar orange basketball to improve visibility. The orange color (officially called "Hinkle Orange") made the ball much easier to see for both players and spectators. The modern basketball is made of synthetic composite or leather, weighs between 20-22 ounces, and has a circumference of 29.5 inches for men and 28.5 inches for women. The distinctive black lines (seams) help players grip and control the ball.',
    ),
    SportsFact(
      shortText: 'The NBA was founded in 1946 as the Basketball Association of America (BAA).',
      expandedText: 'The NBA was founded on June 6, 1946, in New York City as the Basketball Association of America (BAA). The league started with 11 teams, including franchises in major cities like New York, Boston, Philadelphia, and Chicago. In 1949, the BAA merged with the National Basketball League (NBL) to form the National Basketball Association (NBA). The first game was played on November 1, 1946, between the New York Knicks and the Toronto Huskies. The league has grown from its original 11 teams to 30 teams today, with franchises across the United States and Canada. The NBA has become a global brand worth billions of dollars, with players earning millions and games broadcast worldwide.',
    ),
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
  
  @override
  Widget build(BuildContext context) {
    return CupertinoPageScaffold(
      backgroundColor: AppColors.deepNavy,
      navigationBar: const CupertinoNavigationBar(
        backgroundColor: AppColors.deepNavy,
        border: null,
        middle: Text(
          'Sports Facts',
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
          child: ListView.builder(
            padding: const EdgeInsets.all(16),
            itemCount: _facts.length,
            itemBuilder: (context, index) {
              final fact = _facts[index];
              final isExpanded = _expandedFacts.contains(index);
              
              return GradientCard(
                padding: const EdgeInsets.all(20),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Container(
                          width: 40,
                          height: 40,
                          decoration: BoxDecoration(
                            gradient: AppColors.navyToBlueGradient,
                            shape: BoxShape.circle,
                          ),
                          child: Center(
                            child: Text(
                              '${index + 1}',
                              style: const TextStyle(
                                color: AppColors.whitePrimary,
                                fontSize: 18,
                                fontWeight: FontWeight.w700,
                              ),
                            ),
                          ),
                        ),
                        const SizedBox(width: 16),
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                isExpanded ? fact.expandedText : fact.shortText,
                                style: TextStyle(
                                  color: AppColors.whitePrimary,
                                  fontSize: 16,
                                  height: 1.5,
                                ),
                              ),
                              const SizedBox(height: 12),
                              CupertinoButton(
                                padding: EdgeInsets.zero,
                                minSize: 0,
                                onPressed: () {
                                  setState(() {
                                    if (isExpanded) {
                                      _expandedFacts.remove(index);
                                    } else {
                                      _expandedFacts.add(index);
                                    }
                                  });
                                  HapticFeedback.lightImpact();
                                },
                                child: Row(
                                  mainAxisSize: MainAxisSize.min,
                                  children: [
                                    Text(
                                      isExpanded ? 'Read less' : 'Read more',
                                      style: TextStyle(
                                        color: AppColors.lightGrayAccent,
                                        fontSize: 14,
                                        fontWeight: FontWeight.w600,
                                      ),
                                    ),
                                    const SizedBox(width: 4),
                                    Icon(
                                      isExpanded
                                          ? CupertinoIcons.chevron_up
                                          : CupertinoIcons.chevron_down,
                                      color: AppColors.lightGrayAccent,
                                      size: 16,
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              );
            },
          ),
        ),
      ),
    );
  }
}

