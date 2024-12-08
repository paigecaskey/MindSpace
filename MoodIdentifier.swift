//
//  MoodIdentifier.swift
//  MindSpace
//
//  Created by paige caskey on 12/7/24.

import SwiftUI
import CoreML
import NaturalLanguage

// MoodIdentifier class - responsible for indentifying the sentiment of a journal entry through natrual language processing
class MoodIdentifier: ObservableObject {
    // published variables: notifies oberservers when value changes
    // prediction: current prediction result from the model
    @Published var prediction: String = ""
    // confidence: confidence level of current prediction
    @Published var confidence: Double = 0.0
    // moodHistory: holds history of past mood entries (sentiment, confidence level, date)
    @Published var moodHistory: [MoodEntry] = []

    // sentimentPredictor: stores model used for sentiment analysis
    private var sentimentPredictor: NLModel?

    // initilizer for class
    init() {
        do {
            // model is configured and initilized
            let config = MLModelConfiguration()
            // load the trained model and create a natural language model instance
            let model = try SentimentClassifier(configuration: config).model
            self.sentimentPredictor = try NLModel(mlModel: model)
        } catch {
            // error message is printed if initilization fails
            print("Error initializing the model: \(error)")
        }
    }

    // function to generate predicitons of sentiment
    func predict(_ text: String) {
        // ensure the model is loaded before attempting to make predictions
        guard let predictor = sentimentPredictor else {
            print("Model not loaded")
            return
        }
        // predicted sentiment is gathered from the model
        self.prediction = predictor.predictedLabel(for: text) ?? "Unknown"
        // confidence level of prediction is gathered from the model
        let predictionSet = predictor.predictedLabelHypotheses(for: text, maximumCount: 1)
        self.confidence = predictionSet[self.prediction] ?? 0.0
    }
}

