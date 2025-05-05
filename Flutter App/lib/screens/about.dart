import 'package:flutter/material.dart';

class About extends StatelessWidget {
  const About({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("About"),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Center(
              child: GestureDetector(
                onDoubleTap: () {
                  showDialog(
                    context: context,
                    builder: (context) => AlertDialog(
                      title: const Text("Mood Meltdown!"),
                      content: const Text(
                          "Double-tapped the logo? Our CNNs are freaking out—they think you’re *ecstatic* or just mad at your screen!"),
                      actions: [
                        TextButton(
                          onPressed: () => Navigator.pop(context),
                          child: const Text("Chill, I'm cool!"),
                        ),
                      ],
                    ),
                  );
                },
                child: Container(
                  width: 120,
                  height: 120,
                  decoration: BoxDecoration(
                    color: Theme.of(context).colorScheme.surfaceVariant,
                    shape: BoxShape.circle,
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black.withOpacity(0.1),
                        blurRadius: 10,
                        spreadRadius: 1,
                      ),
                    ],
                  ),
                  child: Center(
                    child: Image.asset(
                      'assets/images/appstore.png',
                      width: 100,
                      height: 100,
                      fit: BoxFit.contain,
                      errorBuilder: (context, error, stackTrace) => Icon(
                        Icons.sentiment_very_satisfied_rounded,
                        size: 70,
                        color: Theme.of(context).colorScheme.primary,
                      ),
                    ),
                  ),
                ),
              ),
            ),
            const SizedBox(height: 24),
            Center(
              child: Text(
                "SentimentDecoder",
                style: TextStyle(
                  fontSize: 28,
                  fontWeight: FontWeight.bold,
                  color: Theme.of(context).colorScheme.primary,
                ),
              ),
            ),
            Center(
              child: Text(
                "Version 1.2.0",
                style: TextStyle(
                  fontSize: 16,
                  color:
                      Theme.of(context).colorScheme.onSurface.withOpacity(0.6),
                ),
              ),
            ),
            const SizedBox(height: 32),
            Card(
              elevation: 2,
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "About SentimentDecoder",
                      style: Theme.of(context).textTheme.titleLarge,
                    ),
                    const SizedBox(height: 8),
                    Text(
                      "Can a machine hear your heart through your voice? SentimentDecoder is our attempt to find out! Powered by machine learning, it analyzes your speech to detect emotions like happiness, anger, sadness, or fear—not from your words, but from *how* you say them. Using features like MFCCs, pitch, and energy, it decodes vocal cues with models like CNNs and SVMs trained on datasets (RAVDESS, TESS, SAVEE, CREMA-D).\nWords tell their own story, so we’ve added text analysis with RoBERTa to catch when 'I’m fine' drips with sarcasm. These systems aren’t fully merged yet—think of them as two friends who haven’t teamed up for the big dance. Built for real-time use, it’s perfect for AI chats, mental health tools, or just figuring out if your 'happy' sounds more like 'hangry'.",
                      style: Theme.of(context).textTheme.bodyLarge,
                    ),
                    const SizedBox(height: 16),
                    Text(
                      "Features",
                      style: Theme.of(context).textTheme.titleMedium,
                    ),
                    const SizedBox(height: 8),
                    Text(
                      "- Hears emotions in your voice—because tone spills the tea.\n"
                      "- Text analysis catches sarcasm—'I’m fine' doesn’t fool us.\n"
                      "- Runs on mobile with a FastAPI backend—emotions on the go!\n"
                      "- Lightweight, but deep—CNNs and SVMs aren’t just buzzwords.\n"
                      "- Work in progress—text and tone will unite, promise!",
                      style: Theme.of(context).textTheme.bodyLarge,
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
                    Text(
                      "How It Works",
                      style: Theme.of(context).textTheme.titleLarge,
                    ),
                    const SizedBox(height: 8),
                    Text(
                      "1. Speak Up - We listen to your voice (no eavesdropping, scout’s honor).\n"
                      "2. Audio Magic - Extracts MFCCs, pitch, and more, like a chef prepping ingredients.\n"
                      "3. Model Crunch - Our CNN or SVM guesses if you’re joyful or just *done* (69-82% accuracy, not bad!).\n"
                      "4. Text Check - RoBERTa scans your words for hidden vibes (separate for now, stay tuned).\n"
                      "5. Results - Tells you your mood—because sometimes you need a nudge to admit you’re grumpy.\n"
                      "*Tough Bits*: Noise messes with audio, and merging text-tone is like herding cats. We’re working on it!",
                      style: Theme.of(context).textTheme.bodyLarge,
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
                    GestureDetector(
                      onLongPress: () {
                        showDialog(
                          context: context,
                          builder: (context) => AlertDialog(
                            title: const Text("Team Shenanigans!"),
                            content: const Text(
                                "Long-pressing the team? Our crew’s so wild, even the SVMs can’t predict our next move!"),
                            actions: [
                              TextButton(
                                onPressed: () => Navigator.pop(context),
                                child: const Text("They’re too cool!"),
                              ),
                            ],
                          ),
                        );
                      },
                      child: Text(
                        "Development Team",
                        style: Theme.of(context).textTheme.titleLarge,
                      ),
                    ),
                    const SizedBox(height: 8),
                    ListTile(
                      leading: CircleAvatar(
                        backgroundColor: Theme.of(context).colorScheme.primary,
                        child: const Text("CM",
                            style: TextStyle(color: Colors.white)),
                      ),
                      title: const Text("Chetan Mirashi"),
                      subtitle: const Text("Senior Mouse Clicker"),
                      trailing: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          IconButton(
                            icon: const Icon(Icons.email),
                            onPressed: () {
                              showDialog(
                                context: context,
                                builder: (context) => AlertDialog(
                                  title: const Text("Email Overload!"),
                                  content: const Text(
                                      "This email’s shy—it’s hiding from spam! Wanna whisper to Chetan? It says ‘I’m fine’ anyway!"),
                                  actions: [
                                    TextButton(
                                      onPressed: () => Navigator.pop(context),
                                      child: const Text("Leave it be!"),
                                    ),
                                  ],
                                ),
                              );
                            },
                          ),
                          IconButton(
                            icon: const Icon(Icons.link),
                            onPressed: () {
                              showDialog(
                                context: context,
                                builder: (context) => AlertDialog(
                                  title: const Text("Link’s Stage Fright!"),
                                  content: const Text(
                                      "This GitHub’s a bit bashful—peek at the cool stuff in Contact & Support!"),
                                  actions: [
                                    TextButton(
                                      onPressed: () => Navigator.pop(context),
                                      child: const Text("Got it!"),
                                    ),
                                  ],
                                ),
                              );
                            },
                          ),
                        ],
                      ),
                    ),
                    ListTile(
                      leading: CircleAvatar(
                        backgroundColor: Theme.of(context).colorScheme.primary,
                        child: const Text("SN",
                            style: TextStyle(color: Colors.white)),
                      ),
                      title: const Text("Sanish Naik"),
                      subtitle: const Text("“It Works on My Machine” Expert"),
                      trailing: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          IconButton(
                            icon: const Icon(Icons.email),
                            onPressed: () {
                              showDialog(
                                context: context,
                                builder: (context) => AlertDialog(
                                  title: const Text("Email Jitters!"),
                                  content: const Text(
                                      "Sanish’s email’s nervous—it thinks you’re sending angry vibes! Maybe try a happy tone?"),
                                  actions: [
                                    TextButton(
                                      onPressed: () => Navigator.pop(context),
                                      child: const Text("I’ll be nice!"),
                                    ),
                                  ],
                                ),
                              );
                            },
                          ),
                          IconButton(
                            icon: const Icon(Icons.link),
                            onPressed: () {
                              showDialog(
                                context: context,
                                builder: (context) => AlertDialog(
                                  title: const Text("Link’s Hiding!"),
                                  content: const Text(
                                      "Oops, this button’s having a grumpy day—guess it’s just vibing solo!"),
                                  actions: [
                                    TextButton(
                                      onPressed: () => Navigator.pop(context),
                                      child: const Text("Fair enough!"),
                                    ),
                                  ],
                                ),
                              );
                            },
                          ),
                        ],
                      ),
                    ),
                    ListTile(
                      leading: CircleAvatar(
                        backgroundColor: Theme.of(context).colorScheme.primary,
                        child: const Text("SN",
                            style: TextStyle(color: Colors.white)),
                      ),
                      title: const Text("Sumit Naik"),
                      subtitle: const Text("Wi-Fi Reconnector"),
                      trailing: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          IconButton(
                            icon: const Icon(Icons.email),
                            onPressed: () {
                              showDialog(
                                context: context,
                                builder: (context) => AlertDialog(
                                  title: const Text("Email Panic!"),
                                  content: const Text(
                                      "Sumit's email's freaking out—thinks it's getting sad vibes! Wanna send a cheery note?"),
                                  actions: [
                                    TextButton(
                                      onPressed: () => Navigator.pop(context),
                                      child: const Text("I'll cheer it up!"),
                                    ),
                                  ],
                                ),
                              );
                            },
                          ),
                          IconButton(
                            icon: const Icon(Icons.link),
                            onPressed: () {
                              showDialog(
                                context: context,
                                builder: (context) => AlertDialog(
                                  title: const Text("Link’s Camera-Shy!"),
                                  content: const Text(
                                      "Yikes, this button’s pouting—caught in a mood swing all by itself!"),
                                  actions: [
                                    TextButton(
                                      onPressed: () => Navigator.pop(context),
                                      child: const Text("Onward!"),
                                    ),
                                  ],
                                ),
                              );
                            },
                          ),
                        ],
                      ),
                    ),
                    ListTile(
                      leading: CircleAvatar(
                        backgroundColor: Theme.of(context).colorScheme.primary,
                        child: const Text("MP",
                            style: TextStyle(color: Colors.white)),
                      ),
                      title: const Text("Muhinodin Patil"),
                      subtitle: const Text("Head Googler of Problems"),
                      trailing: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          IconButton(
                            icon: const Icon(Icons.email),
                            onPressed: () {
                              showDialog(
                                context: context,
                                builder: (context) => AlertDialog(
                                  title: const Text("Email Meltdown!"),
                                  content: const Text(
                                      "Muhinodin’s email’s shy—scared of spam waves! Wanna send happy data vibes?"),
                                  actions: [
                                    TextButton(
                                      onPressed: () => Navigator.pop(context),
                                      child: const Text("Keep it calm!"),
                                    ),
                                  ],
                                ),
                              );
                            },
                          ),
                          IconButton(
                            icon: const Icon(Icons.link),
                            onPressed: () {
                              showDialog(
                                context: context,
                                builder: (context) => AlertDialog(
                                  title: const Text("Link’s Gone Quiet!"),
                                  content: const Text(
                                      "Uh-oh, this button’s throwing a tantrum—stuck in a silly mood loop!"),
                                  actions: [
                                    TextButton(
                                      onPressed: () => Navigator.pop(context),
                                      child: const Text("To the star!"),
                                    ),
                                  ],
                                ),
                              );
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
                    Text(
                      "Contact & Support",
                      style: Theme.of(context).textTheme.titleLarge,
                    ),
                    const SizedBox(height: 8),
                    const SizedBox(height: 16),
                    ListTile(
                      leading: Icon(
                        Icons.bug_report,
                        color: Theme.of(context).colorScheme.primary,
                      ),
                      title: const Text("Squash a Bug"),
                      subtitle: const Text("Or tickle our code silly!"),
                      onTap: () {
                        showDialog(
                          context: context,
                          builder: (context) => AlertDialog(
                            title: const Text("Bug Bash Blunder!"),
                            content: const Text(
                                "Tapped to squash a bug? Yikes, our code’s sulking—it says it’s *too sad* to fix right now!"),
                            actions: [
                              TextButton(
                                onPressed: () => Navigator.pop(context),
                                child: const Text("Pet the code!"),
                              ),
                            ],
                          ),
                        );
                      },
                    ),
                    ListTile(
                      leading: Icon(
                        Icons.sentiment_neutral,
                        color: Theme.of(context).colorScheme.primary,
                      ),
                      title: const Text("Vibe Check"),
                      subtitle: const Text("Spill your mood, we dare you!"),
                      onTap: () {
                        showDialog(
                          context: context,
                          builder: (context) => AlertDialog(
                            title: const Text("Vibe Check Fail!"),
                            content: const Text(
                                "Tried a vibe check? Our SVMs yelled ‘I’m fine!’ but they’re totally grumpy—someone stole their snacks!"),
                            actions: [
                              TextButton(
                                onPressed: () => Navigator.pop(context),
                                child: const Text("Feed them!"),
                              ),
                            ],
                          ),
                        );
                      },
                    ),
                    ListTile(
                      leading: Icon(
                        Icons.help,
                        color: Theme.of(context).colorScheme.primary,
                      ),
                      title: const Text("FAQ (or Total Guesswork)"),
                      subtitle: const Text(
                          "Why’s my ‘happy’ sad? Our app’s bunking mood school!"),
                      onTap: () {
                        showDialog(
                          context: context,
                          builder: (context) => AlertDialog(
                            title: const Text("FAQ Faceplant!"),
                            content: const Text(
                                "Poking the FAQ? RoBERTa thinks you’re ‘curious,’ but our app’s bunking class on mood clues!"),
                            actions: [
                              TextButton(
                                onPressed: () => Navigator.pop(context),
                                child: const Text("Shake it again!"),
                              ),
                            ],
                          ),
                        );
                      },
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
                    Text(
                      "Our Code’s Home",
                      style: Theme.of(context).textTheme.titleLarge,
                    ),
                    const SizedBox(height: 8),
                    RichText(
                      text: TextSpan(
                        style: Theme.of(context).textTheme.bodyMedium,
                        children: [
                          const TextSpan(
                              text:
                                  "Curious about how SentimentDecoder ticks? Check out the code crafted by Chetan Mirashi at "),
                          TextSpan(
                            text: "github.com/seaZecho/SentimentDecoder",
                            style: TextStyle(
                              color: Theme.of(context).colorScheme.primary,
                              fontWeight: FontWeight.bold,
                              decoration: TextDecoration.underline,
                            ),
                          ),
                          const TextSpan(
                              text:
                                  ". It’s where our ML magic lives—bugs and all!"),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
            const SizedBox(height: 32),
            Center(
              child: Text(
                "© 2025 SentimentDecoder. All rights reserved.",
                style: TextStyle(
                  fontSize: 14,
                  color:
                      Theme.of(context).colorScheme.onSurface.withOpacity(0.6),
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
