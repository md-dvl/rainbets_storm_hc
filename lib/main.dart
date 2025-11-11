import 'package:flutter/cupertino.dart';
import 'package:rainbets_storm_hc/screens/initial_screen.dart';
import 'screens/home_screen.dart';
import 'screens/events_screen.dart';
import 'screens/profile_screen.dart';
import 'screens/settings_screen.dart';
import 'screens/onboarding_screen.dart';
import 'utils/colors.dart';

void main() {
  runApp(const RainbetsStormApp());
}

class RainbetsStormApp extends StatelessWidget {
  const RainbetsStormApp({super.key});

  @override
  Widget build(BuildContext context) {
    return CupertinoApp(
      title: "Rainbet's Storm",
      theme: const CupertinoThemeData(
        brightness: Brightness.dark,
        primaryColor: AppColors.mediumBlue,
        scaffoldBackgroundColor: AppColors.deepNavy,
        barBackgroundColor: AppColors.deepNavy,
        textTheme: CupertinoTextThemeData(
          textStyle: TextStyle(
            inherit: false,
            color: AppColors.whitePrimary,
            fontFamily: '.SF Pro Text',
          ),
          navTitleTextStyle: TextStyle(
            inherit: false,
            color: AppColors.whitePrimary,
            fontSize: 20,
            fontWeight: FontWeight.w600,
          ),
        ),
      ),
      home: const InitialScreen(),
      routes: {'/main': (context) => const MainTabScreen()},
      debugShowCheckedModeBanner: false,
    );
  }
}

class MainTabScreen extends StatefulWidget {
  const MainTabScreen({super.key});

  @override
  State<MainTabScreen> createState() => _MainTabScreenState();
}

class _MainTabScreenState extends State<MainTabScreen> {
  @override
  Widget build(BuildContext context) {
    return CupertinoTabScaffold(
      tabBar: CupertinoTabBar(
        backgroundColor: AppColors.deepNavy,
        activeColor: AppColors.lightGrayAccent,
        inactiveColor: AppColors.neutralGrayBlue,
        border: const Border(
          top: BorderSide(color: AppColors.mediumBlue, width: 0.5),
        ),
        items: [
          BottomNavigationBarItem(
            icon: const Icon(CupertinoIcons.house_fill),
            label: 'Home',
          ),
          BottomNavigationBarItem(
            icon: const Icon(CupertinoIcons.calendar),
            label: 'Events',
          ),
          BottomNavigationBarItem(
            icon: const Icon(CupertinoIcons.person_fill),
            label: 'Profile',
          ),
          BottomNavigationBarItem(
            icon: const Icon(CupertinoIcons.settings),
            label: 'Settings',
          ),
        ],
      ),
      tabBuilder: (context, index) {
        switch (index) {
          case 0:
            return CupertinoTabView(builder: (context) => const HomeScreen());
          case 1:
            return CupertinoTabView(builder: (context) => const EventsScreen());
          case 2:
            return CupertinoTabView(
              builder: (context) => const ProfileScreen(),
            );
          case 3:
            return CupertinoTabView(
              builder: (context) => const SettingsScreen(),
            );
          default:
            return CupertinoTabView(builder: (context) => const HomeScreen());
        }
      },
    );
  }
}
