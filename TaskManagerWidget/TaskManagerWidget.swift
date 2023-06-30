//
//  TaskManagerWidget.swift
//  TaskManagerWidget
//
//  Created by Sévio Basilio Corrêa on 30/06/23.
//

import WidgetKit
import SwiftUI

struct Provider: TimelineProvider {
    func placeholder(in context: Context) -> SimpleEntry {
        SimpleEntry(date: Date())
    }
    
    func getSnapshot(in context: Context, completion: @escaping (SimpleEntry) -> ()) {
        let entry = SimpleEntry(date: Date())
        completion(entry)
    }
    
    func getTimeline(in context: Context, completion: @escaping (Timeline<Entry>) -> ()) {
        var entries: [SimpleEntry] = []
        
        // Generate a timeline consisting of five entries an hour apart, starting from the current date.
        let currentDate = Date()
        for hourOffset in 0 ..< 5 {
            let entryDate = Calendar.current.date(byAdding: .hour, value: hourOffset, to: currentDate)!
            let entry = SimpleEntry(date: entryDate)
            entries.append(entry)
        }
        
        let timeline = Timeline(entries: entries, policy: .atEnd)
        completion(timeline)
    }
}

struct SimpleEntry: TimelineEntry {
    let date: Date
}

struct TaskManagerWidgetEntryView : View {
    var entry: Provider.Entry
    
    var body: some View {
        //        Text(entry.date, style: .time)
        
        GeometryReader { geometry in
            ZStack {
                backgroundGradient
                
                Image("person")
                    .resizable()
                    .scaledToFit()
                
                Image("logo")
                    .resizable()
                    .frame(width: 36, height: 36)
                    .offset(
                        x: (geometry.size.width / 2) - 20,
                        y: (geometry.size.height / -2) + 20
                    )
                    .padding(.top, 12)
                    .padding(.trailing, 12)
                
                HStack {
                    Text("Just Do It")
                        .foregroundColor(.white)
                        .font(.system(.footnote, design: .rounded))
                        .fontWeight(.bold)
                        .padding(.horizontal, 12)
                        .padding(.vertical, 4)
                        .background(
                            Color(red: 0, green: 0, blue: 0, opacity: 0.5)
                                .blendMode(.overlay)
                        )
                    .clipShape(Capsule())
                } //: HStack
                .padding()
                .offset(y:(geometry.size.height / 2) - 24)
            } //: ZStack
        } //: Geometry
    }
}

struct TaskManagerWidget: Widget {
    let kind: String = "TaskManagerWidget"
    
    var body: some WidgetConfiguration {
        StaticConfiguration(kind: kind, provider: Provider()) { entry in
            TaskManagerWidgetEntryView(entry: entry)
        }
        .configurationDisplayName("TaskManager Launcher")
        .description("This is an example widget for the personal Task Manager.")
    }
}

struct TaskManagerWidget_Previews: PreviewProvider {
    static var previews: some View {
        Group {
            TaskManagerWidgetEntryView(entry: SimpleEntry(date: Date()))
                .previewContext(WidgetPreviewContext(family: .systemSmall))
        }
    }
}
