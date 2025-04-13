This repository contains the server-side components for the SentimentDecoder Flutter App, located under `SentimentDecoder/Flutter App/server/`. These components support the application's speech emotion recognition and sentiment analysis functionalities by processing audio inputs and delivering results to the Flutter frontend. The server integrates with a Convolutional Neural Network (CNN) model derived from the `SentimentDecoder/CNN-based/` project, enhancing its emotion recognition capabilities.

#### Project Structure
- **`app.py`**: The primary Python script that serves as the backend server, managing API requests from the Flutter app, processing audio data, and interfacing with pre-trained models for emotion recognition.
- **`scaler.pkl`**: A serialized Python pickle file containing the data scaling model, essential for normalizing audio features to ensure consistent preprocessing before model inference.
- **`ser_model.pkl`**: A pre-trained speech emotion recognition model stored as a pickle file, which performs the core analysis of audio inputs to identify emotions.
- **`CNN Model Integration`**: The repository leverages the `cnn_model.h5` from the CNN-based Speech Emotion Recognition project. This model, trained on a combined dataset of RAVDESS, SAVEE, TESS, and CREMA-D (excluding "calm" and "surprised" due to sample imbalance), achieved a test accuracy of 69.01% over 50 epochs. It is available for download and integration to augment the server's capabilities.
- Access it at [Google Drive - CNN Model](https://drive.google.com/file/d/1WLBT9jHYIqRV51JURt9rl2Eh6JsSLov4/view?usp=drive_link).

#### Usage
The server operates locally and is exposed to the internet using ngrok for port forwarding. To utilize the server:
- Launch the server by executing `python app.py` in the `server/` directory, ensuring it listens on a designated port (e.g., 5000).
- Configure ngrok to forward a public URL to the local server port (e.g., `ngrok http 5000`). Record the generated ngrok URL, which the Flutter app will use to connect to the backend.
- Ensure the `scaler.pkl` and `ser_model.pkl` files are present in the `server/` directory. Additionally, download the `cnn_model.h5` from the provided Google Drive link and configure `app.py` to load this model for enhanced emotion recognition. Update the file path in the script accordingly.
- The Flutter app will send audio data to this server, which processes it using the loaded models (including the CNN model) and returns the emotion analysis results.

#### Development Notes
- The server requires a Python environment with libraries such as `pickle` for deserialization and `numpy` for numerical operations. Install these dependencies using `pip install pickle numpy`.
- The `cnn_model.h5`, sourced from the CNN-based project, was trained on Mel-spectrogram features extracted from 13,363 files across four datasets. Download and place it in the `server/` directory, updating `app.py` to incorporate it for improved performance.
- Ngrok configuration is critical for external access. Update the Flutter app's backend endpoint to the new ngrok URL each time a session restarts, as the URL changes dynamically.
- Securely manage the `scaler.pkl`, `ser_model.pkl`, and `cnn_model.h5` files to protect intellectual property and ensure data privacy, particularly in a production environment.

#### License
The application and its components are intended for research and educational purposes. Users must verify the usage terms and conditions associated with the underlying datasets and pre-trained models to ensure compliance with their respective licenses. Please check the original main folder license for further details.
