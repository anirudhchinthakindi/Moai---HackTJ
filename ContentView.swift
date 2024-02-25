import SwiftUI

struct ContentView: View {
    @State private var username = ""
    @State private var password = ""
    @State private var wrongUsername = 0
    @State private var wrongPassword = 0
    @State private var showingLoginScreen = false
    @State private var showingSignupScreen = false
    @State private var showingHomeScreen = false// Added for signup navigation

    var body: some View {
        NavigationView {
            ZStack {
                Color.orange
                    .ignoresSafeArea()
                Circle()
                    .scale(1.7)
                    .foregroundColor(.white.opacity(0.15))
                Circle()
                    .scale(1.35)
                    .foregroundColor(.white.opacity(0.15))

                VStack {
                    Text("Moai")
                        .font(.largeTitle)
                        .bold()
                        .padding()

                    Text("Login")
                        .font(.headline)
                        .bold()
                        .padding()

                    TextField("Username", text: $username)
                        .padding()
                        .frame(width: 300, height: 50)
                        .background(Color.black.opacity(0.05))
                        .cornerRadius(10)
                        .border(.red, width: CGFloat(wrongUsername))

                    SecureField("Password", text: $password)
                        .padding()
                        .frame(width: 300, height: 50)
                        .background(Color.black.opacity(0.05))
                        .cornerRadius(10)
                        .border(.red, width: CGFloat(wrongPassword))

                    Button("Login") {
                        authenticateUser(username: username, password: password)
                    }
                    .foregroundColor(.white)
                    .frame(width: 300, height: 50)
                    .background(Color.orange)
                    .cornerRadius(10)

                    NavigationLink(destination: HomeView(), isActive: $showingHomeScreen) {
                        EmptyView()
                    }

                    // Modified part for navigating to SignupView
                    NavigationLink(destination: SignupView(), isActive: $showingSignupScreen) {
                        Button("Sign Up") {
                            showingSignupScreen = true
                        }
                        .frame(width: 300, height: 50)
                    }

                }
            }
        }
        .navigationBarHidden(true)
    }

    func authenticateUser(username: String, password: String) {
        if username.lowercased() == "rpasula17" {
            wrongUsername = 0
            if password.lowercased() == "ch3fcurry" {
                wrongUsername = 0
                showingHomeScreen = true
            } else {
                wrongPassword = 2
            }
        } else {
            wrongUsername = 2
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
