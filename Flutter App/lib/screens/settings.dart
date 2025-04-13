import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:sentiment_infant/theme_notifier.dart';

class Settings extends StatefulWidget {
  const Settings({super.key});

  @override
  State<Settings> createState() => _SettingsState();
}

class _SettingsState extends State<Settings> {
  bool _saveHistory = true;

  @override
  void initState() {
    super.initState();
    _loadSettings();
  }

  Future<void> _loadSettings() async {
    final prefs = await SharedPreferences.getInstance();
    setState(() {
      _saveHistory = prefs.getBool('saveHistory') ?? true;
    });
  }

  Future<void> _saveSettings() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setBool('saveHistory', _saveHistory);

    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text('Settings saved')),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Settings"),
        actions: [
          IconButton(
            icon: const Icon(Icons.save),
            onPressed: _saveSettings,
            tooltip: 'Save Settings',
          ),
        ],
      ),
      body: ListView(
        children: [
          const SizedBox(height: 16),
          const Padding(
            padding: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
            child: Text(
              'App Appearance',
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          Consumer<ThemeNotifier>(
            builder: (context, themeNotifier, child) {
              return SwitchListTile(
                title: const Text('Dark Mode'),
                subtitle: const Text('Enable dark theme for the app'),
                value: themeNotifier.isDarkMode,
                onChanged: (value) {
                  themeNotifier.toggleTheme(value);
                },
                secondary: const Icon(Icons.dark_mode),
              );
            },
          ),
          const Divider(),
          const Padding(
            padding: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
            child: Text(
              'History Settings (no database)',
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          SwitchListTile(
            title: const Text('Save History'),
            subtitle: const Text('Save emotion analysis results'),
            value: _saveHistory,
            onChanged: (value) {
              setState(() {
                _saveHistory = value;
              });
            },
            secondary: const Icon(Icons.history),
          ),
          ListTile(
            title: const Text('Clear History'),
            subtitle: const Text('Delete all saved analysis results'),
            leading: const Icon(Icons.delete_forever),
            onTap: () {
              showDialog(
                context: context,
                builder: (context) => AlertDialog(
                  title: const Text('Clear History'),
                  content: const Text(
                      'Are you sure you want to clear all history? This action cannot be undone.'),
                  actions: [
                    TextButton(
                      onPressed: () => Navigator.pop(context),
                      child: const Text('Cancel'),
                    ),
                    TextButton(
                      onPressed: () async {
                        final prefs = await SharedPreferences.getInstance();
                        await prefs.remove('history');
                        Navigator.pop(context);
                        ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(content: Text('History cleared')),
                        );
                      },
                      child: const Text('Clear'),
                    ),
                  ],
                ),
              );
            },
          ),
          const Divider(),
          const Padding(
            padding: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
            child: Text(
              'About',
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          ListTile(
            title: const Text('App Version'),
            subtitle: const Text('1.2.0'),
            leading: const Icon(Icons.info),
          ),
          ListTile(
            title: const Text('Privacy Policy'),
            leading: const Icon(Icons.privacy_tip),
            onTap: () {},
          ),
          const SizedBox(height: 32),
        ],
      ),
    );
  }
}
