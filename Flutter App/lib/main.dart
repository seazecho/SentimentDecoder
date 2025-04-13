import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sentiment_infant/screens/about.dart';
import 'package:sentiment_infant/screens/history.dart';
import 'package:sentiment_infant/screens/settings.dart';
import 'package:sentiment_infant/ser.dart';
import 'package:speech_to_text/speech_to_text.dart' as stt;
import 'package:http/http.dart' as http;
import 'theme_notifier.dart';

void main() {
  runApp(
    ChangeNotifierProvider(
      create: (_) => ThemeNotifier(),
      child: MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return Consumer<ThemeNotifier>(
      builder: (context, themeNotifier, child) {
        return MaterialApp(
          debugShowCheckedModeBanner: false,
          theme: themeNotifier.themeData,
          home: const MyAppExt(),
        );
      },
    );
  }
}

class MyAppExt extends StatefulWidget {
  const MyAppExt({super.key});

  @override
  State<MyAppExt> createState() => _MyAppExtState();
}

class _MyAppExtState extends State<MyAppExt> {
  String buttonName = "History";
  late stt.SpeechToText _speech;
  bool _isListening = false;
  String _transcription = "Tap to decode emotions!";
  String _emotion = "";
  late TextEditingController _controller;
  bool _isAudioMode = false;

  @override
  void initState() {
    super.initState();
    _speech = stt.SpeechToText();
    _controller = TextEditingController(text: "");
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  Future<void> sendToApi(String _transcription) async {
    try {
      final body = jsonEncode({'text': _transcription});
      print('Request body: $body');

      final response = await http.post(
        Uri.parse(
            'https://(enter your sever name: I used ngrok static servers, which do port forwarding which might help for free.)/classify_text'),
        headers: {'Content-Type': 'application/json'},
        body: jsonEncode({'text': _transcription}),
      );

      print('Response status: ${response.statusCode}');
      print('Response body: ${response.body}');

      if (response.statusCode == 200) {
        final responseData = jsonDecode(response.body);
        setState(() {
          _emotion = responseData['emotion'];
        });
      }
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Error connecting to the server.')),
      );
      print('Error: $e');
    }
  }

  void _toggleAnalysisMode() {
    setState(() {
      _isAudioMode = !_isAudioMode;
    });
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        FocusScope.of(context).unfocus();
      },
      child: Scaffold(
        appBar: AppBar(
          centerTitle: true,
          actions: [
            IconButton(
              onPressed: () {
                Navigator.of(context).push(
                  MaterialPageRoute(
                    builder: (BuildContext context) => const Settings(),
                  ),
                );
              },
              icon: const Icon(Icons.settings),
            ),
          ],
          title: GestureDetector(
            onTap: () {
              Navigator.pushAndRemoveUntil(
                context,
                MaterialPageRoute(builder: (context) => const MyAppExt()),
                (route) => false,
              );
            },
            child: const Text(
              "SentimentDecoder",
              style: TextStyle(
                fontSize: 25,
              ),
            ),
          ),
        ),
        drawer: Drawer(
          child: ListView(
            padding: EdgeInsets.zero,
            children: [
              DrawerHeader(
                decoration: BoxDecoration(
                  color: Theme.of(context).colorScheme.secondary,
                ),
                child: Text(
                  'Menu',
                  style: TextStyle(
                    color: Theme.of(context).colorScheme.onSecondary,
                    fontSize: 25,
                  ),
                ),
              ),
              ListTile(
                leading: const Icon(Icons.home),
                title: const Text(
                  'Home',
                  style: TextStyle(
                    fontWeight: FontWeight.w500,
                  ),
                ),
                onTap: () {
                  Navigator.of(context).push(
                    MaterialPageRoute(
                      builder: (BuildContext context) => const MyAppExt(),
                    ),
                  );
                },
              ),
              ListTile(
                leading: const Icon(Icons.audio_file),
                title: const Text(
                  'Audio Analysis',
                  style: TextStyle(
                    fontWeight: FontWeight.w500,
                  ),
                ),
                onTap: () {
                  Navigator.of(context).push(
                    MaterialPageRoute(
                      builder: (BuildContext context) =>
                          const AudioEmotionAnalysis(),
                    ),
                  );
                },
              ),
              ListTile(
                leading: const Icon(Icons.history),
                title: const Text(
                  'History',
                  style: TextStyle(
                    fontWeight: FontWeight.w500,
                  ),
                ),
                onTap: () {
                  Navigator.of(context).push(
                    MaterialPageRoute(
                      builder: (BuildContext context) => const History(),
                    ),
                  );
                },
              ),
              ListTile(
                leading: const Icon(Icons.info_outline_rounded),
                title: const Text(
                  'About',
                  style: TextStyle(
                    fontWeight: FontWeight.w500,
                  ),
                ),
                onTap: () {
                  Navigator.of(context).push(
                    MaterialPageRoute(
                      builder: (BuildContext context) => const About(),
                    ),
                  );
                },
              ),
            ],
          ),
        ),
        body: Column(
          children: [
            Container(
              padding:
                  const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  Text(
                    'Text',
                    style: Theme.of(context).textTheme.titleMedium,
                  ),
                  Switch(
                    value: _isAudioMode,
                    onChanged: (value) {
                      _toggleAnalysisMode();
                    },
                  ),
                  Text(
                    'Audio',
                    style: Theme.of(context).textTheme.titleMedium,
                  ),
                ],
              ),
            ),
            Expanded(
              child: _isAudioMode
                  ? const AudioEmotionAnalysis()
                  : SingleChildScrollView(
                      child: Container(
                        height: MediaQuery.of(context).size.height -
                            AppBar().preferredSize.height -
                            56,
                        child: Center(
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              const SizedBox(height: 200),
                              InkWell(
                                onTap: () async {
                                  if (!_isListening) {
                                    bool available = await _speech.initialize(
                                      onStatus: (status) =>
                                          print('Status: $status'),
                                      onError: (error) =>
                                          print('Error: $error'),
                                    );
                                    if (available) {
                                      setState(() => _isListening = true);
                                      _transcription = "I'm listening...";
                                      _speech.listen(
                                        onResult: (result) {
                                          setState(() {
                                            _transcription =
                                                result.recognizedWords;
                                            _controller.text = _transcription;
                                          });
                                          sendToApi(_transcription);
                                        },
                                      );
                                    } else {
                                      ScaffoldMessenger.of(context)
                                          .showSnackBar(
                                        const SnackBar(
                                            content: Text(
                                                "SER is sleeping, let it sleep for a while...")),
                                      );
                                    }
                                  } else {
                                    setState(() => _isListening = false);
                                    _speech.stop();
                                  }
                                },
                                child: Container(
                                  width: 200,
                                  height: 200,
                                  decoration: BoxDecoration(
                                    shape: BoxShape.circle,
                                    gradient: RadialGradient(
                                      colors: [
                                        Theme.of(context)
                                            .colorScheme
                                            .primary
                                            .withOpacity(0.5),
                                        Theme.of(context).colorScheme.surface,
                                      ],
                                      radius: 0.5,
                                    ),
                                  ),
                                  child: Center(
                                    child: Icon(
                                      Icons.mic_none_rounded,
                                      size: 50,
                                      color: Theme.of(context)
                                          .colorScheme
                                          .primary
                                          .withOpacity(0.7),
                                    ),
                                  ),
                                ),
                              ),
                              const SizedBox(height: 20),
                              Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  ShaderMask(
                                    shaderCallback: (bounds) => LinearGradient(
                                      colors: _isListening
                                          ? [
                                              Theme.of(context)
                                                  .colorScheme
                                                  .secondary,
                                              Theme.of(context)
                                                  .colorScheme
                                                  .primary
                                            ]
                                          : [
                                              Theme.of(context)
                                                  .colorScheme
                                                  .onSurface,
                                              Theme.of(context)
                                                  .colorScheme
                                                  .onSurface
                                            ],
                                      begin: Alignment.topLeft,
                                      end: Alignment.bottomRight,
                                    ).createShader(bounds),
                                    child: Text(
                                      _transcription.isNotEmpty
                                          ? _transcription
                                          : "Tap to decode emotions!",
                                      style: Theme.of(context)
                                          .textTheme
                                          .titleLarge!
                                          .copyWith(
                                            color: Colors.white,
                                            fontWeight: FontWeight.bold,
                                          ),
                                      textAlign: TextAlign.center,
                                    ),
                                  ),
                                  const SizedBox(height: 10),
                                  Text(
                                    _emotion.isNotEmpty
                                        ? "Emotion: $_emotion"
                                        : "",
                                    style: Theme.of(context)
                                        .textTheme
                                        .bodyMedium!
                                        .copyWith(
                                          fontStyle: FontStyle.italic,
                                        ),
                                  ),
                                  const SizedBox(height: 75),
                                  Padding(
                                    padding: const EdgeInsets.symmetric(
                                        horizontal: 16.0),
                                    child: TextField(
                                      controller: _controller,
                                      onChanged: (value) {
                                        setState(() {
                                          _transcription = value;
                                        });
                                        _controller.text = _transcription;
                                      },
                                      onSubmitted: (value) {
                                        sendToApi(value);
                                      },
                                      decoration: InputDecoration(
                                        hintText:
                                            "Try typing here, if that's your thing",
                                        border: OutlineInputBorder(
                                          borderRadius:
                                              BorderRadius.circular(12.0),
                                        ),
                                        suffixIcon: IconButton(
                                          icon: const Icon(Icons.send),
                                          onPressed: () {
                                            sendToApi(_transcription);
                                          },
                                        ),
                                      ),
                                      textAlign: TextAlign.left,
                                      textDirection: TextDirection.ltr,
                                      keyboardType: TextInputType.text,
                                    ),
                                  ),
                                ],
                              ),
                              const Spacer(),
                              OutlinedButton(
                                style: OutlinedButton.styleFrom(
                                  shape: const StadiumBorder(),
                                ),
                                onPressed: () {
                                  Navigator.of(context).push(
                                    MaterialPageRoute(
                                      builder: (BuildContext context) =>
                                          const History(),
                                    ),
                                  );
                                },
                                child: Text(buttonName),
                              ),
                              const SizedBox(height: 60),
                            ],
                          ),
                        ),
                      ),
                    ),
            ),
          ],
        ),
      ),
    );
  }
}
