import SwiftUI

struct SignupView: View {
    @State private var name = ""
    @State private var email = ""
    @State private var creditCardNumber = ""
    @State private var cvv = ""
    @State private var expirationDate = ""
    @State private var zipCode = ""
    @State private var phoneNumber = ""
    @State private var showingHomeScreen = false // For navigating to the Home screen

    var body: some View {
        NavigationView{
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
                    Text("Sign Up")
                        .font(.largeTitle)
                        .bold()
                        .padding()
                    
                    TextField("Name", text: $name)
                        .padding()
                        .frame(width: 300, height: 50)
                        .background(Color.black.opacity(0.05))
                        .cornerRadius(10)
                    TextField("Email", text: $email)
                        .padding()
                        .frame(width: 300, height: 50)
                        .background(Color.black.opacity(0.05))
                        .cornerRadius(10)
                    TextField("Credit Card Number", text: $creditCardNumber)
                        .padding()
                        .frame(width: 300, height: 50)
                        .background(Color.black.opacity(0.05))
                        .cornerRadius(10)
                    TextField("CVV", text: $cvv)
                        .padding()
                        .frame(width: 300, height: 50)
                        .background(Color.black.opacity(0.05))
                        .cornerRadius(10)
                    TextField("Expiration Date (MM/YY)", text: $expirationDate)
                        .padding()
                        .frame(width: 300, height: 50)
                        .background(Color.black.opacity(0.05))
                        .cornerRadius(10)
                    TextField("Zip Code", text: $zipCode)
                        .padding()
                        .frame(width: 300, height: 50)
                        .background(Color.black.opacity(0.05))
                        .cornerRadius(10)
                    TextField("Phone Number", text: $phoneNumber)
                        .padding()
                        .frame(width: 300, height: 50)
                        .background(Color.black.opacity(0.05))
                        .cornerRadius(10)
                    
                    Button("Submit") {
                        // This is where you'd handle form submission.
                        // For demonstration, we'll print the CSV data to the console.
                        let csvData = generateCSV()
                        print(csvData)
                        // Simulate navigating to the Home screen after submission
                        showingHomeScreen = true
                        print("Should navigate now, showingHomeScreen: \(showingHomeScreen)")
                        
                    }
                    .foregroundColor(.white)
                    .frame(width: 300, height: 50)
                    .background(Color.orange)
                    .cornerRadius(10)
                    .padding()
                    
                    
                    // Navigation to HomeView
                    NavigationLink(destination: HomeView(), isActive: $showingHomeScreen) {
                        EmptyView()
                    }
                }
            }
        }
    }
    func generateCSV() -> String {
        let fields = [name, email, creditCardNumber, cvv, expirationDate, zipCode, phoneNumber]
        let csvString = fields.joined(separator: ",")
        // In a real app, you would send this string to your server for processing
        return csvString
    }
}

struct SignupView_Previews: PreviewProvider {
    static var previews: some View {
        SignupView()
    }
}
