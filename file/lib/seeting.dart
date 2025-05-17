import 'package:file/appdrwaer.dart'; // Ensure this is correctly imported
import 'package:flutter/material.dart';

class SettingsPage extends StatefulWidget {
  @override
  _SettingsPageState createState() => _SettingsPageState();
}

class _SettingsPageState extends State<SettingsPage> {
  @override
  void initState() {
    super.initState();
    // _loadUserName(); // Load saved user name on init
  }

  // // Load user name from SharedPreferences
  // Future<void> _loadUserName() async {
  //   final prefs = await SharedPreferences.getInstance();
  //   setState(() {
  //     _userName = prefs.getString('userName') ?? "User";
  //   });
  // }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFFEFF6FF), // Light blue background
      appBar: AppBar(
        backgroundColor: Colors.blueAccent,
        leading: IconButton(
          icon: Icon(Icons.arrow_back, color: Colors.white),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
        title: Text("Settings", style: TextStyle(color: Colors.white)),
      ),
      drawer: AppDrawer(),
      body: Column(
        children: [
          // Header with user icon and name
          Container(
            height: 150,
            width: double.infinity,
            decoration: BoxDecoration(
              color: Colors.blueAccent,
              borderRadius: BorderRadius.only(
                bottomLeft: Radius.circular(100),
                bottomRight: Radius.circular(100),
              ),
            ),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                CircleAvatar(
                  radius: 40,
                  backgroundColor: Colors.white.withOpacity(0.3),
                  child: Icon(Icons.person, size: 50, color: Colors.white),
                ),
                SizedBox(height: 8),
                Text(
                  "userName", // Dynamic user name
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
          ),
          SizedBox(height: 20),
          // Settings options list
          Expanded(
            child: ListView(
              children: [
                _buildSettingsTile(
                  context,
                  icon: Icons.person_add,
                  title: "Create Profile",
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder:
                            (context) => CreateProfilePage(
                              onSave: (name) {
                                // setState(() {
                                //   _userName = name;
                                // });
                              },
                            ),
                      ),
                    );
                  },
                ),
                _buildSettingsTile(
                  context,
                  icon: Icons.language,
                  title: "Select Language",
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => LanguageSelectionPage(),
                      ),
                    );
                  },
                ),

                _buildSettingsTile(
                  context,
                  icon: Icons.share,
                  title: "Share App",
                  onTap: () {
                    // Share.share(
                    //   'Check out this awesome app! Download it from:\nhttps://play.google.com/store/apps/details?id=com.yourcompany.yourapp',
                    //   subject: 'Try this App!',
                    // );
                  },
                ),

                _buildSettingsTile(
                  context,
                  icon: Icons.privacy_tip,
                  title: "Privacy Policy",
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => PrivacyPolicyPage(),
                      ),
                    );
                  },
                ),
                _buildSettingsTile(
                  context,
                  icon: Icons.feedback,
                  title: "Feedback",
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => FeedbackPage()),
                    );
                  },
                ),
                _buildSettingsTile(
                  context,
                  icon: Icons.history,
                  title: "History",
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => HistoryPage()),
                    );
                  },
                ),
              ],
            ),
          ),
          // Version number at the bottom
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Text("v42.17", style: TextStyle(color: Colors.grey)),
          ),
        ],
      ),
    );
  }

  Widget _buildSettingsTile(
    BuildContext context, {
    required IconData icon,
    required String title,
    required VoidCallback onTap,
  }) {
    return Card(
      margin: EdgeInsets.symmetric(horizontal: 16, vertical: 4),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
      child: ListTile(
        leading: Icon(icon, color: Colors.blueAccent),
        title: Text(title),
        trailing: Icon(Icons.chevron_right, color: Colors.blueAccent),
        onTap: onTap,
      ),
    );
  }

  void _showSnackBar(BuildContext context, String message) {
    ScaffoldMessenger.of(
      context,
    ).showSnackBar(SnackBar(content: Text(message)));
  }
}

// Create Profile Page
class CreateProfilePage extends StatefulWidget {
  final Function(String) onSave;

  CreateProfilePage({required this.onSave, Key? key}) : super(key: key);

  @override
  _CreateProfilePageState createState() => _CreateProfilePageState();
}

class _CreateProfilePageState extends State<CreateProfilePage> {
  final _formKey = GlobalKey<FormState>();
  final _nameController = TextEditingController();
  final _emailController = TextEditingController();
  final _phoneController = TextEditingController();

  @override
  void dispose() {
    _nameController.dispose();
    _emailController.dispose();
    _phoneController.dispose();
    super.dispose();
  }

  // Future<void> _saveProfile() async {
  //   if (_formKey.currentState!.validate()) {
  //     final prefs = await SharedPreferences.getInstance();
  //     await prefs.setString('userName', _nameController.text);
  //     await prefs.setString('email', _emailController.text);
  //     await prefs.setString('phone', _phoneController.text);
  //     widget.onSave(_nameController.text);

  //     ScaffoldMessenger.of(context).showSnackBar(
  //       SnackBar(content: Text("Profile saved successfully")),
  //     );

