import 'package:android_intent_plus/android_intent.dart';
import 'package:android_intent_plus/flag.dart';
import 'package:file/appdrwaer.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';

class HomePage extends StatelessWidget {
  const HomePage({Key? key}) : super(key: key);

  Future<void> _pickAndShareFile(BuildContext context, String fileType) async {
    FilePickerResult? result;

    if (fileType == "video") {
      result = await FilePicker.platform.pickFiles(type: FileType.video);
    } else if (fileType == "audio") {
      result = await FilePicker.platform.pickFiles(type: FileType.audio);
    }

    if (result != null && result.files.single.path != null) {
      final filePath = result.files.single.path!;
      final intent = AndroidIntent(
        action: 'android.intent.action.VIEW',
        type: fileType == "video" ? 'video/*' : 'audio/*',
        flags: <int>[Flag.FLAG_GRANT_READ_URI_PERMISSION],
        arguments: <String, dynamic>{
          'android.intent.extra.STREAM': filePath,
        },
      );

      try {
        await intent.launch();
      } catch (e) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text("Error launching intent: $e")),
        );
      }
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text("No file selected")),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFFEFF6FF),
      drawer: AppDrawer(),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(height: 20),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Builder(
                    builder: (context) => IconButton(
                      icon: Icon(Icons.menu, color: Colors.black),
                      onPressed: () {
                        Scaffold.of(context).openDrawer();
                      },
                    ),
                  ),
                  Text(
                    "Hello, User",
                    style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
                  ),
                  CircleAvatar(
                    radius: 20,
                    backgroundColor: Colors.orange,
                    child: Icon(Icons.star, color: Colors.white),
                  ),
                ],
              ),
              SizedBox(height: 30),
              Text(
                "QUICK TRANSFER",
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                  color: Colors.black,
                ),
              ),
              SizedBox(height: 20),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  _buildQuickTransferIcon(
                    Icons.play_circle,
                    "Videos",
                    Color(0xffe3f0ff),
                    Color(0xff3f7ff4),
                    () => _pickAndShareFile(context, "video"),
                  ),
                  _buildQuickTransferIcon(
                    Icons.audiotrack,
                    "Audios",
                    Color(0xffd1f4ff),
                    Color(0xff2bc4ff),
                    () => _pickAndShareFile(context, "audio"),
                  ),
                  _buildQuickTransferIcon(
                    Icons.account_circle,
                    "Contacts",
                    Color(0xffffefd9),
                    Color(0xfffe8d1f),
                    () {
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(content: Text("Contacts clicked")),
                      );
                    },
                  ),
                  _buildQuickTransferIcon(
                    Icons.grid_view,
                    "Apps",
                    Color(0xffdbffe8),
                    Color(0xff28c463),
                    () {
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(content: Text("Apps clicked")),
                      );
                    },
                  ),
                  _buildQuickTransferIcon(
                    Icons.article,
                    "Files",
                    Color(0xffffe4e0),
                    Color(0xffff5040),
                    () {
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(content: Text("Files clicked")),
                      );
                    },
                  ),
                ],
              ),
              SizedBox(height: 20),
              Align(
                alignment: Alignment.centerRight,
                child: ElevatedButton(
                  onPressed: () {
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(content: Text("Go Pro clicked")),
                    );
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.orange,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(20),
                    ),
                  ),
                  child: Text("Go Pro", style: TextStyle(color: Colors.white)),
                ),
              ),
              SizedBox(height: 20),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  _buildLargeButtons(
                    icon: Icons.send_to_mobile,
                    text: "Phone Clone",
                    color: Color(0xffdae9fe),
                    onTap: () {
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(content: Text("Phone Clone clicked")),
                      );
                    },
                  ),
                  _buildLargeButtons(
                    icon: Icons.smartphone,
                    text: "Android",
                    color: Color(0xffd6f1fc),
                    onTap: () {
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(content: Text("Android clicked")),
                      );
                    },
                  ),
                ],
              ),
              SizedBox(height: 15),
              Text(
                "SMART TRANSFER",
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                  color: Colors.black,
                ),
              ),
              SizedBox(height: 15),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  _buildLargeButton(
                    icon: Icons.send,
                    text: "Send\nTransfer Data",
                    color: Colors.blueAccent,
                    onTap: () => _pickAndShareFile(context, "video"),
                  ),
                  _buildLargeButton(
                    icon: Icons.download,
                    text: "Receive\nData",
                    color: Colors.teal,
                    onTap: () => _pickAndShareFile(context, "audio"),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildQuickTransferIcon(
    IconData icon,
    String label,
    Color backgroundColor,
    Color iconColor,
    VoidCallback onTap,
  ) {
    return Column(
      children: [
        GestureDetector(
          onTap: onTap,
          child: CircleAvatar(
            radius: 30,
            backgroundColor: backgroundColor,
            child: Center(child: Icon(icon, size: 30, color: iconColor)),
          ),
        ),
        SizedBox(height: 8),
        Text(label, style: TextStyle(fontSize: 12)),
      ],
    );
  }

  Widget _buildLargeButton({
    required IconData icon,
    required String text,
    required Color color,
    required VoidCallback onTap,
  }) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: 170,
        padding: EdgeInsets.symmetric(vertical: 16),
        decoration: BoxDecoration(
          color: color,
          borderRadius: BorderRadius.circular(12),
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            CircleAvatar(
              backgroundColor: Colors.white,
              radius: 32,
              child: Icon(icon, size: 30, color: Colors.blue),
            ),
            SizedBox(height: 8),
            Text(
              text,
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.w800,
                color: Colors.white,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildLargeButtons({
    required IconData icon,
    required String text,
    required Color color,
    required VoidCallback onTap,
  }) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: 170,
        padding: EdgeInsets.symmetric(vertical: 16),
        decoration: BoxDecoration(
          color: color,
          borderRadius: BorderRadius.circular(12),
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            CircleAvatar(
              backgroundColor: Colors.white,
              radius: 32,
              child: Icon(icon, size: 30, color: Colors.blue),
            ),
            SizedBox(height: 8),
            Text(
              text,
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.w800,
                color: Colors.black,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
