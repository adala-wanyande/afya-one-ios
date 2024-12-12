//
//  LoginView.swift
//  AfyaOne
//
//  Created by Adala Wanyande on 12/12/2024.
//

import SwiftUI
import FirebaseAuth

struct LoginView: View {
    @State private var email: String = ""
    @State private var password: String = ""
    @State private var isPasswordVisible: Bool = false // For toggling password visibility
    @State private var errorMessage: String = ""
    @State private var isLoggedIn: Bool = false
    @State private var isLoading: Bool = false // For showing the loading spinner

    var body: some View {
        if isLoggedIn {
            ContentView() // Navigate to the main app content if logged in
        } else {
            VStack(spacing: 20) {
                Text("Log in")
                    .font(.largeTitle)
                    .fontWeight(.bold)
                
                // Email Field
                TextField("Email", text: $email)
                    .keyboardType(.emailAddress)
                    .textInputAutocapitalization(.never)
                    .disableAutocorrection(true) // Disable autocorrection
                    .padding()
                    .background(Color(.systemGray6))
                    .cornerRadius(8)
                    .overlay(RoundedRectangle(cornerRadius: 8).stroke(Color.gray, lineWidth: 0.5))

                // Password Field with Eye Icon
                ZStack {
                    if isPasswordVisible {
                        TextField("Password", text: $password)
                            .padding()
                            .background(Color(.systemGray6))
                            .cornerRadius(8)
                            .overlay(RoundedRectangle(cornerRadius: 8).stroke(Color.gray, lineWidth: 0.5))
                    } else {
                        SecureField("Password", text: $password)
                            .padding()
                            .background(Color(.systemGray6))
                            .cornerRadius(8)
                            .overlay(RoundedRectangle(cornerRadius: 8).stroke(Color.gray, lineWidth: 0.5))
                    }
                    
                    HStack {
                        Spacer()
                        Button(action: {
                            isPasswordVisible.toggle()
                        }) {
                            Image(systemName: isPasswordVisible ? "eye.slash.fill" : "eye.fill")
                                .foregroundColor(.gray)
                                .padding(.trailing, 10)
                        }
                    }
                }

                // Error Message with Reserved Space
                Text(errorMessage)
                    .foregroundColor(.red)
                    .font(.footnote)
                    .frame(height: 20) // Reserve space for the error message
                    .opacity(errorMessage.isEmpty ? 0 : 1) // Fade-in animation
                    .animation(.easeInOut(duration: 0.3), value: errorMessage)

                // Login Button with Spinner
                Button(action: login) {
                    HStack {
                        if isLoading {
                            ProgressView()
                                .progressViewStyle(CircularProgressViewStyle(tint: .white))
                                .scaleEffect(1.0)
                        } else {
                            Text("Login")
                        }
                    }
                    .frame(maxWidth: .infinity)
                    .padding()
                    .background(email.isEmpty || password.isEmpty ? Color.gray : Color.blue)
                    .foregroundColor(.white)
                    .cornerRadius(8)
                }
                .disabled(email.isEmpty || password.isEmpty || isLoading)

                // Forgot Password
                Button(action: resetPassword) {
                    Text("Forgot Password?")
                        .font(.footnote)
                        .foregroundColor(.blue)
                }

                Spacer()
            }
            .padding()
            .onAppear {
                checkLoginStatus()
            }
        }
    }

    // Check if user is already logged in
    private func checkLoginStatus() {
        if Auth.auth().currentUser != nil {
            isLoggedIn = true
        }
    }

    // Login Functionality
    private func login() {
        isLoading = true
        Auth.auth().signIn(withEmail: email, password: password) { result, error in
            isLoading = false
            if let error = error {
                errorMessage = error.localizedDescription
            } else {
                isLoggedIn = true
            }
        }
    }

    // Reset Password Functionality
    private func resetPassword() {
        guard !email.isEmpty else {
            errorMessage = "Please enter your email address."
            return
        }

        Auth.auth().sendPasswordReset(withEmail: email) { error in
            if let error = error {
                errorMessage = error.localizedDescription
            } else {
                errorMessage = "Password reset email sent!"
            }
        }
    }
}

#Preview {
    LoginView()
}
