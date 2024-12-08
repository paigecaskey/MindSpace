//
//  HomePage.swift
//  MindSpace
//
//  Created by paige caskey on 12/7/24.
//

import SwiftUI

// Homepage for MindSpace app. Contains navigation links for journal, history, breath, and tips scenes

struct HomePage: View {
    // state obeject to initilize mood model and manage through the lifecycle
    @StateObject private var moodModel = MoodModel()
    var body: some View {
        NavigationView {
            ZStack {
                Color.blue.opacity(0.1) // background color light blue
                    .edgesIgnoringSafeArea(.all) // ensuring color covers entire screen
                // verticale stack for menu options and images
                VStack {
                    // page title
                    Text("MindSpace")
                        .font(.system(size: 50, weight: .bold, design: .rounded))
                        .padding()
                        .foregroundColor(.white)
                    // page icon
                    Image(systemName: "brain.head.profile")
                        .resizable()
                        .scaledToFit()
                        .foregroundColor(.gray)
                        .frame(width: 150, height: 150)
                        .padding(15)

                    // navigation link for journal view
                    // pass the environment object 'moodModel' in order for the user to make submissions
                    NavigationLink(destination: MoodJournal().environmentObject(moodModel)) {
                        Text("Journal")
                            .font(.system(size: 40, weight: .bold, design: .rounded))
                            .padding()
                            .background(Color.blue.opacity(0.2))
                            .foregroundColor(.white)
                            .cornerRadius(10)
                    }
                    
                    // navigation link for history view
                    // pass the environment object 'moodModel' in order for the user to make submissions
                    NavigationLink(destination: MoodHistory().environmentObject(moodModel)) {
                        Text("History")
                            .font(.system(size: 40, weight: .bold, design: .rounded))
                            .padding()
                            .background(Color.blue.opacity(0.2))
                            .foregroundColor(.white)
                            .cornerRadius(10)
                    }
                    .padding()
                    
                    NavigationLink(destination: Breathe()) {
                        Text("Breathe")
                            .font(.system(size: 40, weight: .bold, design: .rounded))
                            .padding()
                            .background(Color.blue.opacity(0.2))
                            .foregroundColor(.white)
                            .cornerRadius(10)
                    }
                    NavigationLink(destination: Tips()) {
                        Text("Tips")
                            .font(.system(size: 40, weight: .bold, design: .rounded))
                            .padding()
                            .background(Color.blue.opacity(0.2))
                            .foregroundColor(.white)
                            .cornerRadius(10)
                    }
                    .padding()
                }
                .padding()
                .shadow(radius: 10)
            }
        }
        // load previous mood data on appear, so data is loaded before views are displayed
        .onAppear {
            moodModel.loadFromFile()
        }
    }
}

#Preview {
    HomePage()
}
