# SentimentDecoder [Android App (G-Drive Link )](https://drive.google.com/drive/folders/1CiDUrEz2YFUkdVS2lZ6daJh1jKYJPxFy?usp=drive_link)  
**A Speech Emotion Recognition Project using audio feature extraction with SVM & CNN models, integrated into an app.**

## About the App
`SentimentDecoder` is a Flutter-based Android application designed for real-time speech and text emotion recognition. Integrated with a Flask backend, it employs Support Vector Machine (SVM) and Convolutional Neural Network (CNN) models to classify emotions such as happiness, sadness, and anger from audio inputs, using features like MFCCs and Mel-spectrograms. Additionally, it utilizes RoBERTa for text analysis to detect nuanced emotions, enhancing applications in AI-driven communication and emotional analytics.
`Note`: It works only when it's connected with the server(my laptop which has all the models required acting as a one server connection to the app, needs to be on. If you wanna test lemme know i'll turn on the server.)

## Project Overview
`SentimentDecoder` is a machine learning project designed to classify emotions from speech audio files. This repository showcases two distinct versions of the project, each leveraging different machine learning approaches and datasets for Speech Emotion Recognition (SER). Version 1 utilizes a Support Vector Machine (SVM) to predict eight emotions—neutral, calm, happy, sad, angry, fearful, disgust, and surprised—from `.wav` files, while Version 2 advances to a Convolutional Neural Network (CNN) for improved accuracy, trained on an expanded dataset. Both versions were developed in Google Colab, integrating renamed datasets to train and evaluate the models.

The core workflow includes audio feature extraction, model training with standardized or spectrogram-based inputs, and performance evaluation with visualizations. The result is a deployable model capable of real-time emotion prediction, with saved models and scalers provided for consistency.

## Version 1: SVM-Based Emotion Recognition
### Project Overview
Version 1 focuses on a robust SVM classifier to predict emotions from audio files. It integrates three renamed datasets—RAVDESS, SAVEE, and TESS—to train and evaluate the model.

### Objectives
- Extract meaningful audio features using `librosa` to represent emotional cues in speech.
- Train a robust SVM classifier to handle multi-class emotion recognition.
- Provide a reproducible pipeline for dataset preparation, model training, and inference.
- Demonstrate proficiency in machine learning, signal processing, and Python programming.

### Methodology
#### 1. Dataset Preparation
Three datasets were combined and renamed for consistency:
- **RAVDESS**: 1,440 audio files from 24 actors, covering 8 emotions.
- **SAVEE**: 480 audio files from 4 male speakers, mapped to the same emotions.
- **TESS**: 4,001 audio files from 2 female speakers, aligned to RAVDESS labels.

**Naming Convention**: Files were renamed to `03-01-01-...wav`, where `01` (third number) is the emotion label (01-08). See `data/README.md` for details.

- **Process**: The `prepare_dataset()` function recursively processes all `.wav` files in the specified `DATASET_PATH`, extracting features and saving them as `X.npy` (feature matrix) and `y.npy` (labels).

#### 2. Feature Extraction
For each audio file, the following features were extracted using `librosa`:
- **MFCCs**: 13 Mel-frequency cepstral coefficients (mean and standard deviation).
- **Delta MFCCs**: First-order derivatives of MFCCs (mean and std).
- **Pitch**: Maximum pitch values (median and std).
- **Energy**: Root mean square energy (mean and std).
- **Zero-Crossing Rate (ZCR)**: Rate of signal sign changes (mean and std).
- **Teager Energy Operator (TEO)**: Nonlinear energy measure (mean and std).

These features capture temporal and spectral characteristics of speech, forming a 60-dimensional feature vector per file (after averaging across time).

#### 3. Model Training
- **Preprocessing**: Features are standardized using `StandardScaler` to ensure zero mean and unit variance.
- **Classifier**: A linear SVM with `C=1.0` and `class_weight="balanced"` to address potential class imbalances.
- **Training**: The dataset is split 80-20 (train-test) with stratification, and the model is trained on the training set.
- **Output**: The trained model (`ser_model.pkl`) and scaler (`scaler.pkl`) are saved using `joblib`.

