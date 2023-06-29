//
//  Constant.swift
//  TaskManager
//
//  Created by Sévio Basilio Corrêa on 21/06/23.
//

import SwiftUI

// MARK: - Formatter

let itemFormatter: DateFormatter = {
    let formatter = DateFormatter()
    formatter.dateStyle = .short
    formatter.timeStyle = .medium
    return formatter
}()

// MARK: - UI
//var backgroundGradient: LinearGradient {
//    return LinearGradient(gradient: Gradient(colors: [Color.pink, Color.blue]), startPoint: .topLeading, endPoint: .bottomTrailing)
//}
var backgroundGradient: LinearGradient {
    return LinearGradient(gradient: Gradient(colors: [Color.yellow, Color.blue]), startPoint: .topLeading, endPoint: .bottomTrailing)
}

// MARK: - UX
let feedback = UINotificationFeedbackGenerator()
