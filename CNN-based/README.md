#### CNN-BASED EMOTION RECOGNITION FROM AUDIO (VERSION 2)

This repository, hosted under `SentimentDecoder/CNN-based/`, contains the Jupyter notebook `CNN_4_Datasets_No(Calm_&_Surprised)_V2_Latest.ipynb`, which implements a Convolutional Neural Network (CNN) for Speech Emotion Recognition (SER). This project builds on previous SVM-based work, advancing to a CNN trained on a combined dataset from RAVDESS, SAVEE, TESS, and CREMA-D, excluding "calm" and "surprised" emotions to focus on distinct emotional patterns. The trained model and resources are available for exploration and further development.

#### PROJECT OVERVIEW
The goal is to classify emotions from audio data using a CNN. The model processes Mel-spectrogram features, achieving a test accuracy of 69.01% over 50 epochs with early stopping. The notebook includes data preparation, training, evaluation, and a prediction function for new audio files, optimized with GPU acceleration.

#### DATASET INFORMATION
This directory serves as a placeholder for the audio datasets. Due to their size, the actual files are hosted on Google Drive. The project integrates four datasets, renamed for consistency:

- **RAVDESS (RYERSON AUDIO-VISUAL DATABASE OF EMOTIONAL SPEECH AND SONG)**  
  Source: [RAVDESS](https://zenodo.org/records/1188976)  
  Features acted emotional speech from 24 actors.

- **SAVEE (SURREY AUDIO-VISUAL EXPRESSED EMOTION)**  
  Source: [SAVEE](https://www.surrey.ac.uk/speech-music-identity-emotion-database-savee)  
  Includes emotional speech from 4 male speakers.

- **TESS (TORONTO EMOTIONAL SPEECH SET)**  
  Source: [TESS](https://tspace.library.utoronto.ca/handle/1807/24487)  
  Contains emotional speech from 2 female speakers.

- **CREMA-D (CROWD-SOURCED EMOTIONAL MULTIMODAL ACTORS DATASET)**  
  Source: [CREMA-D](https://github.com/CheyneyComputerScience/CREMA-D)  
  Offers emotional speech from 91 actors.

All datasets are renamed to follow a unified RAVDESS naming convention, where the third number in the filename (e.g., "03-01-01-...wav") indicates the emotion label:  
- 1: Neutral  
- 2: Calm  
- 3: Happy  
- 4: Sad  
- 5: Angry  
- 6: Fearful  
- 7: Disgust  
- 8: Surprised  

"Calm" (2) and "surprised" (8) are excluded from training.

##### ACCESSING THE DATASETS
The renamed datasets are hosted in a Google Drive folder:  
- **MAIN FOLDER**: "Speech Audio Datasets"  
  - Link: [Google Drive - Speech Audio Datasets](https://drive.google.com/drive/folders/1ZzjpMCv32hJtX5MvHBBSkRJ0vr9x4Lsw?usp=drive_link)  
- **SUBFOLDERS**: `RAVDESS Emotional Speech Dataset/`, `SAVEE Renamed/`, `TESS Renamed/`, `CREMA-D Renamed/`.

#### CNN MODEL ACCESS
The trained CNN model (`cnn_model.h5`) is available for download:  
- Link: [Google Drive - CNN Model](https://drive.google.com/file/d/1WLBT9jHYIqRV51JURt9rl2Eh6JsSLov4/view?usp=drive_link)

#### METHODOLOGY
The project extracts Mel-spectrograms from audio files, normalizes them, and trains a CNN with four convolutional layers, batch normalization, and dropout. Evaluation includes a classification report and confusion matrix, with visualizations in the `images` folder (`accuracy.png`, `confusion_matrix.png`, `epochs.png`). The `predict_emotion` function enables emotion classification for new audio inputs.

#### KEY FINDINGS
- **ACCURACY**: 69.01% on the test set, with validation accuracy at 0.6733.  
- **STRENGTHS**: High recall for certain emotions.  
- **CHALLENGES**: Misclassifications between similar emotions suggest feature overlap.  
- **DATA**: Processed 13,363 files, with varying emotion counts.

#### PROJECT STRUCTURE
- **`CNN_4_Datasets_No(Calm_&_Surprised)_V2_Latest.ipynb`**: Main notebook with code and results.  
- **`these images`** contains training visualizations (`accuracy.png`, `confusion_matrix.png`, `epochs.png`).  
- **`cnn_model.h5`**: Trained model (download from Google Drive link).

#### USAGE
Run the notebook to train or use the `predict_emotion` function with new audio files. Update the `DATASET_PATH` to your local dataset location after downloading.

#### NOTES
- **SIZE**: Datasets (~1.6GB) and model (~60MB) are hosted externally.  
- **RENAMING**: Files were manually aligned with RAVDESS labels.  
- **LICENSE**: Check original dataset terms (typically research-only).

#### FUTURE DIRECTIONS
- Optimize audio features to reduce misclassifications.  
- Test with augmented data for "calm" and "surprised."  
- Explore deeper CNN architectures.

