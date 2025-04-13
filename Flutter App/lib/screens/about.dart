import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

class About extends StatelessWidget {
  const About({super.key});

  Future<void> _launchURL(String url) async {
    if (await canLaunch(url)) {
      await launch(url);
    } else {
      throw 'Could not launch $url';
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color.fromARGB(255, 233, 241, 250),
        title: const Text(
          "About",
          style: TextStyle(
            color: Color(0xFF0097A7),
          ),
        ),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Center(
              child: Container(
                width: 120,
                height: 120,
                decoration: BoxDecoration(
                  color: const Color.fromARGB(255, 233, 241, 250),
                  shape: BoxShape.circle,
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withOpacity(0.1),
                      blurRadius: 10,
                      spreadRadius: 1,
                    ),
                  ],
                ),
                child: const Center(
                  child: Icon(
                    Icons.sentiment_very_satisfied_rounded,
                    size: 70,
                    color: Color(0xFF0097A7),
                  ),
                ),
              ),
            ),
            const SizedBox(height: 24),

            const Center(
              child: Text(
                "SentimentDecoder",
                style: TextStyle(
                  fontSize: 28,
                  fontWeight: FontWeight.bold,
                  color: Color(0xFF0097A7),
                ),
              ),
            ),
            const Center(
              child: Text(
                "Version 3.2.0",
                style: TextStyle(
                  fontSize: 16,
                  color: Colors.grey,
                ),
              ),
            ),
            const SizedBox(height: 32),

            const Card(
              elevation: 2,
              child: Padding(
                padding: EdgeInsets.all(16.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "About SentimentDecoder",
                      style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    SizedBox(height: 8),
                    Text(
                      "Ever wondered if a machine could actually understand how you feel just by hearing you speak? That's exactly what SentimentDecoder does!Built with machine learning, it detects emotions like happiness, anger, sadness, and surprise—not by what you say, but by how you say it. \nUsing MFCCs, pitch, energy, and ZCR, it analyzes vocal cues to classify emotions accurately.\nAnd because words matter too, SentimentDecoder also supports text-based emotion analysis (RoBERTa)-because “I'm fine” isn't always fine!\nFast, real-time, and designed for AI-driven interactions, mental health insights, and more-SentimentDecoder gives speech a whole new layer of meaning.",
                      style: TextStyle(fontSize: 16),
                    ),
                    SizedBox(height: 16),
                    Text(
                      "Features",
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    SizedBox(height: 8),
                    Text(
                      "Features of SentimentDecoder \n\n-Detects emotions—because “I'm fine” isn't always fine.\n\n-Listens to tone, pitch, and energy—just like a good friend.\n\n-Supports text-based analysis—because sarcasm exists.\n\n-Lightweight—won't make your device cry.\n\n-Works with mobile and backend—because emotions need a network too.",
                      style: TextStyle(fontSize: 16),
                    ),
                  ],
                ),
              ),
            ),
            const SizedBox(height: 24),

