//
//  SignUpView.swift
//  AAC
//
//  Created by Alexandre Marquet on 26/07/2023.
//

import SwiftUI


struct SignUpView: View {
    
    let impactFeedBackGenerator = UIImpactFeedbackGenerator(style: .medium)
    
    @State private var activeIntro: SignUpIntro = SignUpIntros[0]

    
    var body: some View {
        
        GeometryReader {
            let size = $0.size
            
            VStack {
                FirstSignUpView(intro: $activeIntro, size: size){
                    
                }
            }
            
        }
        .navigationBarBackButtonHidden(true)
    }
}

struct SignUpView_Previews: PreviewProvider {
    static var previews: some View{
        SignUpView()
    }
}

struct SignUpIntroView<ActionView : View >: View {
    @Binding var intro: SignUpIntro
    var size: CGSize
    var actionView: ActionView
    
    init(intro: Binding<SignUpIntro>, size: CGSize, @ViewBuilder actionView: @escaping () -> ActionView) {
        self._intro = intro
        self.size = size
        self.actionView = actionView()
        
    }
    
    @State private var showView: Bool = false
    @State private var hideWholeView: Bool = false
    
    @State private var prenom: String = ""
    @State private var nom: String = ""
    @State private var emailID: String = ""
    @State private var password: String = ""
    
    var buttonDisable = false
    
    var body: some View{
        VStack{
            GeometryReader {
                let size = $0.size
                
                Image(intro.introAssetImage)
                    .resizable()
                    .scaledToFit()
                    .padding(15)
                    .frame(width: size.width, height: size.height)
            }
            // Movin Up
            .offset(y: showView ? 0 : -size.height / 2)
            .opacity(showView ? 1 : 0)
            
            // Title & Action's
            VStack(alignment: .leading, spacing: 10) {
                Spacer(minLength: 0)
                

                
                if !intro.displayAction{
                    Group {
                        
                        VStack(spacing: 10){
                            
                            CustomTextField(text: $emailID, hint: intro.textField!, leadingIcon: Image(systemName: "envelope"))
                            
                            CustomTextField(text: $password, hint: intro.confirmField!, leadingIcon: Image(systemName: "lock"), isPassword: false)
                        }

                        
                        /// Custom Indicator View
                        CustomIndicatorView(totalPages: filteredPages.count, currentPage: filteredPages.firstIndex(of: intro) ?? 0)
                            .frame(maxWidth: .infinity)
                        
                        Spacer(minLength: 10)
                        
                        Button {
                            changeIntro()
                            impactFeedBackGenerator.impactOccurred()
                        } label: {
                            Text("Continuer")
                                .fontWeight(.heavy)
                                .foregroundColor(.white)
                                .frame(width: size.width * 0.4)
                                .padding(.vertical, 15)
                                .background{
                                    Capsule()
                                        .fill(Color("Blue"))
                                    
                                }
                        }
                        .frame(maxWidth: .infinity)
                        .disabled(emailID == "" || password == "" || emailID != password)
                        .opacity(emailID == "" || password == "" || emailID != password ? 0.5 : 1)
                        


                    }
                } else{
                    actionView
                        .offset(y: showView ? 0 : size.height / 2)
                        .opacity(showView ? 1 : 0)
                }
            }
            .frame(maxWidth: .infinity, alignment: .leading)
            // Moving Down
            .offset(y: showView ? 0 : size.height / 2)
            .opacity(showView ? 1 : 0)
        }
        
        
        .offset(y: hideWholeView ? size.height / 2 : 0)
        .opacity(hideWholeView ? 0 : 1)
        // Back Button
        .overlay(alignment: .topLeading) {
            // Hiding  it for Very First Page
            if intro != SignUpIntros.first{
                Button {
                    changeIntro(true)
                    impactFeedBackGenerator.impactOccurred()
                } label: {
                    Image(systemName: "chevron.left")
                        .font(.title2)
                        .fontWeight(.heavy)
                        .foregroundColor(.black)
                        .contentShape(Rectangle())
                    
                }
                .padding(10)
                // Animating Back Button
                // Comes From Top When Active
                .offset(y: showView ? 0 : -200)
                // Hides by Going back to Top when in active
                .offset(y: hideWholeView ? -200 : 0)
            }
        }
        .onAppear{
            withAnimation(.spring(response: 0.8, dampingFraction: 0.8, blendDuration: 0).delay(0.1)) {
                showView = true
            }
        }
        
    }
    
