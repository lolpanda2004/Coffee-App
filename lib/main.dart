import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:co/pages/Onboarding/onboarding_screen.dart';
import 'package:co/pages/Authentication/login.dart';
import 'package:co/pages/Authentication/signup.dart';
import 'package:co/pages/Authentication/forgot_password.dart';
import 'package:co/pages/Home/home.dart'; // Create this for your main app

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  
  // Initialize Firebase
  await Firebase.initializeApp(
    options: const FirebaseOptions(
      apiKey: "YOUR_API_KEY",
      appId: "YOUR_APP_ID",
      messagingSenderId: "YOUR_SENDER_ID",
      projectId: "YOUR_PROJECT_ID",
      // Add other required options for your platforms
    ),
  );

  // Check auth state and onboarding status
  final authState = await _checkAuthState();
  
  runApp(MyApp(initialRoute: authState));
}

Future<String> _checkAuthState() async {
  final showOnboarding = await OnBoarding.shouldShowOnboarding();
  final user = FirebaseAuth.instance.currentUser;

  if (showOnboarding) return '/onboarding';
  if (user != null && user.emailVerified) return '/home';
  return '/login';
}

class MyApp extends StatelessWidget {
  final String initialRoute;

  const MyApp({super.key, required this.initialRoute});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Cofe App',
      theme: _buildThemeData(),
      initialRoute: initialRoute,
      routes: {
        '/onboarding': (context) => const OnBoarding(),
        '/login': (context) => const LoginPage(),
        '/signup': (context) => const SignUpPage(),
        '/home': (context) => const HomeScreen(),
        '/forgot-password': (context) => const ForgotPasswordPage(),
      },
      onGenerateRoute: (settings) {
        // Handle any undefined routes
        return MaterialPageRoute(
          builder: (context) => const LoginPage(),
        );
      },
    );
  }

  ThemeData _buildThemeData() {
    return ThemeData(
      colorScheme: ColorScheme.fromSeed(
        seedColor: const Color.fromARGB(255, 205, 179, 117),
        primary: const Color.fromARGB(255, 143, 97, 6),
        secondary: const Color.fromARGB(255, 205, 179, 117),
      ),
      useMaterial3: true,
      inputDecorationTheme: InputDecorationTheme(
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
        ),
        focusedBorder: OutlineInputBorder(
          borderSide: const BorderSide(
            color: Color.fromARGB(255, 143, 97, 6),
            width: 2,
          ),
          borderRadius: BorderRadius.circular(12),
        ),
      ),
      elevatedButtonTheme: ElevatedButtonThemeData(
        style: ElevatedButton.styleFrom(
          backgroundColor: const Color.fromARGB(255, 143, 97, 6),
          foregroundColor: Colors.white,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12),
          ),
          padding: const EdgeInsets.symmetric(vertical: 16),
        ),
      ),
      textButtonTheme: TextButtonThemeData(
        style: TextButton.styleFrom(
          foregroundColor: const Color.fromARGB(255, 143, 97, 6),
        ),
      ),
    );
  }
}