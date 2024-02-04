//
//  HomeView.swift
//  AAC
//
//  Created by Alexandre Marquet on 26/07/2023.
//

import SwiftUI

struct HomeView: View {
    
    let vibration = UIImpactFeedbackGenerator(style: .rigid)
    
    var body: some View {
        Text("Bienvenue Dans AAC")
            .fontWeight(.black)
        Button {
            AuthService.shared.signout()
            vibration.impactOccurred()
        } label: {
            Text("Log Out")
        }

    }
}

struct HomeView_Previews: PreviewProvider {
    static var previews: some View {
        HomeView()
    }
}
