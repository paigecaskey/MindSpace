# MindSpace

MindSpace is a wellness app designed to help users track and visualize their moods over time. Using a natural language processing model, the user is able to input journal entries which are then classified/flagged for negetive sentiment. These classifications are then logged and saved for future reference, and the user is able to view the history of their classified mood based on model predictions.

## Features

- **Mood History Tracking**: View your past mood entries in a detailed list format, complete with date, mood type, and confidence level.
- **Chart Visualization**: Analyze mood trends over time through an interactive bar chart that shows confidence levels for each entry.
- **Color-Coded Mood Indicators**: Moods are displayed with distinct colors for easy identification:
  - **Normal**: Green
  - **Anxiety**: Yellow
  - **Depression**: Blue
  - **Suicidal**: Red
- **Segmented Picker**: Toggle between list and chart views for flexible data presentation.

## Project Structure

- **HomePage.swift**: Home page which allows the user to navigate between miltiple difference scenes
- **MoodHistory.swift**: Allows user to view the history of journal entries through reading a JSON file, created upon app inilitilization. Includes the mood history tracker with toggle functionality for list and chart views, with list views sorted by most recent date.
- **MoodJournal.swift**: Scene which allows the user to submit a journal entry, which will be written to a JSON file and stored for later viewing. The journal entry is then passed through a SentimentClassifier machine learning model, which classifies the mood of the entry. Only negetive moods are flagged, indicating depression, anxiety, suicidal, or normal if the entry doesn't indicate any of those things. This data is also stored.
- **MoodModel.swift**: Contains functionality to read and write to the JSON file which contains the user's entry data, and also a structure that is able to format the model predictions to an entry that can be saved and modified by other classes. 
- **MoodIdentifier.swift**: This class contains all methods and functions for use of the SentimentClassifier model, including configuration and a predict function. 
- **MindSpaceApp.swift** - Main entry point for app, controls view and scene structure
- **SentimentClassifier.mlmodel**: Machine learning model used to classify the user's journal entry. This model produces predictions which are logged and saved for the user's future reference.

## Sources Referenced
- Kaggle Data - Sentiment Analysis for Mental Health
https://www.kaggle.com/datasets/suchintikasarkar/sentiment-analysis-for-mental-health
- Swift Charts Documentation
https://developer.apple.com/documentation/charts
- How To Work With JSON In Swift - Medium Article
https://medium.com/swlh/how-to-work-with-json-in-swift-83cd93a837e
- Natural Language Swift Documentation
https://developer.apple.com/documentation/naturallanguage/


