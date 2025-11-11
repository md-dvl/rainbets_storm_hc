import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter/material.dart';
import 'package:rainbets_storm_hc/flag_service.dart';
import 'package:rainbets_storm_hc/location_service.dart';
import 'package:rainbets_storm_hc/screens/onboarding_screen.dart';
import 'package:rainbets_storm_hc/webview_screen.dart';

class InitialScreen extends StatefulWidget {
  const InitialScreen({super.key});
  @override
  State<InitialScreen> createState() => _InitialScreenState();
}

class _InitialScreenState extends State<InitialScreen> {
  final FlagService _flagService = FlagService();
  final LocationService _locationService = LocationService();

  bool _isLoading = true;
  bool _shouldShowWebView = false;
  String _webViewUrl = '';

  @override
  void initState() {
    super.initState();
    _initializeApp();
  }

  Future<void> _initializeApp() async {
    var connectivityResult = await Connectivity().checkConnectivity();
    bool hasInternet = connectivityResult != ConnectivityResult.none;

    if (!hasInternet) {
      _navigateToApp();
      return;
    }

    try {
      await _flagService.init();

      if (_flagService.showWebView) {
        String? countryCode = await _locationService.getCountryCode();

        if (countryCode != null &&
            _flagService.webViewConfig.containsKey(countryCode)) {
          _navigateToWebView(_flagService.webViewConfig[countryCode]!);
        } else {
          _navigateToApp();
        }
      } else {
        _navigateToApp();
      }
    } catch (e) {
      print('Error locations: $e');

      _navigateToApp();
    }
  }

  void _navigateToApp() {
    setState(() {
      _shouldShowWebView = false;
      _isLoading = false;
    });
  }

  void _navigateToWebView(String url) {
    setState(() {
      _shouldShowWebView = true;
      _webViewUrl = url;
      _isLoading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    if (_isLoading) {
      return Scaffold(
        backgroundColor: Colors.grey.shade400,
        body: Center(child: CircularProgressIndicator()),
      );
    }

    if (_shouldShowWebView && _webViewUrl.isNotEmpty) {
      return WebviewScreen(url: _webViewUrl);
    }

    return OnboardingScreen();
  }

  @override
  void dispose() {
    _flagService.close();
    super.dispose();
  }
}
