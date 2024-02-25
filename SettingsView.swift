import SwiftUI

struct SettingsView: View {
    var body: some View {
        NavigationView {
            List {
                Section(header: Text("Profile")) {
                    NavigationLink(destination: Text("General Profile Settings")) {
                        Text("General Profile Settings")
                    }
                    NavigationLink(destination: Text("Linked Accounts")) {
                        Text("Linked Accounts")
                    }
                }
                
                Section(header: Text("Finance")) {
                    NavigationLink(destination: Text("Percentage Deposit")) {
                        Text("Percentage Deposit")
                    }
                    NavigationLink(destination: Text("Payment Preferences")) {
                        Text("Payment Preferences")
                    }
                    NavigationLink(destination: Text("Transaction Limits")) {
                        Text("Transaction Limits")
                    }
                }
                
                Section(header: Text("Security")) {
                    NavigationLink(destination: Text("Privacy and Security")) {
                        Text("Privacy and Security")
                    }
                    NavigationLink(destination: Text("Two-Factor Authentication")) {
                        Text("Two-Factor Authentication")
                    }
                    NavigationLink(destination: Text("Change Password")) {
                        Text("Change Password")
                    }
                }
                
                Section(header: Text("Notifications")) {
                    NavigationLink(destination: Text("Push Notifications")) {
                        Text("Push Notifications")
                    }
                    NavigationLink(destination: Text("Email Notifications")) {
                        Text("Email Notifications")
                    }
                    NavigationLink(destination: Text("SMS Alerts")) {
                        Text("SMS Alerts")
                    }
                }

                Section(header: Text("About")) {
                    NavigationLink(destination: Text("Terms of Service")) {
                        Text("Terms of Service")
                    }
                    NavigationLink(destination: Text("Privacy Policy")) {
                        Text("Privacy Policy")
                    }
                    NavigationLink(destination: Text("About Us")) {
                        Text("About Us")
                    }
                }
            }
            .navigationTitle("Settings")
            .listStyle(GroupedListStyle())
        }
    }
}

struct SettingsView_Previews: PreviewProvider {
    static var previews: some View {
        SettingsView()
    }
}
