//
//  StartingView.swift
//  AAC
//
//  Created by Alexandre Marquet on 26/07/2023.
//

import SwiftUI

//MARK: Vibration on tap
let impactFeedBackGenerator = UIImpactFeedbackGenerator(style: .medium)
// impactFeedBackGenerator.impactOccurred()


struct StartingView: View {
    @State private var activeIntro: PageIntro = pageIntros[0]
    @StateObject var loginModel: LoginViewModel = LoginViewModel()
    @State private var keyboardHeight: CGFloat = 0
    @StateObject var registrationViewModel = RegistrationViewModel()
    @State var alertMsg: AuthService = AuthService()

    
    var body: some View {
        NavigationView {
            GeometryReader {
                    let size = $0.size
                    
                    IntroView(intro: $activeIntro, size: size) {
                        VStack(spacing: 10){
                            CustomTextField(text: $loginModel.email, hint: "Email Adress", leadingIcon: Image(systemName: "envelope"))
                                .keyboardType(.emailAddress)
                                .textInputAutocapitalization(.never)
                            CustomTextField(text: $loginModel.password, hint: "Your Password", leadingIcon: Image(systemName: "lock"), isPassword: true)
                                .textInputAutocapitalization(.never)
                            
                            VStack(alignment: .leading){
                                Text("Vous n'avez pas de compte ?")
                                    .foregroundColor(.gray.opacity(0.5))
                                
                                NavigationLink {
                                   AddEmailView()
                                        .environmentObject(registrationViewModel)
                                        .navigationBarBackButtonHidden(true)
                                } label: {
                                        Text("Créer un compte")
                                            .underline()
                                            .foregroundColor(Color("Yellow"))
                                }
                                



                            }
                            .frame(maxWidth: .infinity)
                            
                            Spacer(minLength: 10)
                            
                            Button {
                                Task { try await loginModel.signIn() }
                                impactFeedBackGenerator.impactOccurred()
                                
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
                            .alert(isPresented: $alertMsg.showerror, content: {
                                Alert(
                                    title: Text("Erreur"),
                                    message: Text(alertMsg.messageError),
                                    primaryButton: .cancel(),
                                    secondaryButton: .default(Text("Ok"))
                                
                            )})
                            .disabled(loginModel.email == "" || loginModel.password == "")
                            .opacity(loginModel.email == "" || loginModel.password == "" ? 0.5 : 1)

                        }
                        .padding(.top, 25)
                    }
                }
                .padding(15)
                // Manual Keyboard Push
                .offset(y: -keyboardHeight)
                // Disabling Native Keyboard Push
                .ignoresSafeArea(.keyboard, edges: .all)
                .onReceive(NotificationCenter.default.publisher(for: UIResponder.keyboardWillShowNotification)) { output in
                    if let info = output.userInfo, let height = (info[UIResponder.keyboardFrameEndUserInfoKey] as? NSValue)?.cgRectValue.height {
                        keyboardHeight = height
                    }
                }
                .onReceive(NotificationCenter.default.publisher(for: UIResponder.keyboardWillHideNotification)) { _ in
                        keyboardHeight = 0
                }
            .animation(.spring(response: 0.5, dampingFraction: 0.8, blendDuration: 0), value: keyboardHeight)
        }

        
    }
}

struct StartingView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}

// Intro View
struct IntroView<ActionView : View>: View {
    @Binding var intro: PageIntro
    var size: CGSize
    var actionView: ActionView
    
    init(intro: Binding<PageIntro>, size: CGSize, @ViewBuilder actionView: @escaping () -> ActionView) {
        self._intro = intro
        self.size = size
        self.actionView = actionView()
        
    }
    
    @State private var showView: Bool = false
    @State private var hideWholeView: Bool = false
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
                
                Text(intro.title)
                    .font(.system(size: 40))
                    .fontWeight(.black)
                
                if !intro.displayAction{
                    Group {
                        Spacer(minLength: 25)
                        
                        /// Custom Indicator View
                        CustomIndicatorView(totalPages: filteredPages.count, currentPage: filteredPages.firstIndex(of: intro) ?? 0)
                            .frame(maxWidth: .infinity)
                        
                        Spacer(minLength: 10)
                        
                        Button {
                            changeIntro()
                            impactFeedBackGenerator.impactOccurred()
                        } label: {
                            Text("C'est Parti !")
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
            if intro != pageIntros.first{
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
            if let index = pageIntros.firstIndex(of: intro), (isPrevious ? index != 0 : index != pageIntros.count - 1) {
                intro = isPrevious ? pageIntros[index - 1] : pageIntros[index + 1]
            } else {
                intro = isPrevious ? pageIntros[0] : pageIntros[pageIntros.count - 1]
            }
            // Re Animating as Split Page
            hideWholeView = false
            showView = false
            
            withAnimation(.spring(response: 0.8, dampingFraction: 0.8, blendDuration: 0)) {
                showView = true
            }
        }
        

        
        
    }
    
    var filteredPages: [PageIntro]{
        return pageIntros.filter { !$0.displayAction}
    }
}
