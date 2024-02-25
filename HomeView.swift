import SwiftUI

struct HomeView: View {
    @State private var selectedCircle = "Family"
    let circles = ["Family", "Friends"]
    let circleBalances = ["Family": "$100,000", "Friends": "$50,000"]
    @State private var showSettings = false
    @State private var showPaymentSheet = false
    @State private var navigateToPendingWithdrawals = false
    
    var body: some View {
        NavigationStack {
            VStack {
                Picker("Select Circle", selection: $selectedCircle) {
                                    ForEach(circles, id: \.self) { circle in
                                        Text(circle).tag(circle)
                                    }
                                }
                                .pickerStyle(MenuPickerStyle())
                                .padding()



                // Existing Picker, Balance Display, and Transaction List...
                Text("Balance: \(circleBalances[selectedCircle] ?? "")")
                    .font(.title)
                    .bold()
                    .padding()
                Text("        Sarah          +          $50       ")
                    .padding()
                    .frame(width: 300, height: 50)
                    .background(Color.black.opacity(0.05))
                    .cornerRadius(10)
                
                Text("        Carla          -          $30       ")
                    .padding()
                    .frame(width: 300, height: 50)
                    .background(Color.black.opacity(0.05))
                    .cornerRadius(10)
                Text("        Mark          +          $40       ")
                    .padding()
                    .frame(width: 300, height: 50)
                    .background(Color.black.opacity(0.05))
                    .cornerRadius(10)
                Text("        Robert       -          $50       ")
                    .padding()
                    .frame(width: 300, height: 50)
                    .background(Color.black.opacity(0.05))
                    .cornerRadius(10)
                Spacer()
                HStack {
                    Spacer()
                    Button(action: {}) {
                        Image(systemName: "house")
                        Text("Home")
                    }
                    
                    Button(action: {
                        showPaymentSheet = true
                    }) {
                        Image(systemName: "dollarsign.circle")
                        Text("Payment")
                    }
                    .actionSheet(isPresented: $showPaymentSheet) {
                        ActionSheet(
                            title: Text("Payment Options"),
                            message: nil, // Corrected from 'messages' to 'message'
                            buttons: [
                                .default(Text("Pending Withdrawals")) { navigateToPendingWithdrawals = true },
                                .default(Text("Request a Withdrawal")) { /* Implement navigation or action */ },
                                .default(Text("Deposit")) { /* Implement navigation or action */ },
                                .cancel()
                            ]
                        )
                    }
                    
                    Button(action: {
                        showSettings = true // This triggers the navigation
                    }) {
                        HStack {
                            Image(systemName: "gear")
                            Text("Settings")
                        }
                    }
                    // Assuming you already have this somewhere after your VStack
                    .navigationDestination(isPresented: $showSettings) {
                        SettingsView()
                    }
                    Spacer()
                }
                .navigationTitle(Text(selectedCircle))
                .background(NavigationLink(destination: PendingWithdrawalsView(), isActive: $navigateToPendingWithdrawals) { EmptyView() })
            }
        }
    }
    
    struct HomeView_Previews: PreviewProvider {
        static var previews: some View {
            HomeView()
        }
    }
}
