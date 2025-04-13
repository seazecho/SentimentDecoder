# SVM-Based Speech Emotion Recognition From Audio (Ver.I)
## Dataset Information
This directory is a placeholder for the datasets used in `SentimentDecoder`, a Speech Emotion Recognition (SER) project. The actual audio files are hosted on Google Drive due to their size. Below, you’ll find details about the datasets, their naming convention, and how to access them.

## Datasets
The project uses three publicly available Speech Emotion Recognition datasets, renamed for consistency:
1. **RAVDESS (Ryerson Audio-Visual Database of Emotional Speech and Song)**  
   - Original source: [RAVDESS](https://zenodo.org/record/1188976)
   - Contains acted emotional speech from 24 actors.
2. **SAVEE (Surrey Audio-Visual Expressed Emotion)**  
   - Original source: [SAVEE](http://kahlan.eps.surrey.ac.uk/savee/)
   - Features emotional speech from 4 male speakers.
3. **TESS (Toronto Emotional Speech Set)**  
   - Original source: [TESS](https://tspace.library.utoronto.ca/handle/1807/24487)
   - Includes emotional speech from 2 female speakers.

All datasets have been renamed to follow a unified naming convention based on RAVDESS, where the third number in the filename represents the emotion label.

## Naming Convention
Filenames follow this format: `03-01-01-...wav`
- `03`: Dataset/speaker identifier (varies by dataset) only in ravdess and for others it hold no value just filled to make the third number an emotion label.
- `01`: Statement or sentence identifier (varies by dataset) only in ravdess and for others it hold no value just filled to make the third number an emotion label.
- `01`: Emotion label (consistent across all datasets, based on RAVDESS):
  - `01`: Neutral
  - `02`: Calm
  - `03`: Happy
  - `04`: Sad
  - `05`: Angry
  - `06`: Fearful
  - `07`: Disgust
  - `08`: Surprised
- Additional parts (e.g., repetition or intensity) may follow, depending on the original dataset.

## Accessing the Datasets
The renamed datasets are hosted in a single Google Drive folder with three subfolders:
- **Main Folder**: "Speech Audio Datasets"  
  - **Link**: [Google Drive](https://drive.google.com/drive/folders/1ZzjpMCv32hJtX5MvHBBSkRJ0vr9x4Lsw?usp=sharing)
  - **Subfolders**:
    - `RAVDESS Emotional Speech Dataset/`: Contains all RAVDESS audio files.
    - `SAVEE Renamed/`: Contains all SAVEE audio files.
    - `TESS Renamed/`: Contains all TESS audio files.

### How to Download
1. Open the [Google Drive](https://drive.google.com/drive/folders/1ZzjpMCv32hJtX5MvHBBSkRJ0vr9x4Lsw?usp=sharing).
2. Download the entire folder or individual subfolders (`RAVDESS`, `SAVEE_renamed`, `TESS_renamed`).
3. Update `DATASET_PATH` in `SentimentDecoder.ipynb` to point to their location by downloading and uploading it your drive and mounting that drive in CoLab if you're using that.

## Usage in the Project
- The code in `SentimentDecoder.ipynb` expects `.wav` files in a directory specified by `DATASET_PATH`.
- It processes all `.wav` files recursively, extracting the emotion label from the third number in the filename (e.g., `03` → "happy").
- Ensure your folder structure matches the expected format for the `os.walk()` function to work correctly.

## Notes
- **Size**: The datasets are large (e.g., RAVDESS ~553MB, SAVEE ~155MB, TESS ~384MB), so they’re not included in the GitHub repo.
- **Renaming**: Files were manually renamed to align with RAVDESS emotion labels (01-08). Original files may differ in emotion mapping.
- **License**: Check the original sources for usage terms (typically research-only).

## Do it
Download the datasets and update `DATASET_PATH` in the notebook to start training!
