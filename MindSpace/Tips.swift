//
//  Tips.swift
//  MindSpace
//
//  Created by paige caskey on 12/7/24.
//


import SwiftUI

// Tips page for the MindSpace app
// Randomly generates wellness tip upon pressing a button

struct Tips: View {
    // array which contains wellness tips to choose from
    let tips = [
        "Take a 5-minute break from any work.",
        "Drink water and stay hydrated.",
        "Practice breathing exercises.",
        "Take short walks outside.",
        "Ensure you get enough sleep each night.",
        "Stay connected with friends.",
        "Practice gratitude.",
        "Limit screen time before bed.",
        "Watch your favorite movie or show",
        "Eat healthy to keep balanced",
        "Make time to go to the gym",
        "Lay in the sun to get vitamins"
    ]
    
    // state variable selectedTip: holds randomly selected tip from array
    @State private var selectedTip: String = ""
    
    var body: some View {
        NavigationView {
            // zstack allows cohesive background color
            ZStack {
                Color.blue.opacity(0.1)
                    .ignoresSafeArea()
                // verticle stack to hold title, tip, and generate button
                VStack {
                    Spacer()
                    // title
                    Text("Wellness Tips")
                        .font(.system(size: 30, weight: .bold, design: .rounded))
                        .foregroundColor(.gray)
                        .padding(.top, 20)
                    Spacer()
                    // box field holds wellness tip
                    // box is empty until button is clicked and random tip is generated & assigned
                    Text(selectedTip.isEmpty ? "                          " : selectedTip)
                        .font(.system(size: 25, weight: .medium, design: .rounded))
                        .foregroundColor(.gray)
                        .multilineTextAlignment(.center)
                        .padding()
                        .background(
                            RoundedRectangle(cornerRadius: 10)
                                .stroke(Color.gray, lineWidth: 4)
                                .background(Color.white.opacity(0.3))
                        )
                        .padding()

                    // button which generates the random tip
                    Button(action: {
                        // tip is fromly generated from array of tips
                        // if no tip is available, that is displayed
                        selectedTip = tips.randomElement() ?? "No tip available at the moment."
                    }) {
                        Text("Get Random Tip")
                            .font(.system(size: 20, weight: .bold, design: .rounded))
                            .padding()
                            .background(Color.blue.opacity(0.2))
                            .foregroundColor(.white)
                            .cornerRadius(10)
                    }
                    .padding()

                    Spacer()
                }
                .padding()
            }
        }
    }
}


