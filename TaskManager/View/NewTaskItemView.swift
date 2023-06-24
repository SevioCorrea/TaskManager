//
//  NewTaskItemView.swift
//  TaskManager
//
//  Created by Sévio Basilio Corrêa on 24/06/23.
//

import SwiftUI

struct NewTaskItemView: View {
    // MARK: - Properties
    @Environment(\.managedObjectContext) private var viewContext
    @State private var task: String = ""
    
    private var isButtonDesabled: Bool {
        task.isEmpty
    }
    
    // MARK: - Functions
    private func addItem() {
        withAnimation {
            let newItem = Item(context: viewContext)
            newItem.timestamp = Date()
            newItem.task = task
            newItem.completion = false
            newItem.id = UUID()
            
            do {
                try viewContext.save()
            } catch {
                let nsError = error as NSError
                fatalError("Unresolved error \(nsError), \(nsError.userInfo)")
            }
            
            task = ""
            hideKeyboard()
        }
    }
    
    // MARK: - Body
    var body: some View {
        VStack {
            Spacer()
            
            VStack {
                VStack(spacing: 16) {
                    TextField("New Task", text: $task)
                        .foregroundColor(.pink)
                        .font(.system(size: 24, weight: .bold, design: .rounded))
                        .padding()
                        .background(
                            Color(UIColor.systemGray6)
                        )
                        .cornerRadius(10)
                    
                    Button(action: {
                        addItem()
                    }, label: {
                        Spacer()
                        Text("Save")
                            .font(.system(size: 24, weight: .bold, design: .rounded))
                        Spacer()
                    })
                    .disabled(isButtonDesabled)
                    .padding()
                    .foregroundColor(.white)
                    .background(isButtonDesabled ? Color.blue : Color.pink)
                    .cornerRadius(10)
                } //: VStack
                .padding(.horizontal)
                .padding(.vertical, 20)
                .background(
                    Color.white
                )
                .cornerRadius(16)
                .shadow(color: Color(red: 0, green: 0, blue: 0, opacity: 0.65), radius: 24)
                .frame(maxWidth: 640)
            } //: VStack
            .padding()
        }
    }
}

// MARK: - Preview

struct NewTaskItemView_Previews: PreviewProvider {
    static var previews: some View {
        NewTaskItemView()
            .background(Color.gray.edgesIgnoringSafeArea(.all))
    }
}