    // Updating Page Intro's
    func changeIntro(_ isPrevious: Bool = false){
        withAnimation(.spring(response: 0.8, dampingFraction: 0.8, blendDuration: 0)) {
            hideWholeView = true
        }
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) {
            // Updating Page
            if let index = SignUpIntros.firstIndex(of: intro), (isPrevious ? index != 0 : index != SignUpIntros.count - 1) {
                intro = isPrevious ? SignUpIntros[index - 1] : SignUpIntros[index + 1]
            } else {
                intro = isPrevious ? SignUpIntros[0] : SignUpIntros[SignUpIntros.count - 1]
            }
            // Re Animating as Split Page
            hideWholeView = false
            showView = false
            
            withAnimation(.spring(response: 0.8, dampingFraction: 0.8, blendDuration: 0)) {
                showView = true
            }
        }
        

        
        
    }
    
    var filteredPages: [SignUpIntro]{
        return SignUpIntros.filter { !$0.displayAction}
    }
}

struct FirstSignUpView<ActionView : View >: View {
    
    @StateObject var loginModel: LoginViewModel = LoginViewModel()
    @Binding var intro: SignUpIntro
    var size: CGSize
    var actionView: ActionView
    
    init(intro: Binding<SignUpIntro>, size: CGSize, @ViewBuilder actionView: @escaping () -> ActionView) {
        self._intro = intro
        self.size = size
        self.actionView = actionView()
        
    }
    
    @State private var showView: Bool = false
    @State private var hideWholeView: Bool = false
    
    var body: some View{
        
        VStack {
            GeometryReader {
                let size = $0.size
                    
                VStack {
                    
                    Image(intro.introAssetImage)
                        .resizable()
                        .scaledToFit()
                        .padding(15)
                        .frame(width: size.width / 1.3, height: size.height / 1.3)
                    
                    Spacer()
                    
                Group {
                    VStack {
                        
                        TextField("Votre prénom", text: $loginModel.name)
                            .padding(.horizontal, 15)
                            .padding(.vertical, 15)
                            .background{
                                RoundedRectangle(cornerRadius: 12, style: .continuous)
                                    .fill(.gray.opacity(0.1))
                            }
                        
                        TextField("Votre Nom", text: $loginModel.familyName)
                            .padding(.horizontal, 15)
                            .padding(.vertical, 15)
                            .background{
                                RoundedRectangle(cornerRadius: 12, style: .continuous)
                                    .fill(.gray.opacity(0.1))
                            }
                    }
                    
                }
                
                Button {
                    changeIntro()
                } label: {
                    Text("Continuer")
                        .fontWeight(.heavy)
                        .foregroundColor(.white)
                        .frame(width: size.width * 0.4)
                        .padding(.vertical, 15)
                        .background{
                            Capsule()
                                .fill(Color("Blue"))
                            
                        }
                }
                .frame(maxWidth: .infinity)
                .disabled(loginModel.name == "" || loginModel.familyName == "")
                .opacity(loginModel.name == "" || loginModel.familyName == "" ? 0.5 : 1)

                
                Spacer()
                }
            }
            .offset(y: showView ? 0 : -size.height / 2)
            .opacity(showView ? 1 : 0)
        }
    }
    
    
    
    // Updating Page Intro's
    func changeIntro(_ isPrevious: Bool = false){
        withAnimation(.spring(response: 0.8, dampingFraction: 0.8, blendDuration: 0)) {
            hideWholeView = true
        }
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) {
            // Updating Page
            if let index = SignUpIntros.firstIndex(of: intro), (isPrevious ? index != 0 : index != SignUpIntros.count - 1) {
                intro = isPrevious ? SignUpIntros[index - 1] : SignUpIntros[index + 1]
            } else {
                intro = isPrevious ? SignUpIntros[0] : SignUpIntros[SignUpIntros.count - 1]
            }
            // Re Animating as Split Page
            hideWholeView = false
            showView = false
            
            withAnimation(.spring(response: 0.8, dampingFraction: 0.8, blendDuration: 0)) {
                showView = true
            }
        }
        

        
        
    }
}
