//
//  CompleteSignUpView.swift
//  AAC
//
//  Created by Alexandre Marquet on 28/07/2023.
//

import SwiftUI

struct CompleteSignUpView: View {
    
    @Environment(\.dismiss) var dismiss
    @EnvironmentObject var viewModel: RegistrationViewModel
    
    var body: some View {
        NavigationView {
            VStack(spacing: 24){
                GeometryReader{
                    let size = $0.size
                    
                    VStack{
                        
                        Image("4")
                            .resizable()
                            .scaledToFit()
                            .padding(15)
                            .frame(width: size.width, height: size.height / 1.6)
                        
                        Text("Bienvenue sur AAC, \(viewModel.username)")
                            .font(.title2)
                            .fontWeight(.heavy)
                            .frame(maxWidth: .infinity)
                        
                        Text("Cliquer sur le bouton pour compléter votre profil et commencer à utiliser AAC")
                            .font(.footnote)
                            .foregroundColor(.gray.opacity(0.5))
                            .multilineTextAlignment(.center)
                            .padding(.horizontal, 20)
                        
                        Spacer()
                        
                        Button {
                            impactFeedBackGenerator.impactOccurred()
                            Task { try await viewModel.createUser() }
                        } label: {
                            Text("Utiliser AAC")
                                .fontWeight(.heavy)
                                .foregroundColor(.white)
                                .padding(.vertical, 15)
                                .frame(width: size.width * 0.4)
                                .background{
                                    Capsule()
                                        .fill(Color("Blue"))
                                }
                        }

                    }
                    
                }
            }
            .toolbar{
                ToolbarItem(placement: .navigationBarLeading) {
                    Image(systemName: "chevron.left")
                        .fontWeight(.heavy)
                        .imageScale(.large)
                        .onTapGesture {
                            impactFeedBackGenerator.impactOccurred()
                            dismiss()
                        }
                }
            }
        
        }
        .navigationBarBackButtonHidden(true)
    }
    
    struct CompleteSignUpView_Previews: PreviewProvider {
        static var previews: some View {
            CompleteSignUpView()
        }
    }
}
