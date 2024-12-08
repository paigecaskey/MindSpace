//
//  MoodModel.swift
//  MindSpace
//
//  Created by paige caskey on 12/7/24.

import Foundation
import SwiftUI
import Combine

// observable MoodModel class allows data to persist and be modified
class MoodModel: ObservableObject {
    // published moodHistory property to notify views of changes
    @Published var moodHistory: [MoodEntry] = []
    
    // determines file path for the JSON file, which stores the user's past mood history
    private var fileURL: URL {
        let documentDirectory = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first!
        // appends the file name to the document directory
        return documentDirectory.appendingPathComponent("MoodHistory.json")
    }
    
    // adds entry to published moodHistory variable and saves to JSON file
    func addEntry(_ entry: MoodEntry) {
        moodHistory.append(entry)
        saveToFile()
    }
    
    // loads past mood history from JSON file
    func loadFromFile() {
        do {
            // checks if the file exists at the path specified by fileURL variable
            if !FileManager.default.fileExists(atPath: fileURL.path) {
                // if it does not exist, an empty JSON file is created at specified location
                let emptyData = try JSONEncoder().encode([MoodEntry]())
                try emptyData.write(to: fileURL)
            } else {
                // if the file does exist, its contents are read in
                let data = try Data(contentsOf: fileURL)
                // the JSON file is decoded
                let decodedEntries = try JSONDecoder().decode([MoodEntry].self, from: data)
                // published moodHistory property takes decoded entried
                moodHistory = decodedEntries
            }
        } catch {
            // error is printed if error when loading file
            print("ERROR: \(error)")
        }
    }
    
    // saves moodHistory data to JSON file
    func saveToFile() {
        do {
            // data is encoded to file
            let data = try JSONEncoder().encode(moodHistory)
            try data.write(to: fileURL)
        } catch {
            // otherwise error is printed
            print("ERROR: \(error)")
        }
    }
}

// struct for MoodEntry
// contains unique ID, mood, confidence, and date
struct MoodEntry: Identifiable, Codable {
    var id = UUID()
    var mood: String
    var confidence: Double
    var date: Date
}


