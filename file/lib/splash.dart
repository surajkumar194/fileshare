import 'package:file/langauge.dart';
import 'package:flutter/material.dart';



class SplashScreen extends StatefulWidget {
  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  bool isLoading = true; // To manage the progress indicator visibility

  @override
  void initState() {
    super.initState();
    // Wait for 3 seconds before showing the "Get Started" button
    Future.delayed(Duration(seconds: 3), () {
      setState(() {
        isLoading = false;
      });
    });
  }

  void navigateToNextScreen() {
    // Navigate to the next screen when the button is pressed
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) =>LanguageSelectionPage()),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        fit: StackFit.expand,
        children: [
          // Background image
          Image.asset(
            'assets/WhatsApp Image 2025-05-01 at 14.57.19.jpeg', // Your image path
            fit: BoxFit.cover, // Cover the entire screen
          ),
          // Centered circular progress indicator
          if (isLoading)
            Center(
              child: CircularProgressIndicator(),
            ),
          // "Get Started" button after 3 seconds
          if (!isLoading)
            Align(
              alignment: Alignment.bottomCenter,
              child: Padding(
                padding: const EdgeInsets.all(24.0),
                child: ElevatedButton(
                  onPressed: navigateToNextScreen,
                  child: Text('Get Started'),
                  style: ElevatedButton.styleFrom(
                    minimumSize: Size(double.infinity, 50), // Full width
                  ),
                ),
              ),
            ),
        ],
      ),
    );
  }
}
