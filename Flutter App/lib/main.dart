import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:sentiment_infant/screens/about.dart';
import 'package:sentiment_infant/screens/history.dart';
import 'package:sentiment_infant/screens/settings.dart';
import 'package:sentiment_infant/ser.dart';
import 'package:speech_to_text/speech_to_text.dart' as stt;
import 'package:http/http.dart' as http;

void main() {
  runApp(MyApp());
}

class MyApp extends StatefulWidget {
  MyApp({super.key});
  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      debugShowCheckedModeBanner: false,
      home: MyAppExt(),
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
        backgroundColor: const Color(0xffffffff),
        appBar: AppBar(
          backgroundColor: const Color.fromARGB(255, 255, 255, 255),
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
                icon: const Icon(Icons.settings))
          ],
          title: GestureDetector(
            onTap: () {
              Navigator.pushAndRemoveUntil(
                  context,
                  MaterialPageRoute(builder: (context) => MyAppExt()),
                  (route) => false);
            },
            child: const Text(
              "SentimentDecoder",
              style: TextStyle(
                fontSize: 25,
                color: Color(0xFF0097A7),
              ),
            ),
          ),
        ),
        drawer: Drawer(
          child: ListView(
            padding: EdgeInsets.zero,
            children: [
              const DrawerHeader(
                decoration: BoxDecoration(
                  color: Color(0xFF00ABE4),
                ),
                child: Text(
                  'Menu',
                  style: TextStyle(
                    color: Color(0xFFFFFFFF),
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
                    color: Color(0xFF0097A7),
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
                    color: Color(0xFF0097A7),
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
                    color: Color(0xFF0097A7),
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
                    color: Color(0xFF0097A7),
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
              color: const Color.fromARGB(255, 255, 255, 255),
              padding:
                  const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  const Text(
                    'Text',
                    style: TextStyle(
                      color: Color(0xFF0097A7),
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  Switch(
                    value: _isAudioMode,
                    onChanged: (value) {
                      _toggleAnalysisMode();
                    },
                    activeColor: const Color.fromARGB(255, 255, 99, 99),
                    activeTrackColor: const Color.fromARGB(255, 211, 245, 255),
                    inactiveThumbColor: const Color(0xFF0097A7),
                    inactiveTrackColor:
                        const Color.fromARGB(255, 229, 249, 255),
                  ),
                  const Text(
                    'Audio',
                    style: TextStyle(
                      color: Color(0xFF0097A7),
                      fontWeight: FontWeight.bold,
                    ),
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
                                        const Color(0xFF007AFD)
                                            .withOpacity(0.5),
                                        Colors.white,
                                      ],
                                      radius: 0.5,
                                    ),
                                  ),
                                  child: const Center(
                                    child: Icon(
                                      Icons.mic_none_rounded,
                                      size: 50,
                                      color: Color.fromARGB(255, 30, 114, 211),
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
                                              Colors.green,
                                              Colors.blue
                                            ] 
                                          : [
                                              Colors.black,
                                              Colors.black
                                            ],
                                      begin: Alignment.topLeft,
                                      end: Alignment.bottomRight,
                                    ).createShader(bounds),
                                    child: Text(
                                      _transcription.isNotEmpty
                                          ? _transcription
                                          : "Tap to decode emotions!",
                                      style: const TextStyle(
                                        fontSize: 20,
                                        fontWeight: FontWeight.bold,
                                        color: Colors.white,
                                      ),
                                      textAlign: TextAlign.center,
                                    ),
                                  ),
                                  const SizedBox(height: 10),
                                  Text(
                                    _emotion.isNotEmpty
                                        ? "Emotion: $_emotion"
                                        : "",
                                    style: const TextStyle(
                                      color: Color(0xFF0097A7),
                                      fontSize: 16,
                                      fontStyle: FontStyle.italic,
                                    ),
                                    textAlign: TextAlign.center,
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
                                        focusedBorder: OutlineInputBorder(
                                          borderRadius:
                                              BorderRadius.circular(12.0),
                                          borderSide: const BorderSide(
                                            color: Colors.teal,
                                            width: 2.0,
                                          ),
                                        ),
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
                                  foregroundColor: const Color(0xFF0097A7),
                                  shape: const StadiumBorder(),
                                  side: const BorderSide(
                                      width: 1, color: Color(0xFF0097A7)),
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
