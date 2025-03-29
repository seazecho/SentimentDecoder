# SentimentDecoder
**Speech Emotion Recognition Using SVM and Audio Feature Extraction**

## Project Overview
`SentimentDecoder` is a machine learning project designed to classify emotions from speech audio files. Built as a showcase of audio signal processing and supervised learning, it leverages a Support Vector Machine (SVM) to predict eight distinct emotions—neutral, calm, happy, sad, angry, fearful, disgust, and surprised—from `.wav` files. This project was developed in Google Colab, integrating three renamed datasets (RAVDESS, SAVEE, and TESS) to train and evaluate the model.

The core workflow includes feature extraction from audio signals, model training with standardized features, and performance evaluation with visualizations. The result is a deployable model capable of real-time emotion prediction, saved alongside a feature scaler for consistency.

## Objectives
- Extract meaningful audio features using `librosa` to represent emotional cues in speech.
- Train a robust SVM classifier to handle multi-class emotion recognition.
- Provide a reproducible pipeline for dataset preparation, model training, and inference.
- Demonstrate proficiency in machine learning, signal processing, and Python programming.

## Methodology
### 1. Dataset Preparation
Three datasets were combined and renamed for consistency:
- **RAVDESS**: 1,440 audio files from 24 actors, covering 8 emotions.
- **SAVEE**: 480 audio files from 4 male speakers, mapped to the same emotions.
- **TESS**: 4,001 audio files from 2 female speakers, aligned to RAVDESS labels.

**Naming Convention**: Files were renamed to `03-01-01-...wav`, where `01` (third number) is the emotion label (01-08). See `data/README.md` for details.

- **Process**: The `prepare_dataset()` function recursively processes all `.wav` files in the specified `DATASET_PATH`, extracting features and saving them as `X.npy` (feature matrix) and `y.npy` (labels).

### 2. Feature Extraction
For each audio file, the following features were extracted using `librosa`:
- **MFCCs**: 13 Mel-frequency cepstral coefficients (mean and standard deviation).
- **Delta MFCCs**: First-order derivatives of MFCCs (mean and std).
- **Pitch**: Maximum pitch values (median and std).
- **Energy**: Root mean square energy (mean and std).
- **Zero-Crossing Rate (ZCR)**: Rate of signal sign changes (mean and std).
- **Teager Energy Operator (TEO)**: Nonlinear energy measure (mean and std).

These features capture temporal and spectral characteristics of speech, forming a 32-dimensional feature vector per file (after averaging across time).

### 3. Model Training
- **Preprocessing**: Features are standardized using `StandardScaler` to ensure zero mean and unit variance.
- **Classifier**: A linear SVM with `C=1.0` and `class_weight="balanced"` to address potential class imbalances.
- **Training**: The dataset is split 80-20 (train-test) with stratification, and the model is trained on the training set.
- **Output**: The trained model (`ser_model.pkl`) and scaler (`scaler.pkl`) are saved using `joblib`.

### 4. Evaluation
- **Metrics**: Accuracy, precision, recall, and F1-score are computed via `classification_report`.
- **Visualization**: A confusion matrix is plotted with `seaborn` to assess performance across emotions.
- **Results**: "Achieved 82% accuracy on the test set."

### 5. Prediction
The `predict_emotion(file_path)` function:
- Extracts features from a new `.wav` file.
- Applies the saved scaler and model.
- Returns the predicted emotion (e.g., "happy").

## Repository Structure
- **`SentimentDecoder.ipynb`**: Jupyter Notebook with all code (dataset prep, training, prediction).
- **`data/`**: Placeholder for datasets (see `data/README.md` for Google Drive links).
- **`models/`**: Placeholder for `ser_model.pkl` and `scaler.pkl` (see `models/README.md`).

## Dependencies
Install the required Python libraries:
```bash
pip install librosa numpy scikit-learn joblib seaborn matplotlib
