//
//  MindSpaceApp.swift
//  MindSpace
//
//  Created by paige caskey on 12/7/24.
//

import SwiftUI

import SwiftUI

// Main entry point for MindSpace app

@main
struct MindSpace: App {
    // state object moodModel instance - holds state and tracks user entries
    @StateObject private var moodModel = MoodModel()

    var body: some Scene {
        WindowGroup {
            NavigationStack {
                // passing moodModel as an environment object to HomePage, allowing it to access and modify
                // neccessary for user journal entries
                HomePage()
                    .environmentObject(moodModel)
            }
        }
    }
}