            const Card(
              elevation: 2,
              child: Padding(
                padding: EdgeInsets.all(16.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "How It Works",
                      style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    SizedBox(height: 8),
                    Text(
                      "How SentimentDecoder Works\n\n1. You Talk - The app listens (no judgment, promise).\n\n2. Feature Extraction - Picks apart your voice like a detective analyzing clues.\n\n3. ML Model Thinks - Our SVM model decides if you're happy, angry, or just really tired.\n\n4. Text Analysis - Because “I'm fine” might not actually mean fine.\n\n5. Emotion Revealed - The app tells you how you feel—just in case you weren't sure!",
                      style: TextStyle(fontSize: 16),
                    ),
                  ],
                ),
              ),
            ),
            const SizedBox(height: 24),

            Card(
              elevation: 2,
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      "Development Team",
                      style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 8),
                    ListTile(
                      leading: const CircleAvatar(
                        backgroundColor: Color(0xFF0097A7),
                        child:
                            Text("CM", style: TextStyle(color: Colors.white)),
                      ),
                      title: const Text("Chetan Mirashi"),
                      subtitle: const Text("Senior Button Mover"),
                      trailing: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          IconButton(
                            icon: const Icon(Icons.email),
                            onPressed: () {
                              _launchURL('mirashichetan2004@gmail.com');
                            },
                          ),
                          IconButton(
                            icon: const Icon(Icons.link),
                            onPressed: () {
                              _launchURL('https://example.com/johndoe');
                            },
                          ),
                        ],
                      ),
                    ),
                    ListTile(
                      leading: const CircleAvatar(
                        backgroundColor: Color(0xFF0097A7),
                        child:
                            Text("SN", style: TextStyle(color: Colors.white)),
                      ),
                      title: const Text("Sanish Naik"),
                      subtitle: const Text("Professional Wi-Fi Troubleshooter"),
                      trailing: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          IconButton(
                            icon: const Icon(Icons.email),
                            onPressed: () {
                              _launchURL('');
                            },
                          ),
                          IconButton(
                            icon: const Icon(Icons.link),
                            onPressed: () {
                              _launchURL('');
                            },
                          ),
                        ],
                      ),
                    ),
                    ListTile(
                      leading: const CircleAvatar(
                        backgroundColor: Color(0xFF0097A7),
                        child:
                            Text("SN", style: TextStyle(color: Colors.white)),
                      ),
                      title: const Text("Sumit Naik"),
                      subtitle: const Text("Senior Mouse Clicker"),
                      trailing: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          IconButton(
                            icon: const Icon(Icons.email),
                            onPressed: () {
                              _launchURL('');
                            },
                          ),
                          IconButton(
                            icon: const Icon(Icons.link),
                            onPressed: () {
                              _launchURL('');
                            },
                          ),
                        ],
                      ),
                    ),
                    ListTile(
                      leading: const CircleAvatar(
                        backgroundColor: Color(0xFF0097A7),
                        child:
                            Text("MP", style: TextStyle(color: Colors.white)),
                      ),
                      title: const Text("Muhinodin Patil"),
                      subtitle: const Text("Lead Typing Observer"),
                      trailing: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          IconButton(
                            icon: const Icon(Icons.email),
                            onPressed: () {
                              _launchURL('');
                            },
                          ),
                          IconButton(
                            icon: const Icon(Icons.link),
                            onPressed: () {
                              _launchURL('');
                            },
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
            const SizedBox(height: 24),

            Card(
              elevation: 2,
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      "Contact & Support",
                      style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 16),
                    ListTile(
                      leading:
                          const Icon(Icons.email, color: Color(0xFF0097A7)),
                      title: const Text("Email Support"),
                      subtitle: const Text("projectser2024@gmail.com"),
                      onTap: () {
                        _launchURL('');
                      },
                    ),
                    ListTile(
                      leading: const Icon(Icons.web, color: Color(0xFF0097A7)),
                      title: const Text("Website (not yet, chill)"),
                      subtitle: const Text("www.sentimentdecoder.com"),
                      onTap: () {
                        _launchURL('https://www.sentimentdecoder.com');
                      },
                    ),
                    ListTile(
                      leading: const Icon(Icons.help, color: Color(0xFF0097A7)),
                      title: const Text(
                          "FAQ (no one has it, so no questions asked)"),
                      subtitle: const Text("Frequently Asked Questions"),
                      onTap: () {
                        _launchURL('https://www.sentimentdecoder.com/faq');
                      },
                    ),
                  ],
                ),
              ),
            ),
            const SizedBox(height: 32),

            const Center(
              child: Text(
                "© 2025 SentimentDecoder. All rights reserved.",
                style: TextStyle(
                  fontSize: 14,
                  color: Colors.grey,
                ),
              ),
            ),
            const SizedBox(height: 16),
          ],
        ),
      ),
    );
  }
}
