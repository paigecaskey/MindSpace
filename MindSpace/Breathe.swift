//  Breathe.swift
//  MindSpace
//
//  Created by paige caskey on 12/7/24.
//

import SwiftUI

// Breathe page for the MindSpace app
// Produces animated circle simulating a breating exercise

struct Breathe: View {
    // state varible scale: controls scale which circle shrinks and grows
    @State private var scale: CGFloat = 1.0
    // duration of movement: 4.0 to simulate inhale/exhale
    let duration: Double = 4.0
    
    var body: some View {
        NavigationView {
            // zstack allows cohesive background color
            ZStack {
                Color.blue.opacity(0.1)
                    .ignoresSafeArea()
                // vertical stack holds text and breathing circle
                VStack {
                    Spacer()
                    // breathing circle with animation
                    Circle()
                        .foregroundColor(Color.blue.opacity(0.4))
                        .opacity(0.6)
                        .frame(width: 200, height: 200)
                        .scaleEffect(scale)
                        // animation begins on appear
                        .onAppear {
                            withAnimation(
                                // eases in and out forever and autoreverses
                                Animation.easeInOut(duration: duration)
                                    .repeatForever(autoreverses: true)
                            ) {
                                // update scale
                                scale = 1.2
                            }
                        }
                    
                    // title text
                    Text("Breathe In and Out")
                        .font(.system(size: 30, weight: .bold, design: .rounded))
                        .foregroundColor(.gray)
                        .padding()
                    
                    Spacer()
                }
                .padding()
                .shadow(radius: 10)
            }
        }
    }
}