#### 4. Evaluation
- **Metrics**: Accuracy, precision, recall, and F1-score are computed via `classification_report`.
- **Visualization**: A confusion matrix is plotted with `seaborn` to assess performance across emotions.
- **Results**: Achieved 82% accuracy on the test set.

#### 5. Prediction
The `predict_emotion(file_path)` function:
- Extracts features from a new `.wav` file.
- Applies the saved scaler and model.
- Returns the predicted emotion (e.g., "happy").

## Version 2: CNN-Based Emotion Recognition
### Project Overview
Version 2 advances the project by implementing a CNN to classify emotions from audio data, building on the SVM approach. It utilizes four datasets—RAVDESS, SAVEE, TESS, and CREMA-D—excluding "calm" and "surprised" due to sample imbalance, and processes 13,363 files to achieve a test accuracy of 69.01%.

### Objectives
- Enhance emotion classification using a CNN trained on Mel-spectrogram features.
- Expand dataset diversity with four sources for improved model generalization.
- Optimize training with GPU acceleration and early stopping.
- Provide a scalable pipeline for real-time prediction.

### Methodology
#### 1. Dataset Preparation
Four datasets were combined and renamed for consistency, excluding "calm" and "surprised" due to sample imbalance:
- **RAVDESS**: 1,440 audio files from 24 actors.
- **SAVEE**: 480 audio files from 4 male speakers.
- **TESS**: 4,001 audio files from 2 female speakers.
- **CREMA-D**: 7,442 audio files from 91 actors.

**Naming Convention**: Files were renamed to `03-01-01-...wav`, where the third number indicates the emotion label (01-08). "Calm" (02) and "Surprised" (08) are excluded from training.

- **Access**: Datasets are hosted on Google Drive. See `data/README.md` for links.

#### 2. Feature Extraction
- Mel-spectrograms are extracted from audio files, resized to 128x128, and normalized for CNN input.

#### 3. Model Training
- **Architecture**: A CNN with four convolutional layers, batch normalization, and dropout for regularization.
- **Training**: Conducted over 50 epochs with early stopping, achieving 69.01% test accuracy and 0.6733 validation accuracy.
- **Output**: The trained model (`cnn_model.h5`) is saved and available for download.

#### 4. Evaluation
- **Metrics**: Classification report and confusion matrix assess performance.
- **Visualization**: Plots (`accuracy.png`, `confusion_matrix.png`, `epochs.png`) are included in the `CNN-based` folder.

#### 5. Prediction
The `predict_emotion(file_path)` function processes new audio files using the CNN model, returning the predicted emotion.

## Repository Structure
- **`SentimentDecoder.ipynb`**: Jupyter Notebook for Version 1 (SVM).
- **`CNN_4_Datasets_No(Calm_&_Surprised)_V2_Latest.ipynb`**: Jupyter Notebook for Version 2 (CNN).
- **`data/`**: Placeholder for datasets (see `data/README.md` for Google Drive links).
- **`CNN-based/`**: Contains Version 2 files, including `cnn_model.h5` and visualizations.
- **`Flutter App/`**: Contains the Flutter application integrating the server.
- **`models/`**: Placeholder for `ser_model.pkl` and `scaler.pkl` (Version 1).
- **`src/`**: Python scripts and utilities.
- **`requirements.txt`**: Dependency list.

## Dependencies
Install the required Python libraries:
```bash
pip install librosa numpy scikit-learn joblib seaborn matplotlib tensorflow
```

## Usage
- For Version 1: Run `SentimentDecoder.ipynb` to train the SVM or use `predict_emotion(file_path)`.
- For Version 2: Run `CNN_4_Datasets_No(Calm_&_Surprised)_V2_Latest.ipynb` to train the CNN or use its prediction function. Update `DATASET_PATH` with local dataset locations.
- Ensure models and datasets are downloaded from the respective Google Drive links.

## Notes
- **Size**: Datasets (~1.6GB for CNN, varying for SVM) and models (~60MB for CNN, smaller for SVM) are hosted externally.
- **Renaming**: Files were manually aligned with RAVDESS labels.
- **License**: Intended for research and educational purposes. Verify terms for datasets and models. Check the original main folder license for further details.
