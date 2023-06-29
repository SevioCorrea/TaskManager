//
//  CheckboxStyle.swift
//  TaskManager
//
//  Created by Sévio Basilio Corrêa on 27/06/23.
//

import SwiftUI

struct CheckboxStyle: ToggleStyle {
    // MARK: - Properties

    // MARK: - Body
    func makeBody(configuration: Configuration) -> some View {
        return HStack {
            Image(systemName: configuration.isOn ? "checkmark.circle.fill" : "circle")
                .foregroundColor(configuration.isOn ? Color.pink : Color.primary)
                .font(.system(size: 30, weight: .semibold, design: .rounded))
                .onTapGesture {
                    configuration.isOn.toggle()
                    feedback.notificationOccurred(.success)
                    
                    if configuration.isOn {
                        playSound(sound: "sound-rise", type: "mp3")
                    } else {
                        playSound(sound: "sound-tap", type: "mp3")
                    }
                }
            
            configuration.label
        } //: HStack
    }
}

// MARK: - Preview

struct CheckboxStyle_Previews: PreviewProvider {
    static var previews: some View {
//        CheckboxStyle()
        Toggle("Placeholder Label", isOn: .constant(true))
            .toggleStyle(CheckboxStyle())
            .padding()
            .previewLayout(.sizeThatFits)
    }
}
