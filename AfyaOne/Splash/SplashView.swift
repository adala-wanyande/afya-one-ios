//
//  SplashView.swift
//  AfyaOne
//
//  Created by Adala Wanyande on 12/12/2024.
//

import SwiftUI
import FirebaseAuth

struct SplashView: View {
    @State private var isActive: Bool = false
    @State private var isLoggedIn: Bool?

    var body: some View {
        Group {
            if let isLoggedIn = isLoggedIn {
                if isLoggedIn {
                    ContentView() // Navigate to the main app content
                } else {
                    LoginView() // Navigate to the login screen if not logged in
                }
            } else {
                ZStack {
                    Color.white // Background color
                        .ignoresSafeArea()

                    VStack {
                        // Progress Indicator at the top
                        ProgressView()
                            .progressViewStyle(CircularProgressViewStyle(tint: .black))
                            .scaleEffect(1.5) // Scale the progress indicator
                            .padding(.bottom, 50) // Add spacing from the logo

                        Spacer() // Push the progress indicator to the top

                        VStack {
                            // App Logo
                            Image("app_logo") // Replace with your app logo asset
                                .resizable()
                                .scaledToFit()
                                .frame(width: 150, height: 150)

                            // App Name
                            Text("Afya One")
                                .font(.largeTitle)
                                .foregroundColor(.black)
                                .padding(.top, 20)
                        }

                        Spacer() // Center the content vertically
                    }
                    .frame(maxWidth: .infinity, maxHeight: .infinity)
                    .scaleEffect(isActive ? 1 : 0.9) // Animation effect
                    .animation(.easeInOut(duration: 1), value: isActive)
                }
                .onAppear {
                    // Show splash screen for 2 seconds, then check login status
                    DispatchQueue.main.asyncAfter(deadline: .now() + 2) {
                        withAnimation {
                            isActive = true
                            checkLoginStatus()
                        }
                    }
                }
            }
        }
    }

    private func checkLoginStatus() {
        // Check Firebase Authentication login status
        isLoggedIn = Auth.auth().currentUser != nil
    }
}

#Preview {
    SplashView()
}
