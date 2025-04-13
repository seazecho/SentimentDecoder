import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'dart:convert';
import 'package:intl/intl.dart';

class History extends StatefulWidget {
  const History({super.key});

  @override
  State<History> createState() => _HistoryState();
}

class _HistoryState extends State<History> with SingleTickerProviderStateMixin {
  List<Map<String, dynamic>> _textHistory = [];
  List<Map<String, dynamic>> _audioHistory = [];
  late TabController _tabController;
  bool _isLoading = true;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 2, vsync: this);
    _loadHistory();
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  Future<void> _loadHistory() async {
    setState(() => _isLoading = true);

    try {
      final prefs = await SharedPreferences.getInstance();
      final textHistoryJson = prefs.getStringList('textHistory') ?? [];
      final audioHistoryJson = prefs.getStringList('audioHistory') ?? [];

      setState(() {
        _textHistory = textHistoryJson
            .map((item) => json.decode(item) as Map<String, dynamic>)
            .toList();
        _audioHistory = audioHistoryJson
            .map((item) => json.decode(item) as Map<String, dynamic>)
            .toList();

        _textHistory.sort(
            (a, b) => (b['timestamp'] as int).compareTo(a['timestamp'] as int));
        _audioHistory.sort(
            (a, b) => (b['timestamp'] as int).compareTo(a['timestamp'] as int));
      });
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Error loading history: $e')),
      );
    } finally {
      setState(() => _isLoading = false);
    }
  }

  Future<void> _clearHistory() async {
    try {
      final prefs = await SharedPreferences.getInstance();

      if (_tabController.index == 0) {
        await prefs.remove('textHistory');
        setState(() => _textHistory = []);
      } else {
        await prefs.remove('audioHistory');
        setState(() => _audioHistory = []);
      }

      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('History cleared')),
      );
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Error clearing history: $e')),
      );
    }
  }

  String _formatTimestamp(int timestamp) {
    final DateTime date = DateTime.fromMillisecondsSinceEpoch(timestamp);
    return DateFormat('MMM d, yyyy - h:mm a').format(date);
  }

  Widget _buildEmptyState(String message) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(
            Icons.history,
            size: 80,
            color: Theme.of(context).colorScheme.onSurface.withOpacity(0.4),
          ),
          const SizedBox(height: 16),
          Text(
            message,
            style: TextStyle(
              fontSize: 18,
              color: Theme.of(context).colorScheme.onSurface.withOpacity(0.6),
            ),
            textAlign: TextAlign.center,
          ),
        ],
      ),
    );
  }

  Widget _buildTextHistoryList() {
    if (_isLoading) {
      return const Center(child: CircularProgressIndicator());
    }

    if (_textHistory.isEmpty) {
      return _buildEmptyState('No text analysis history yet');
    }

    return ListView.builder(
      itemCount: _textHistory.length,
      padding: const EdgeInsets.all(8),
      itemBuilder: (context, index) {
        final item = _textHistory[index];
        final String text = item['text'] ?? 'No text';
        final String emotion = item['emotion'] ?? 'Unknown';
        final int timestamp = item['timestamp'] ?? 0;

        return Card(
          margin: const EdgeInsets.symmetric(vertical: 8),
          child: ExpansionTile(
            title: Text(
              text.length > 50 ? '${text.substring(0, 50)}...' : text,
              style: const TextStyle(fontWeight: FontWeight.w500),
            ),
            subtitle: Text(_formatTimestamp(timestamp)),
            trailing: CircleAvatar(
              backgroundColor: _getEmotionColor(emotion),
              child: Text(
                emotion.substring(0, 1).toUpperCase(),
                style: const TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            children: [
              Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      'Full Text:',
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 16,
                      ),
                    ),
                    const SizedBox(height: 8),
                    Text(text),
                    const SizedBox(height: 16),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const Text(
                              'Detected Emotion:',
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            const SizedBox(height: 4),
                            Chip(
                              label: Text(emotion),
                              backgroundColor:
                                  _getEmotionColor(emotion).withOpacity(0.2),
                            ),
                          ],
                        ),
                        IconButton(
                          icon: const Icon(Icons.delete),
                          onPressed: () async {
                            setState(() {
                              _textHistory.removeAt(index);
                            });

                            final prefs = await SharedPreferences.getInstance();
                            await prefs.setStringList(
                              'textHistory',
                              _textHistory
                                  .map((item) => json.encode(item))
                                  .toList(),
                            );
                          },
                          tooltip: 'Delete entry',
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ],
          ),
        );
      },
    );
  }

  Widget _buildAudioHistoryList() {
    if (_isLoading) {
      return const Center(child: CircularProgressIndicator());
    }

    if (_audioHistory.isEmpty) {
      return _buildEmptyState('No audio analysis history yet');
    }

    return ListView.builder(
      itemCount: _audioHistory.length,
      padding: const EdgeInsets.all(8),
      itemBuilder: (context, index) {
        final item = _audioHistory[index];
        final String fileName = item['fileName'] ?? 'Audio file';
        final String emotion = item['emotion'] ?? 'Unknown';
        final int timestamp = item['timestamp'] ?? 0;

        return Card(
          margin: const EdgeInsets.symmetric(vertical: 8),
          child: ListTile(
            leading: Container(
              width: 50,
              height: 50,
              decoration: BoxDecoration(
                color: Theme.of(context).colorScheme.surfaceVariant,
                borderRadius: BorderRadius.circular(8),
              ),
              child: Icon(
                Icons.audio_file,
                color: Theme.of(context).colorScheme.primary,
              ),
            ),
            title: Text(fileName),
            subtitle: Text(_formatTimestamp(timestamp)),
            trailing: Chip(
              label: Text(emotion),
              backgroundColor: _getEmotionColor(emotion).withOpacity(0.3),
            ),
            onLongPress: () async {
              setState(() {
                _audioHistory.removeAt(index);
              });

              final prefs = await SharedPreferences.getInstance();
              await prefs.setStringList(
                'audioHistory',
                _audioHistory.map((item) => json.encode(item)).toList(),
              );
            },
          ),
        );
      },
    );
  }

  Color _getEmotionColor(String emotion) {
    switch (emotion.toLowerCase()) {
      case 'happy':
      case 'happiness':
      case 'joy':
        return Colors.amber;
      case 'sad':
      case 'sadness':
        return Colors.blue;
      case 'angry':
      case 'anger':
        return Colors.red;
      case 'fear':
      case 'fearful':
        return Colors.purple;
      case 'surprise':
      case 'surprised':
        return Colors.orange;
      case 'neutral':
        return Colors.grey;
      default:
        return Theme.of(context).colorScheme.primary;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("History"),
        bottom: TabBar(
          controller: _tabController,
          labelColor: Theme.of(context).colorScheme.primary,
          indicatorColor: Theme.of(context).colorScheme.primary,
          tabs: const [
            Tab(text: "Text Analysis"),
            Tab(text: "Audio Analysis"),
          ],
        ),
        actions: [
          IconButton(
            icon: const Icon(Icons.refresh),
            onPressed: _loadHistory,
            tooltip: 'Refresh',
          ),
          IconButton(
            icon: const Icon(Icons.delete),
            onPressed: () {
              showDialog(
                context: context,
                builder: (context) => AlertDialog(
                  backgroundColor:
                      Theme.of(context).brightness == Brightness.dark
                          ? const Color(0xFF1A2525)
                          : Colors.white,
                  title: const Text('Clear History'),
                  content: Text(_tabController.index == 0
                      ? 'Are you sure you want to clear all text analysis history?'
                      : 'Are you sure you want to clear all audio analysis history?'),
                  actions: [
                    TextButton(
                      onPressed: () => Navigator.pop(context),
                      child: const Text('Cancel'),
                    ),
                    TextButton(
                      onPressed: () {
                        _clearHistory();
                        Navigator.pop(context);
                      },
                      child: const Text('Clear'),
                    ),
                  ],
                ),
              );
            },
            tooltip: 'Clear history',
          ),
        ],
      ),
      body: TabBarView(
        controller: _tabController,
        children: [
          _buildTextHistoryList(),
          _buildAudioHistoryList(),
        ],
      ),
    );
  }
}
