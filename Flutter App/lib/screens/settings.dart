import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Settings extends StatefulWidget {
  const Settings({super.key});

  @override
  State<Settings> createState() => _SettingsState();
}

class _SettingsState extends State<Settings> {
  bool _darkMode = false;
  bool _saveHistory = true;
  String _selectedLanguage = 'English';
  double _confidenceThreshold = 0.7;

  final List<String> _languages = [
    'English',
    'Spanish',
    'French',
    'German',
    'Hindi'
  ];

  @override
  void initState() {
    super.initState();
    _loadSettings();
  }

  Future<void> _loadSettings() async {
    final prefs = await SharedPreferences.getInstance();
    setState(() {
      _darkMode = prefs.getBool('darkMode') ?? false;
      _saveHistory = prefs.getBool('saveHistory') ?? true;
      _selectedLanguage = prefs.getString('language') ?? 'English';
      _confidenceThreshold = prefs.getDouble('confidenceThreshold') ?? 0.7;
    });
  }

  Future<void> _saveSettings() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setBool('darkMode', _darkMode);
    await prefs.setBool('saveHistory', _saveHistory);
    await prefs.setString('language', _selectedLanguage);
    await prefs.setDouble('confidenceThreshold', _confidenceThreshold);

    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text('Settings saved')),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color.fromARGB(255, 233, 241, 250),
        title: const Text(
          "Settings",
          style: TextStyle(
            color: Color(0xFF0097A7),
          ),
        ),
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
                  color: Color(0xFF0097A7)),
            ),
          ),

          SwitchListTile(
            title: const Text('Dark Mode (we dont do that here)'),
            subtitle: const Text('Enable dark theme for the app'),
            value: _darkMode,
            onChanged: (value) {
              setState(() {
                _darkMode = value;
              });
            },
            secondary: const Icon(Icons.dark_mode),
          ),

          const Divider(),

          const Padding(
            padding: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
            child: Text(
              'History Settings (no database)',
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
                color: Color(0xFF0097A7),
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
              'Language Settings (They dont work)',
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
                color: Color(0xFF0097A7),
              ),
            ),
          ),

          ListTile(
            title: const Text('Speech Recognition Language'),
            subtitle: Text('Current: $_selectedLanguage'),
            leading: const Icon(Icons.language),
            onTap: () {
              showDialog(
                context: context,
                builder: (context) => AlertDialog(
                  title: const Text('Select Language'),
                  content: SizedBox(
                    width: double.maxFinite,
                    child: ListView.builder(
                      shrinkWrap: true,
                      itemCount: _languages.length,
                      itemBuilder: (context, index) {
                        return RadioListTile<String>(
                          title: Text(_languages[index]),
                          value: _languages[index],
                          groupValue: _selectedLanguage,
                          onChanged: (value) {
                            setState(() {
                              _selectedLanguage = value!;
                            });
                            Navigator.pop(context);
                          },
                        );
                      },
                    ),
                  ),
                ),
              );
            },
          ),

          const Divider(),
          const Padding(
            padding: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
            child: Text(
              'Analysis Settings (nope not yet )',
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
                color: Color(0xFF0097A7),
              ),
            ),
          ),

          ListTile(
            title: const Text('Confidence Threshold'),
            subtitle: Text('${(_confidenceThreshold * 100).toInt()}%'),
            leading: const Icon(Icons.tune),
          ),

          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: Slider(
              value: _confidenceThreshold,
              min: 0.5,
              max: 0.95,
              divisions: 9,
              label: '${(_confidenceThreshold * 100).toInt()}%',
              onChanged: (value) {
                setState(() {
                  _confidenceThreshold = value;
                });
              },
              activeColor: const Color(0xFF0097A7),
            ),
          ),

          const Divider(),

          const Padding(
            padding: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
            child: Text(
              'About',
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
                color: Color(0xFF0097A7),
              ),
            ),
          ),

          ListTile(
            title: const Text('App Version'),
            subtitle: const Text('3.2.0'),
            leading: const Icon(Icons.info),
          ),

          ListTile(
            title: const Text('Privacy Policy'),
            leading: const Icon(Icons.privacy_tip),
            onTap: () {

            },
          ),

          const SizedBox(height: 32),
        ],
      ),
    );
  }
}
