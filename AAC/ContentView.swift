import SwiftUI

struct ContentView: View {
    
    @StateObject var viewModel = ContentViewModel()
    @StateObject var registrationViewModel = RegistrationViewModel()
    
    var body: some View {
        StartingView()
            .environmentObject(registrationViewModel)

        }
}


struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        StartingView()
    }
}
