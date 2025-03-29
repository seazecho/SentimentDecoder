# SentimentDecoder
A Speech Emotion Recognition model using SVM and audio feature extraction.

# SentimentDecoder
A Speech Emotion Recognition (SER) model that classifies emotions from audio files using machine learning.

## Overview
`SentimentDecoder` is a project that analyzes `.wav` audio files to predict emotions such as "happy," "sad," "angry," and more. It extracts audio features like MFCCs, pitch, and energy using `librosa`, then trains a Support Vector Machine (SVM) to classify emotions. This was built in Google Colab to showcase my skills in audio processing and machine learning.

## How It Works
1. **Feature Extraction**: Processes audio files to extract features like Mel-frequency cepstral coefficients (MFCCs), delta MFCCs, pitch, energy, zero-crossing rate (ZCR), and Teager Energy Operator (TEO).
2. **Training**: Uses a linear SVM with balanced class weights to handle uneven emotion distributions.
3. **Evaluation**: Measures performance with accuracy, a confusion matrix, and a classification report.
4. **Prediction**: Takes any `.wav` file and predicts its emotion.

## Emotions Recognized
- 0: Neutral
- 1: Calm
- 2: Happy
- 3: Sad
- 4: Angry
- 5: Fearful
- 6: Disgust
- 7: Surprised

## Requirements
To run this project, install the following Python libraries:
- `librosa` (for audio feature extraction)
- `numpy` (for numerical operations)
- `scikit-learn` (for SVM and evaluation)
- `joblib` (for model saving/loading)
- `seaborn` (for visualization)
- `matplotlib` (for plotting)

Install them with:
```bash
pip install librosa numpy scikit-learn joblib seaborn matplotlib