  //     Navigator.pop(context);
  //   }
  // }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Create Profile"),
        backgroundColor: Colors.blueAccent,
      ),
      body: Padding(
        padding: EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: Column(
            children: [
              TextFormField(
                controller: _nameController,
                decoration: InputDecoration(labelText: "Name"),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return "Please enter your name";
                  }
                  return null;
                },
              ),
              TextFormField(
                controller: _emailController,
                decoration: InputDecoration(labelText: "Email"),
                keyboardType: TextInputType.emailAddress,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return "Please enter your email";
                  }
                  if (!RegExp(r'^[^@]+@[^@]+\.[^@]+').hasMatch(value)) {
                    return "Please enter a valid email";
                  }
                  return null;
                },
              ),
              TextFormField(
                controller: _phoneController,
                decoration: InputDecoration(labelText: "Phone Number"),
                keyboardType: TextInputType.phone,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return "Please enter your phone number";
                  }
                  return null;
                },
              ),
              SizedBox(height: 20),
              ElevatedButton(
                onPressed:(){
                  
                },
                child: Text("Save"),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

// Language Selection Page

class LanguageSelectionPage extends StatefulWidget {
  const LanguageSelectionPage({super.key});

  @override
  State<LanguageSelectionPage> createState() => _LanguageSelectionPageState();
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
        title: const Text('Select Language'),
        actions: [
          IconButton(
            icon: const Icon(Icons.check),
            onPressed: () {
              // Do something with selectedLanguage
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(content: Text('Selected: $selectedLanguage')),
              );
              Navigator.pop(context, selectedLanguage); // Return selection
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
            leading: Text(
              language['flag']!,
              style: const TextStyle(fontSize: 24),
            ),
            title: Text(language['name']!),
            trailing:
                isSelected
                    ? const Icon(Icons.check_circle, color: Colors.blue)
                    : const Icon(Icons.circle_outlined, color: Colors.grey),
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

class PrivacyPolicyPage extends StatelessWidget {
  const PrivacyPolicyPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Privacy Policy"),
        backgroundColor: Colors.blueAccent,
      ),
      body: const Padding(
        padding: EdgeInsets.all(16.0),
        child: SingleChildScrollView(
          child: Text('''
Your privacy is important to us.

This app does not collect, store, or share any personal data without your consent. We are committed to ensuring the security of your information.

Any data you voluntarily provide (such as during registration or feedback) is kept confidential and used only to improve your experience.

For more information, please visit our official website or contact support.

Thank you for trusting us.
            ''', style: TextStyle(fontSize: 16, height: 1.5)),
        ),
      ),
    );
  }
}

class FeedbackPage extends StatefulWidget {
  const FeedbackPage({super.key});

  @override
  _FeedbackPageState createState() => _FeedbackPageState();
}

class _FeedbackPageState extends State<FeedbackPage> {
  final _feedbackController = TextEditingController();
  int _selectedRating = 0;

  @override
  void dispose() {
    _feedbackController.dispose();
    super.dispose();
  }

  void _submitFeedback() {
    if (_feedbackController.text.isNotEmpty && _selectedRating > 0) {
      // Add logic to send feedback (e.g., to a server or email)
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text("Feedback submitted. Thank you!")),
      );
      Navigator.pop(context);
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text("Please enter feedback and select a rating"),
        ),
      );
    }
  }

  Widget _buildStarRating() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: List.generate(5, (index) {
        final starIndex = index + 1;
        return IconButton(
          icon: Icon(
            _selectedRating >= starIndex ? Icons.star : Icons.star_border,
            color: Colors.amber,
            size: 32,
          ),
          onPressed: () {
            setState(() {
              _selectedRating = starIndex;
            });
          },
        );
      }),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Feedback"),
        backgroundColor: Colors.blueAccent,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            const Text(
              "Rate your experience:",
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            _buildStarRating(),
            const SizedBox(height: 20),
            TextField(
              controller: _feedbackController,
              decoration: const InputDecoration(
                labelText: "Your feedback",
                border: OutlineInputBorder(),
              ),
              maxLines: 4,
            ),
            const SizedBox(height: 20),
            ElevatedButton.icon(
              onPressed: _submitFeedback,

              label: const Text(
                "Submit Feedback",
                style: TextStyle(color: Colors.white),
              ),
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.blueAccent,
                minimumSize: const Size(double.infinity, 50),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

// History Page
class HistoryPage extends StatelessWidget {
  // Mock data for file transfer history
  final List<Map<String, String>> transferHistory = [
    {"file": "document.pdf", "date": "2025-05-01"},
    {"file": "image.jpg", "date": "2025-04-30"},
    {"file": "video.mp4", "date": "2025-04-29"},
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Transfer History"),
        backgroundColor: Colors.blueAccent,
      ),
      body: ListView.builder(
        itemCount: transferHistory.length,
        itemBuilder: (context, index) {
          return ListTile(
            leading: Icon(Icons.file_copy, color: Colors.blueAccent),
            title: Text(transferHistory[index]["file"]!),
            subtitle: Text("Transferred on ${transferHistory[index]["date"]}"),
          );
        },
      ),
    );
  }
}
