//
//  AddEmailView.swift
//  AAC
//
//  Created by Alexandre Marquet on 28/07/2023.
//

import SwiftUI



struct AddEmailView: View {
    
    @State var email = ""
    @Environment(\.dismiss) var dismiss
    @EnvironmentObject var viewModel: RegistrationViewModel
    
    var body: some View {
        NavigationView {
            GeometryReader{
                let size = $0.size
                
                VStack{
                    
                    Image("1")
                        .resizable()
                        .scaledToFit()
                        .padding(15)
                        .frame(width: size.width, height: size.height / 1.6)
                    
                    CustomTextField(text: $viewModel.email, hint: "Votre adresse email", leadingIcon: Image(systemName: "envelope"))
                    
                    Spacer()
                    
                    NavigationLink {
                        CreateUserView()
                            
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
                    .disabled(viewModel.email == "")
                    .opacity(viewModel.email == "" ? 0.5 : 1)



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

struct AddEmailView_Previews: PreviewProvider {
    static var previews: some View {
        AddEmailView()
    }
}
