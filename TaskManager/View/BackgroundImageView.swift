//
//  BackgroundImageView.swift
//  TaskManager
//
//  Created by Sévio Basilio Corrêa on 23/06/23.
//

import SwiftUI

struct BackgroundImageView: View {
    // MARK: - Properties

    // MARK: - Body
    var body: some View {
        Image("rocket")
            .antialiased(true)
            .resizable()
            .scaledToFill()
            .ignoresSafeArea(.all)
            .padding(.trailing, 150)
//            .padding(.bottom, -200)
    }
}

// MARK: - Preview

struct BackgroundImageView_Previews: PreviewProvider {
    static var previews: some View {
        BackgroundImageView()
    }
}
