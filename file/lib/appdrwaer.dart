
import 'package:flutter/material.dart';

class AppDrawer extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: ListView(
        padding: EdgeInsets.zero,
        children: [
          DrawerHeader(
            decoration: BoxDecoration(color: Colors.blueAccent),
            child: Text(
              "Menu",
              style: TextStyle(color: Colors.white, fontSize: 24),
            ),
          ),
          ListTile(
            leading: Icon(Icons.settings, color: Colors.blueAccent),
            title: Text("Settings"),
            onTap: () {
              Navigator.pop(context); // Close the Drawer
              Navigator.pushNamed(
                context,
                '/settings',
              ); // Navigate to SettingsPage
            },
          ),
        ],
      ),
    );
  }
}
