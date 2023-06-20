//
//  TaskManagerApp.swift
//  TaskManager
//
//  Created by Sévio Basilio Corrêa on 20/06/23.
//

import SwiftUI

@main
struct TaskManagerApp: App {
    let persistenceController = PersistenceController.shared

    var body: some Scene {
        WindowGroup {
            ContentView()
                .environment(\.managedObjectContext, persistenceController.container.viewContext)
        }
    }
}
