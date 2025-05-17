
import 'package:flutter/material.dart';

class LanguageSelectionPage extends StatefulWidget {
  const LanguageSelectionPage({super.key});

  @override
  _LanguageSelectionPageState createState() => _LanguageSelectionPageState();
}

class _LanguageSelectionPageState extends State<LanguageSelectionPage> {
  String? selectedLanguage = 'English (Default)';

  final List<Map<String, String>> languages = [
    {'name': 'English (Default)', 'flag': '🇺🇸'},
    {'name': 'Japanese', 'flag': '🇯🇵'},
    {'name': 'Russian', 'flag': '🇷🇺'},
    {'name': 'French', 'flag': '🇫🇷'},
    {'name': 'German', 'flag': '🇩🇪'},
    {'name': 'Spanish', 'flag': '🇪🇸'},
    {'name': 'Afrikaans', 'flag': '🇿🇦'},
    {'name': 'Indonesian', 'flag': '🇮🇩'},
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Select Language'),
        actions: [
          IconButton(
            icon: Icon(Icons.check),
            onPressed: () {
              if (selectedLanguage != null) {
                Navigator.pushNamed(context, '/home');
              }
            },
          ),
        ],
      ),
      body: ListView.builder(
        itemCount: languages.length,
        itemBuilder: (context, index) {
          final language = languages[index];
          final isSelected = selectedLanguage == language['name'];
          return ListTile(
            leading: Text(language['flag']!, style: TextStyle(fontSize: 24)),
            title: Text(language['name']!),
            trailing: isSelected
                ? Icon(Icons.check_circle, color: Colors.blue)
                : Icon(Icons.circle_outlined, color: Colors.grey),
            onTap: () {
              setState(() {
                selectedLanguage = language['name'];
              });
            },
          );
        },
      ),
    );
  }
}