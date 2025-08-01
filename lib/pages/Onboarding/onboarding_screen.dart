import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:co/pages/Authentication/login.dart';
import 'package:co/pages/Onboarding/onboarding_info.dart';

class OnBoarding extends StatefulWidget {
  const OnBoarding({super.key});

  static Future<bool> shouldShowOnboarding() async {
    try {
      final prefs = await SharedPreferences.getInstance();
      return prefs.getBool('hasSeenOnboarding') != true;
    } on PlatformException catch (e) {
      debugPrint("SharedPreferences error: $e");
      return true; // Fallback to show onboarding
    }
  }

  @override
  State<OnBoarding> createState() => _OnBoardingState();
}

class _OnBoardingState extends State<OnBoarding> {
  final PageController _pageController = PageController();
  int _currentPage = 0;
  final int _pageCount = onboardingData.length;

  Future<void> _completeOnboarding() async {
    try {
      final prefs = await SharedPreferences.getInstance();
      await prefs.setBool('hasSeenOnboarding', true);
    } on PlatformException catch (e) {
      debugPrint("Error saving onboarding status: $e");
    }

    if (!mounted) return;
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(builder: (context) => const LoginPage()),
    );
  }

  void _nextPage() {
    if (_currentPage < _pageCount - 1) {
      _pageController.nextPage(
        duration: const Duration(milliseconds: 400),
        curve: Curves.easeInOut,
      );
    } else {
      _completeOnboarding();
    }
  }

  void _skipToEnd() {
    _pageController.animateToPage(
      _pageCount - 1,
      duration: const Duration(milliseconds: 400),
      curve: Curves.easeInOut,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          PageView(
            controller: _pageController,
            onPageChanged: (index) => setState(() => _currentPage = index),
            children: onboardingData.map((item) => _buildPage(item)).toList(),
          ),
          _buildNavigationControls(),
        ],
      ),
    );
  }

  Widget _buildPage(OnboardingInfo item) {
    return Padding(
      padding: const EdgeInsets.all(24.0),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Expanded(
            flex: 3,
            child: Image.asset(
              item.image,
              fit: BoxFit.contain,
            ),
          ),
          const SizedBox(height: 32),
          Text(
            item.title,
            style: const TextStyle(
              fontSize: 24,
              fontWeight: FontWeight.bold,
              color: Color.fromARGB(255, 143, 97, 6),
            ),
          ),
          const SizedBox(height: 16),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 24),
            child: Text(
              item.description,
              textAlign: TextAlign.center,
              style: const TextStyle(
                fontSize: 16,
                color: Colors.grey,
              ),
            ),
          ),
          const Spacer(),
        ],
      ),
    );
  }

  Widget _buildNavigationControls() {
    return Positioned(
      bottom: 40,
      left: 0,
      right: 0,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 24),
        child: Column(
          children: [
            SmoothPageIndicator(
              controller: _pageController,
              count: _pageCount,
              effect: const WormEffect(
                dotHeight: 10,
                dotWidth: 10,
                spacing: 8,
                activeDotColor: Color.fromARGB(255, 143, 97, 6),
                dotColor: Colors.grey,
              ),
            ),
            const SizedBox(height: 20),
            SizedBox(
              width: double.infinity,
              child: _currentPage == _pageCount - 1
                  ? _buildGetStartedButton()
                  : _buildSkipNextButtons(),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildGetStartedButton() {
    return ElevatedButton(
      onPressed: _completeOnboarding,
      style: ElevatedButton.styleFrom(
        backgroundColor: const Color.fromARGB(255, 143, 97, 6),
        padding: const EdgeInsets.symmetric(vertical: 16),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(12),
        ),
      ),
      child: const Text(
        'Get Started',
        style: TextStyle(
          color: Colors.white,
          fontSize: 16,
          fontWeight: FontWeight.bold,
        ),
      ),
    );
  }

  Widget _buildSkipNextButtons() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        TextButton(
          onPressed: _skipToEnd,
          child: const Text(
            'Skip',
            style: TextStyle(
              color: Color.fromARGB(255, 143, 97, 6),
              fontSize: 16,
            ),
          ),
        ),
        ElevatedButton(
          onPressed: _nextPage,
          style: ElevatedButton.styleFrom(
            backgroundColor: const Color.fromARGB(255, 143, 97, 6),
            padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(12),
            ),
          ),
          child: const Text(
            'Next',
            style: TextStyle(
              color: Colors.white,
              fontSize: 16,
            ),
          ),
        ),
      ],
    );
  }

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }
}