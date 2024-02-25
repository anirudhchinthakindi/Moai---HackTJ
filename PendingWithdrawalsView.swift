import SwiftUI

struct PendingWithdrawalsView: View {
    @State private var showConfirmationMessage = false // State to control the confirmation message visibility

    var body: some View {
        VStack {
            ZStack {
                RoundedRectangle(cornerRadius: 12)
                    .fill(Color.white)
                    .frame(height: 200)
                    .shadow(radius: 5)

                VStack(spacing: 10) {
                    Text("Sarah")
                        .font(.headline)

                    Text("$100")
                        .font(.title)
                        .bold()

                    Text("Reason for Request: EMERGENCY, school fees due")
                        .font(.caption)
                }
                .padding()
            }
            .padding()

            HStack(spacing: 20) {
                Button(action: {
                    // Approve action
                    showConfirmationMessage = true
                }) {
                    Image(systemName: "checkmark.circle.fill")
                        .foregroundColor(.green)
                        .font(.largeTitle)
                }

                Button(action: {
                    // Deny action
                    // Implement deny logic or leave as is for demonstration
                }) {
                    Image(systemName: "xmark.circle.fill")
                        .foregroundColor(.red)
                        .font(.largeTitle)
                }
            }
            .padding()

            if showConfirmationMessage {
                Text("Waiting for 4 others to approve this withdrawal request")
                    .font(.headline)
                    .foregroundColor(.blue)
                    .padding()
            }

            Spacer()
        }
        .padding()
    }
}

struct PendingWithdrawalsView_Previews: PreviewProvider {
    static var previews: some View {
        PendingWithdrawalsView()
    }
}
