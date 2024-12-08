//
//  MoodHistory.swift
//  MindSpace
//
//  Created by paige caskey on 12/7/24.
//

import SwiftUI
import Charts

// MoodHistory page for MindSpace app
// Allows the user to toggle between list and chart views of their mood history, and view previously logged sentiments

struct MoodHistory: View {
    // moodModel environment object: instance of MoodModel which allows MoodJournal access to changes, and read/write to MoodModel
    @EnvironmentObject var moodModel: MoodModel
    // selectedView state variable: tracks which view is currently seelcted
    @State private var selectedView = 0

    var body: some View {
        VStack(spacing: 10) { 
            // picker toggles between list and chart views
            Picker("View Mode", selection: $selectedView) {
                Text("List").tag(0) // list view - tagged as 0
                Text("Chart").tag(1) // chart view - tagged as 1
            }
            .pickerStyle(SegmentedPickerStyle()) // - segmented picker style
            .font(.system(size: 20, weight: .bold, design: .rounded))
            .background(Color.blue.opacity(0.2))
            .padding()

            Divider()
            
            // view is displayed based on picker selection - scroll view gives ability to scroll
            ScrollView {
                if selectedView == 0 {
                    MoodListView() // list view - displays list of entries
                } else {
                    MoodChartView() // chart view - displays entires in chart form
                }
            }
        }
    }
}

struct MoodListView: View {
    // moodModel environment object: instance of MoodModel which allows MoodJournal access to changes, and read/write to MoodModel
    @EnvironmentObject var moodModel: MoodModel

    var body: some View {
        // scroll view enables scrolling through list of elements
        ScrollView {
            // vertical stack organizes mood entries
            VStack(alignment: .leading, spacing: 15) {
                // iterates over each moods entry, sorted by date in descending order
                ForEach(moodModel.moodHistory.sorted(by: { $0.date > $1.date }), id: \.id) { entry in
                    VStack(alignment: .leading) {
                        // displays mood
                        Text("Mood: \(entry.mood)")
                            .font(.system(size: 20, weight: .bold, design: .rounded))
                            // color is mood-specific based on getColor function
                            .foregroundColor(getColor(for: entry.mood))
                        // displays confidence
                        Text("Confidence: \(String(format: "%.2f", entry.confidence))")
                            .font(.subheadline)
                            .foregroundColor(.gray)
                        // displays date
                        Text("Date: \(entry.date, formatter: dateFormatter)") // Formatted date
                            .font(.footnote)
                            .foregroundColor(.secondary)
                    }
                    .padding()
                    .background(
                        RoundedRectangle(cornerRadius: 10)
                            .fill(Color.blue.opacity(0.1))
                    )
                    // horizontal padding to space in middle
                    .padding(.horizontal)
                }
            }
        }
    }
    
    // date formatter - allows date to be readable
    private var dateFormatter: DateFormatter {
        let formatter = DateFormatter()
        formatter.dateStyle = .medium
        formatter.timeStyle = .short
        return formatter
    }
    
    // getColor - returns specific color based on mood
    private func getColor(for mood: String) -> Color {
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
}


// MoodChartView - displays mood data in a chart format with a legend
struct MoodChartView: View {
    // moodModel environment object: instance of MoodModel which allows MoodJournal access to changes, and read/write to MoodModel
    @EnvironmentObject var moodModel: MoodModel

    var body: some View {
        VStack {
            // title for chart view
            Text("Mood Chart")
                .font(.system(size: 25, weight: .bold, design: .rounded))
                .padding()

            // chart that displays mood history data (bar chart format)
            Chart(moodModel.moodHistory) { entry in
                BarMark(
                    // x-axis represents the date byt day
                    x: .value("Date", entry.date, unit: .day),
                    // y-axis represents the confidence given by the SentimentClassifier model
                    y: .value("Confidence", entry.confidence)
                )
                // color of each bar is based on mood, given by getColor function
                .foregroundStyle(getColor(for: entry.mood))
            }
            // labels for axis
            .chartXAxisLabel("Date")
            .chartYAxisLabel("Confidence")
            .frame(height: 300)
            .padding()

            // legend for each mood color
            HStack {
                LegendItem(color: .green, text: "Normal")
                LegendItem(color: .yellow, text: "Anxiety")
                LegendItem(color: .blue, text: "Depression")
                LegendItem(color: .red, text: "Suicidal")
            }
            .padding(.top)
        }
    }

    // getColor - returns specific color based on mood
    private func getColor(for mood: String) -> Color {
        switch mood {
        case "Normal": return .green
        case "Anxiety": return .yellow
        case "Depression": return .blue
        case "Suicidal": return .red
        default: return .gray
        }
    }
}

// view for individual legend items
struct LegendItem: View {
    var color: Color
    var text: String

    var body: some View {
        HStack {
            // circle filled with specific color
            Circle()
                .fill(color)
                .frame(width: 15, height: 15)
            // text indicating moode / label for legend item
            Text(text)
                .font(.footnote)
                .foregroundColor(.primary)
        }
    }
}






