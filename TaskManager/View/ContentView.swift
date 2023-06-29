//
//  ContentView.swift
//  TaskManager
//
//  Created by Sévio Basilio Corrêa on 20/06/23.
//

import SwiftUI
import CoreData

struct ContentView: View {
    // MARK: - Property
    @State var task: String = ""
    @State private var showNewTaskItem: Bool = false
    
    @State private var animationOffset: CGFloat = 0.5
    
    @AppStorage("isDarkMode") private var isDarkMode: Bool = false
    
    // Fetching Data
    @Environment(\.managedObjectContext) private var viewContext
    
    @FetchRequest(
        sortDescriptors: [NSSortDescriptor(keyPath: \Item.timestamp, ascending: true)],
        animation: .default)
    private var items: FetchedResults<Item>
    
    // MARK: - Function
    
    private func deleteItems(offsets: IndexSet) {
        withAnimation {
            offsets.map { items[$0] }.forEach(viewContext.delete)
            
            do {
                try viewContext.save()
            } catch {
                let nsError = error as NSError
                fatalError("Unresolved error \(nsError), \(nsError.userInfo)")
            }
        }
    }
    
    // MARK: - Body
    
    var body: some View {
        NavigationView {
            ZStack {
                // MARK: - Main View
                
                VStack {
                    // MARK: - Header
                    HStack(spacing: 10) {
                        // Title
                        Text("Tarefas")
                            .font(.system(.largeTitle, design: .rounded))
                            .fontWeight(.heavy)
                            .padding(.leading, 4)
                        
                        Spacer()
                        
                        // Edit Button
                        EditButton()
                            .font(.system(size: 16, weight: .semibold, design: .rounded))
                            .padding(.horizontal, 10)
                            .frame(minWidth: 70, minHeight: 24)
                            .background(
                                Capsule().stroke(Color.white, lineWidth: 2)
                            )
                        
                        // Appearence Button
                        Button(action: {
                            // Toggle Appearance
                            isDarkMode.toggle()
                            playSound(sound: "sound-tap", type: "mp3")
                        }, label: {
//                            Image(systemName: isDarkMode ? "moon.circle.fill" : "moon.circle")
                            Image(systemName: isDarkMode ? "moon.circle.fill" : "sun.max.circle.fill")
                                .resizable()
                                .frame(width: 24, height: 24)
                                .font(.system(.title, design: .rounded))
                        })
                        
                        
                    } //: HStack
                    .padding()
                    .foregroundColor(.white)
                    
                    Spacer(minLength: 80)
                    
                    // MARK: - New Task Button
                    Button(action: {
                        showNewTaskItem = true
                        playSound(sound: "sound-ding", type: "mp3")
                    }, label: {
                        Image(systemName: "plus.circle")
                            .font(.system(size: 30, weight: .semibold, design: .rounded))
                        Text("New Task")
                            .font(.system(size: 24, weight: .bold, design: .rounded))
                    })
                    .foregroundColor(.white)
                    .padding(.horizontal, 20)
                    .padding(.vertical, 15)
                    .background(
                        LinearGradient(gradient: Gradient(colors: [Color.yellow, Color.blue]), startPoint: .leading, endPoint: .trailing)
                            .clipShape(Capsule())
                    )
                    .shadow(color: Color(red: 0, green: 0, blue: 0, opacity: 0.25), radius: 8, x: 0.0, y: 4.0)
                    
                    // MARK: - Tasks
                    
                    List {
                        ForEach(items) { item in
                            ListRowItemView(item: item)
                        }
                        .onDelete(perform: deleteItems)
                        
                        if items.isEmpty {
                            Spacer()
                                .listRowBackground(Color.clear)
                        }
                        
                    } //: List
                    .listStyle(InsetGroupedListStyle())
                    .shadow(color: Color(red: 0, green: 0, blue: 0, opacity: 0.3), radius: 12)
                    .padding(.vertical, 0)
                    .frame(maxWidth: 640)
                } //: VStack
                .blur(radius: showNewTaskItem ? 8.0 : 0, opaque: false)
                .transition(.move(edge: .bottom))
                .animation(.easeOut(duration: 0.5), value: animationOffset)
                
                // MARK: - New Task Item
                if showNewTaskItem {
                    BlankView(
                        backgroundColor: isDarkMode ? Color.black : Color.gray,
                        backgroundOpacity: isDarkMode ? 0.3 : 0.5)
                        .onTapGesture {
                            withAnimation() {
                                showNewTaskItem = false
                            }
                        }
                    
                    NewTaskItemView(isShowing: $showNewTaskItem)
                }
                
            } //: ZStack
//            .navigationViewStyle(StackNavigationViewStyle())
            .scrollContentBackground(.hidden)
            .background(Color.clear)
            .navigationBarTitle("Daily Tasks", displayMode: .large)
            .navigationBarHidden(true)
            .background(
                BackgroundImageView()
                    .blur(radius: showNewTaskItem ? 8.0 : 0, opaque: false)
                    .animation(.easeOut(duration: 0.5), value: animationOffset)
            )
            .background(
                backgroundGradient.ignoresSafeArea(.all)
            )
        } //: Navigation
        .navigationViewStyle(StackNavigationViewStyle())
    }
}

// MARK: - Preview

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView().environment(\.managedObjectContext, PersistenceController.preview.container.viewContext)
    }
}
