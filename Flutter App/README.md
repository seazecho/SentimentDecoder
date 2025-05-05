# SentimentDecoder [Android App (G-Drive Link )](https://drive.google.com/file/d/17dCfeFg04KEbwpqCRbyP204jEfWEoV5v/view?usp=sharing)  
**A Speech Emotion Recognition Project using audio feature extraction with SVM & CNN models, integrated into an app.**

## About the App
`SentimentDecoder` is a Flutter-based Android application designed for real-time speech and text emotion recognition. Integrated with a Flask backend, it employs Support Vector Machine (SVM) and Convolutional Neural Network (CNN) models to classify emotions such as happiness, sadness, and anger from audio inputs, using features like MFCCs and Mel-spectrograms. Additionally, it utilizes RoBERTa for text analysis to detect nuanced emotions, enhancing applications in AI-driven communication and emotional analytics.
`Note`: It works only when it's connected with the server(my laptop which has all the models required acting as a one server connection to the app, needs to be on. If you wanna test lemme know i'll turn on the server.)


## Flutter App Requirements
This repository contains the source code for a Flutter-based mobile application under `SentimentDecoder/Flutter App/`, designed to provide a cross-platform interface for speech emotion recognition and sentiment analysis. The application leverages a backend server for processing audio inputs and delivering detailed emotion and sentiment insights, optimized for deployment on both iOS and Android platforms.

#### Project Structure
- **`lib/`**: Houses the core Dart files responsible for the application's user interface and business logic.
  - **`screens/`**: Contains individual Dart files dedicated to specific application screens, such as `settings.dart`, which manages configuration and user preferences within the app.
  - **`main.dart`**: Serves as the primary entry point of the application, orchestrating the initialization process, navigation flow, and overall app lifecycle management.
  - **`ser.dart`**: Implements the audio emotion analysis screen, a critical component that handles the loading and integration of pre-trained models (e.g., `ser_model.pkl` and `scaler.pkl`), processes audio inputs, and presents the resulting emotion analysis to the user. This file is central to the app's core functionality, managing model initialization, data preprocessing, and real-time result rendering.
- **`server/`**: Encompasses the backend infrastructure supporting the application's processing needs.
  - **`app.py`**: The main Python script that powers the server-side operations, facilitating communication between the Flutter app and the machine learning models, handling API requests, and executing the emotion recognition logic.
  - **`scaler.pkl`**: A serialized Python pickle file containing the data scaling model used to normalize audio input features, ensuring consistency and accuracy in the preprocessing stage.
  - **`ser_model.pkl`**: A pre-trained machine learning model file, also stored as a pickle object, which performs the core speech emotion recognition tasks based on the processed audio data.
- **`pubspec.yaml`**: The configuration file for the Flutter project, detailing all necessary dependencies, assets, and settings required to build and run the application effectively.

#### Usage
The application is designed to operate with a locally hosted backend, utilizing ngrok for port forwarding to expose the server to the internet, enabling seamless communication between the Flutter app and the backend. To use the app:
- Ensure the backend server is running on your local machine. Start the server by executing `python app.py` within the `server/` directory.
- Configure ngrok to forward a public URL to your local server port (e.g., `ngrok http 5000` if the server runs on port 5000). Note the generated ngrok URL, which will be used by the app to connect to the backend.
- Launch the Flutter app on a connected device or emulator using `flutter run` from the project root directory.
- Navigate to the audio emotion analysis screen via `ser.dart`, where you can record or upload audio files. The screen will load the `ser_model.pkl` and `scaler.pkl` models from the backend, process the audio input, and display the emotion analysis results in real-time.

#### Development Notes
- The app is built with the latest stable release of the Flutter SDK. Developers should verify compatibility and update the environment as needed to avoid build issues.
- The backend relies on a Python environment configured with essential libraries, including `pickle` for model deserialization and `numpy` for numerical computations. Ensure these are installed (e.g., via `pip install pickle numpy`) before running the server.
- The `scaler.pkl` and `ser_model.pkl` files are critical assets that must be securely managed. Avoid exposing these files publicly and consider encrypting them in a production environment to protect intellectual property and ensure data privacy.
- Ngrok configuration requires careful management of the generated URLs. Update the app's backend endpoint in the code (e.g., within `ser.dart`) to match the ngrok URL each time a new tunnel is created, as these URLs change with each ngrok session.

#### License
The application and its components are intended for research and educational purposes. Users must verify the usage terms and conditions associated with the underlying datasets and pre-trained models to ensure compliance with their respective licenses. Please check the original main folder license for further details.
