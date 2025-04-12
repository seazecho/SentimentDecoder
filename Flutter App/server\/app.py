from flask import Flask, request, jsonify
from transformers import pipeline
import librosa
import numpy as np
import joblib
import os
import logging
import tensorflow as tf

# Set up logging
logging.basicConfig(level=logging.INFO, format="%(asctime)s [%(levelname)s]: %(message)s")

app = Flask(__name__)

# Load Audio Emotion Models
logging.info("Loading audio emotion models...")

# Load SVM model
audio_svm_model = joblib.load("ser_model.pkl")
scaler = joblib.load("scaler.pkl")

# Load CNN model
logging.info("Loading CNN model...")
cnn_model = tf.keras.models.load_model("cnn_model.h5")

# Emotion labels for both models
EMOTION_LABELS = {
    0: "neutral", 1: "calm", 2: "happy", 3: "sad",
    4: "angry", 5: "fearful", 6: "disgust", 7: "surprised"
}

# Load text emotion classification model
logging.info("Loading emotion classification model...")
emotion_classifier = pipeline('text-classification', model="SamLowe/roberta-base-go_emotions", top_k=None)

def classify_emotion_X(text):
    """Classify emotion from the given text."""
    try:
        results = emotion_classifier(text)[0]
        max_score = max(results, key=lambda x: x['score'])
        return max_score['label'] if max_score['score'] >= 0.5 else 'neutral'
    except Exception as e:
        logging.error(f"Error classifying emotion: {e}")
        return 'unknown'

@app.route('/classify_text', methods=['POST'])
def classify_emotion_endpoint():
    """API endpoint to classify emotion from transcribed text."""
    try:
        # Extract text from the JSON request body
        data = request.get_json()
        text = data.get('text', '')

        if not text:
            return jsonify({'error': 'No text provided'}), 400

        # Classify emotion
        emotion = classify_emotion_X(text)
        return jsonify({'text': text, 'emotion': emotion})
    except Exception as e:
        logging.error(f"Error in API: {e}")
        return jsonify({'error': 'Internal server error'}), 500

def extract_audio_features_svm(file_path):
    """Extract MFCC, pitch, energy, ZCR from audio file for SVM model"""
    signal, sr = librosa.load(file_path, sr=16000)
    signal = librosa.util.normalize(signal)

    mfccs = librosa.feature.mfcc(y=signal, sr=sr, n_mfcc=13)
    delta_mfccs = librosa.feature.delta(mfccs)
    pitches, magnitudes = librosa.core.piptrack(y=signal, sr=sr)
    pitch = np.max(pitches, axis=0)
    energy = librosa.feature.rms(y=signal)
    zcr = librosa.feature.zero_crossing_rate(y=signal)
    teo = np.zeros(len(signal) - 2)
    for i in range(1, len(signal) - 1):
        teo[i-1] = signal[i]**2 - signal[i-1] * signal[i+1]

    mfccs_mean = np.mean(mfccs, axis=1)
    mfccs_std = np.std(mfccs, axis=1)

    delta_mfccs_mean = np.mean(delta_mfccs, axis=1)
    delta_mfccs_std =np.std(delta_mfccs, axis=1)

    pitch_median = np.median(pitch)
    pitch_std = np.std(pitch)

    energy_mean = np.mean(energy)
    energy_std = np.std(energy)

    zcr_mean = np.mean(zcr)
    zcr_std = np.std(zcr)

    teo_mean = np.mean(teo)
    teo_std = np.std(teo)

    features = np.hstack([
        mfccs_mean, mfccs_std,
        delta_mfccs_mean, delta_mfccs_std,
        pitch_median, pitch_std,
        energy_mean, energy_std,
        zcr_mean, zcr_std,
        teo_mean, teo_std
    ])
    return features

def extract_mel_spectrogram(file_path):
    """Extract Mel-Spectrogram features for CNN model"""
    signal, sr = librosa.load(file_path, sr=16000)  # Load audio at 16000 Hz
    mel_spec = librosa.feature.melspectrogram(y=signal, sr=sr, n_mels=128)  # Create mel-spectrogram
    mel_spec_db = librosa.power_to_db(mel_spec, ref=np.max)  # Convert to decibels
    mel_spec_db = tf.image.resize(mel_spec_db[..., np.newaxis], [128, 128]).numpy()  # Resize to 128x128
    # Normalize features
    mel_spec_db = (mel_spec_db - mel_spec_db.mean()) / mel_spec_db.std()
    return mel_spec_db

def classify_audio_emotion_svm(file_path):
    """Predict emotion from audio using the trained SVM model"""
    features = extract_audio_features_svm(file_path)
    features = scaler.transform([features])
    emotion_code = audio_svm_model.predict(features)[0]
    return EMOTION_LABELS[emotion_code]

def classify_audio_emotion_cnn(file_path):
    """Predict emotion from audio using the CNN model"""
    features = extract_mel_spectrogram(file_path)
    features = features[np.newaxis, ...]  # Add batch dimension
    emotion_code = np.argmax(cnn_model.predict(features), axis=1)[0]
    return EMOTION_LABELS[emotion_code]

@app.route('/classify_audio', methods=['POST'])
def classify_audio_emotion_endpoint():
    """API endpoint to classify emotions from audio"""
    model_type = request.form.get("model_type", "svm")  # Default to SVM if not specified
    file = request.files.get("audio")
    
    if not file:
        return jsonify({"error": "No audio file provided"}), 400

    audio_emotion = "unknown"
    file_path = "temp_audio.wav"
    
    try:
        file.save(file_path)
        
        # Use appropriate model based on request
        if model_type.lower() == "cnn":
            audio_emotion = classify_audio_emotion_cnn(file_path)
            model_used = "CNN"
        else:  # Default to SVM
            audio_emotion = classify_audio_emotion_svm(file_path)
            model_used = "SVM"
            
        os.remove(file_path)  # Clean up
        return jsonify({
            "audio_emotion": audio_emotion,
            "model_used": model_used
        })
    
    except Exception as e:
        logging.error(f"Error classifying audio emotion: {e}")
        if os.path.exists(file_path):
            os.remove(file_path)  # Clean up in case of error
        return jsonify({"error": f"Error processing audio: {str(e)}"}), 500

@app.route('/classify_audio_both', methods=['POST'])
def classify_audio_both_models():
    """API endpoint to classify emotions from audio using both SVM and CNN models"""
    file = request.files.get("audio")
    
    if not file:
        return jsonify({"error": "No audio file provided"}), 400

    svm_emotion = "unknown"
    cnn_emotion = "unknown"
    file_path = "temp_audio.wav"
    
    try:
        file.save(file_path)
        
        # Get predictions from both models
        svm_emotion = classify_audio_emotion_svm(file_path)
        cnn_emotion = classify_audio_emotion_cnn(file_path)
            
        os.remove(file_path)  # Clean up
        return jsonify({
            "svm_emotion": svm_emotion,
            "cnn_emotion": cnn_emotion
        })
    
    except Exception as e:
        logging.error(f"Error classifying audio emotion: {e}")
        if os.path.exists(file_path):
            os.remove(file_path)  # Clean up in case of error
        return jsonify({"error": f"Error processing audio: {str(e)}"}), 500

if __name__ == "__main__":
    app.run(debug=True, port=5000)