import 'dart:convert';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:file_picker/file_picker.dart';
import 'package:path/path.dart' as path;

class AudioEmotionAnalysis extends StatefulWidget {
  const AudioEmotionAnalysis({super.key});

  @override
  State<AudioEmotionAnalysis> createState() => _AudioEmotionAnalysisState();
}

class _AudioEmotionAnalysisState extends State<AudioEmotionAnalysis> {
  File? _audioFile;
  String _fileName = '';
  String _audioEmotion = '';
  String _modelUsed = '';
  bool _isLoading = false;
  bool _hasError = false;
  String _selectedModel = 'svm'; // Default model will be SVM

  Future<void> _pickAudioFile() async {
    try {
      FilePickerResult? result = await FilePicker.platform.pickFiles(
        type: FileType.audio,
        allowMultiple: false,
      );

      if (result != null) {
        setState(() {
          _audioFile = File(result.files.single.path!);
          _fileName = path.basename(_audioFile!.path);
          _audioEmotion = '';
          _modelUsed = '';
          _hasError = false;
        });
      }
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Error picking audio file')),
      );
    }
  }

  Future<void> _analyzeAudio() async {
    if (_audioFile == null) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Please select an audio file first')),
      );
      return;
    }

    setState(() {
      _isLoading = true;
      _hasError = false;
      _audioEmotion = '';
      _modelUsed = '';
    });

    try {
      var request = http.MultipartRequest(
        'POST',
        Uri.parse(
            'https://better-shiner-actively.ngrok-free.app/classify_audio'),
      );

      request.files.add(
        await http.MultipartFile.fromPath(
          'audio',
          _audioFile!.path,
        ),
      );


      request.fields['model_type'] = _selectedModel;


      var streamedResponse = await request.send();
      var response = await http.Response.fromStream(streamedResponse);

      if (response.statusCode == 200) {
        var data = jsonDecode(response.body);

        setState(() {
          _audioEmotion = data['audio_emotion'];
          _modelUsed = data['model_used'];
        });
      } else {
        setState(() => _hasError = true);
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Failed to analyze audio')),
        );
      }
    } catch (e) {
      setState(() => _hasError = true);
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Error connecting to server: ${e.toString()}')),
      );
    } finally {
      setState(() => _isLoading = false);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color(0xFFffffff),
        title: const Text(
          "Audio Emotion Analysis",
          style: TextStyle(
            color: Color(0xFF0097A7),
          ),
        ),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(32.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Card(
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12),
                  side: BorderSide(
                    color: _hasError ? Colors.red : Colors.grey.shade300,
                  ),
                ),
                child: Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Column(
                    children: [
                      Icon(
                        Icons.audio_file,
                        size: 48,
                        color: _hasError ? Colors.red : const Color(0xFF032B44),
                      ),
                      const SizedBox(height: 16),
                      Text(
                        _fileName.isEmpty
                            ? 'No audio file selected'
                            : 'Selected: $_fileName',
                        style: TextStyle(
                          color: _hasError ? Colors.red : Colors.black87,
                        ),
                      ),
                      const SizedBox(height: 16),
                      ElevatedButton.icon(
                        onPressed: _isLoading ? null : _pickAudioFile,
                        style: ElevatedButton.styleFrom(
                          backgroundColor: const Color(0xFF87CEEB),
                          foregroundColor: Color(0xff032B44),
                          padding: const EdgeInsets.symmetric(
                            horizontal: 24,
                            vertical: 12,
                          ),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(8),
                          ),
                        ),
                        icon: const Icon(Icons.upload_file),
                        label: const Text('Select Audio File'),
                      ),
                    ],
                  ),
                ),
              ),
              const SizedBox(height: 24),
              Card(
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text(
                        'Select Model:',
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                          color: Color(0xFF0097A7),
                        ),
                      ),
                      const SizedBox(height: 16),
                      DropdownButtonFormField<String>(
                        decoration: InputDecoration(
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(8),
                          ),
                          contentPadding: const EdgeInsets.symmetric(
                            horizontal: 16,
                            vertical: 8,
                          ),
                        ),
                        value: _selectedModel,
                        items: const [
                          DropdownMenuItem(
                            value: 'svm',
                            child: Text('SVM'),
                          ),
                          DropdownMenuItem(
                            value: 'cnn',
                            child: Text('CNN'),
                          ),
                        ],
                        onChanged: (value) {
                          setState(() {
                            _selectedModel = value ?? 'svm';
                          });
                        },
                      ),
                    ],
                  ),
                ),
              ),
              const SizedBox(height: 24),
              ElevatedButton(
                onPressed:
                    _isLoading || _audioFile == null ? null : _analyzeAudio,
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color(0xFF0097A7),
                  padding: const EdgeInsets.symmetric(vertical: 16),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                ),
                child: _isLoading
                    ? const SizedBox(
                        height: 20,
                        width: 20,
                        child: CircularProgressIndicator(
                          color: Colors.white,
                          strokeWidth: 2,
                        ),
                      )
                    : const Text('Analyze Audio'),
              ),
              const SizedBox(height: 32),
              if (_audioEmotion.isNotEmpty && !_hasError)
                Card(
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Text(
                          'Analysis Results:',
                          style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        const SizedBox(height: 8),
                        Text(
                          'Detected Emotion: $_audioEmotion',
                          style: const TextStyle(fontSize: 16),
                        ),
                        const SizedBox(height: 4),
                        Text(
                          'Model Used: $_modelUsed',
                          style:
                              const TextStyle(fontSize: 14, color: Colors.grey),
                        ),
                      ],
                    ),
                  ),
                ),
            ],
          ),
        ),
      ),
    );
  }
}
