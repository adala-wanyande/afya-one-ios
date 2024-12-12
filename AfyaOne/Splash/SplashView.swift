//
//  SplashView.swift
//  AfyaOne
//
//  Created by Adala Wanyande on 12/12/2024.
//

import SwiftUI

struct SplashView: View {
    @State private var isActive: Bool = false

    var body: some View {
        if isActive {
            // Navigate to the main content after the splash screen
            ContentView() // Replace `ContentView` with your main app view
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
//                            .fontWeight(.bold)~
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
                // Delay for 2 seconds, then move to the main content
                DispatchQueue.main.asyncAfter(deadline: .now() + 2) {
                    withAnimation {
                        isActive = true
                    }
                }
            }
        }
    }
}

#Preview {
    SplashView()
}
