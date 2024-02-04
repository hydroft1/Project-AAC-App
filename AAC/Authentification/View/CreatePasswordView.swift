//
//  CreatePasswordView.swift
//  AAC
//
//  Created by Alexandre Marquet on 28/07/2023.
//

import SwiftUI

struct CreatePasswordView: View {
    
    @State var password = ""
    @Environment(\.dismiss) var dismiss
    @EnvironmentObject var viewModel: RegistrationViewModel
    
    var body: some View {
        NavigationView {
            GeometryReader{
                let size = $0.size
                
                VStack{
                    
                    Image("3")
                        .resizable()
                        .scaledToFit()
                        .padding(15)
                        .frame(width: size.width, height: size.height / 1.6)
                    
                    CustomTextField(text: $viewModel.password, hint: "Votre mot de passe", leadingIcon: Image(systemName: "lock"), isPassword: true)
                    Spacer()
                    
                    NavigationLink {
                        CompleteSignUpView()
                    } label: {
                        Text("Continue")
                            .fontWeight(.heavy)
                            .foregroundColor(.white)
                            .padding(.vertical, 15)
                            .frame(width: size.width * 0.4)
                            .background{
                                Capsule()
                                    .fill(Color("Blue"))
                            }
                    }
                    .disabled(viewModel.password == "")
                    .opacity(viewModel.password == "" ? 0.5 : 1)


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
}

struct CreatePasswordView_Previews: PreviewProvider {
    static var previews: some View {
        CreatePasswordView()
    }
}
