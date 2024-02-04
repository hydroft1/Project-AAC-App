//
//  CreateUserView.swift
//  AAC
//
//  Created by Alexandre Marquet on 28/07/2023.
//

import SwiftUI

struct CreateUserView: View {
    
    @State var username = ""
    @Environment(\.dismiss) var dismiss
    @EnvironmentObject var viewModel: RegistrationViewModel
    
    var body: some View {
        NavigationView {
            GeometryReader{
                let size = $0.size
                
                VStack{
                    
                    Image("2")
                        .resizable()
                        .scaledToFit()
                        .padding(15)
                        .frame(width: size.width, height: size.height / 1.6)
                    
                    CustomTextField(text: $viewModel.username, hint: "Votre Prénom", leadingIcon: Image(systemName: "person"))
                    
                    Spacer()
                    
                    NavigationLink {
                        CreatePasswordView()
                            
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
                    .disabled(viewModel.username == "")
                    .opacity(viewModel.username == "" ? 0.5 : 1)


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

struct CreateUserView_Previews: PreviewProvider {
    static var previews: some View {
        CreateUserView()
    }
}
