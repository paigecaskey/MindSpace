//
//  MoodJournal.swift
//  MindSpace
//
//  Created by paige caskey on 12/7/24.

import SwiftUI

// Journal page for the MindSpace app
// Allows the user to enter a journal entry, of which is used as input for the MoodIdentifier model. Upon submission, the user is able to see the sentiment of their entry, along with the confidence level the model produced. 

struct MoodJournal: View {
    // moodModel environment object: instance of MoodModel which allows MoodJournal access to changes, and read/write to MoodModel
    @EnvironmentObject var moodModel: MoodModel
    // identifier state object: instance of MoodIdentifier which contains functions of natural language model for sentiment predictions
    @StateObject private var identifier = MoodIdentifier()
    // state input: tracks user input to TextEditor
    @State private var input: String = ""
    // state showResults: boolean value indicating whether the user has submitted their entry or not
    @State private var showResults: Bool = false

    var body: some View {
        NavigationView {
            // zstack allows cohesive background color
            ZStack {
                Color.blue.opacity(0.1)
                    .ignoresSafeArea()

                VStack(alignment: .center) {
                    Spacer()

                    if showResults {
                        // Display the sentiment prediction
                        Text("Submitted Successfully")
                            .font(.system(size: 20, design: .rounded))
                            .foregroundColor(.gray)
                            .padding(.bottom)
                        Text("Results:")
                            .font(.system(size: 30, weight: .bold, design: .rounded))
                            .foregroundColor(.gray)
                            .padding(.bottom)

                        Text(identifier.prediction.uppercased())
                            .font(.system(size: 45, weight: .bold, design: .rounded))
                            .foregroundColor(getColor(for: identifier.prediction))
                            .padding()

                        Text("Confidence in Results: \(String(format: "%.2f", identifier.confidence))")
                            .font(.headline)
                            .padding(.bottom)
                    } else {
                        // TextEditor for user input
                        TextEditor(text: $input)
                            .font(.system(size: 25, design: .rounded))
                            .padding(4)
                            .background(
                                RoundedRectangle(cornerRadius: 10)
                                    .stroke(Color.gray, lineWidth: 4)
                            )

                        // Submit button
                        Button(action: {
                            if !input.isEmpty {
                                identifier.predict(input)

                                let entry = MoodEntry(mood: identifier.prediction,
                                                      confidence: identifier.confidence,
                                                      date: Date())
                                moodModel.addEntry(entry)
                                showResults = true
                                input = ""
                            }
                        }) {
                            Text("Submit")
                                .font(.system(size: 40, weight: .bold, design: .rounded))
                                .padding()
                                .background(Color.blue.opacity(0.2))
                                .foregroundColor(.white)
                                .cornerRadius(10)
                        }
                        .padding()
                    }
                    Spacer()
                }
                .padding()
            }
        }
    }
}

// Function getColor
// Takes mood String as input, and outputs color based on mood
func getColor(for mood: String) -> Color {
    switch mood {
    case "Normal":
        return .green
    case "Anxiety":
        return .yellow
    case "Depression":
        return .blue
    case "Suicidal":
        return .red
    default:
        return .gray
    }
}




