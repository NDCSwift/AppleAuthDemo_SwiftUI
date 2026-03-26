//
        //
    //  Project: AppleAuthDemo_SwiftUI
    //  File: ContentView.swift
    //  Created by Noah Carpenter 
    //
    //  📺 YouTube: Noah Does Coding
    //  https://www.youtube.com/@NoahDoesCoding97
    //  Like and Subscribe for coding tutorials and fun! 💻✨
    //  Dream Big. Code Bigger 🚀
    //

    
// NOTE YOU NEED PAID APPLE MEMBERSHIP //

import SwiftUI
import AuthenticationServices

struct ContentView: View {
    // UI state: track sign-in status and a displayable user name.
    @State private var isSignedIn = false
    @State private var userName = ""
    
    var body: some View {
        ZStack {
            // Background: subtle system gradient for a polished look.
            LinearGradient(
                gradient: Gradient(colors: [Color(.systemBackground), Color(.secondarySystemBackground)]),
                startPoint: .topLeading,
                endPoint: .bottomTrailing
            )
            .ignoresSafeArea()

            // Main content switches between signed-in and sign-in states.
            Group {
                if isSignedIn {
                    VStack(spacing: 24) {
                        // Signed-in header with avatar and greeting.
                        HStack(spacing: 12) {
                            Image(systemName: "person.crop.circle.fill")
                                .font(.system(size: 44))
                                .foregroundStyle(.tint)
                            VStack(alignment: .leading, spacing: 4) {
                                Text("Welcome, \(userName.isEmpty ? "User" : userName)")
                                    .font(.largeTitle.bold())
                                Text("Signed in with Apple")
                                    .font(.subheadline)
                                    .foregroundStyle(.secondary)
                            }
                            Spacer(minLength: 0)
                        }

                        // Informational card letting the user know setup is complete.
                        VStack(alignment: .leading, spacing: 16) {
                            HStack {
                                Image(systemName: "checkmark.seal.fill")
                                    .foregroundStyle(.green)
                                Text("You're all set!")
                                    .font(.headline)
                            }
                            Text("You can now enjoy a personalized experience across the app.")
                                .foregroundStyle(.secondary)
                        }
                        .padding(20)
                        .background(
                            RoundedRectangle(cornerRadius: 16, style: .continuous)
                                .fill(.background)
                                .shadow(color: .black.opacity(0.08), radius: 12, x: 0, y: 6)
                        )

                        // Primary sign-out action.
                        Button {
                            signOut()
                        } label: {
                            Label("Sign Out", systemImage: "rectangle.portrait.and.arrow.right")
                                .font(.headline)
                                .frame(maxWidth: .infinity)
                        }
                        .buttonStyle(.borderedProminent)
                        .tint(.red)
                    }
                    .padding(24) // Comfortable outer padding
                    .frame(maxWidth: 600) // Keep content readable on large screens
                } else {
                    VStack(spacing: 28) {
                        // Branding and messaging for sign-in.
                        VStack(spacing: 12) {
                            Image(systemName: "applelogo")
                                .font(.system(size: 48, weight: .semibold))
                                .foregroundStyle(.primary)
                            Text("Sign in to continue")
                                .font(.title2.bold())
                            Text("Use your Apple ID to securely sign in and sync your experience.")
                                .font(.subheadline)
                                .foregroundStyle(.secondary)
                                .multilineTextAlignment(.center)
                        }

                        // Apple Sign In button inside a card.
                        VStack(spacing: 16) {
                            // Configure the Apple Sign In request.
                            // We ask for the user's full name and email on the first successful sign-in.
                            // Note: Apple only provides `.fullName` and `.email` on the initial authorization for a given user.
                            // Persist what you need because you may not receive them again on subsequent sign-ins.
                            SignInWithAppleButton(.signIn) { request in
                                request.requestedScopes = [.fullName, .email] // Request user's name and email (first sign-in only)
                            } onCompletion: { result in
                                // Handle the authorization result (success or failure).
                                switch result {
                                case .success(let authorization):
                                    handleAuthorization(authorization)
                                case .failure(let error):
                                    print("Sign in failed \(error.localizedDescription)")
                                }
                            }
                            .signInWithAppleButtonStyle(.whiteOutline)
                            .frame(height: 50)

                            Text("We’ll never share your personal information without your consent.")
                                .font(.footnote)
                                .foregroundStyle(.secondary)
                                .multilineTextAlignment(.center)
                        }
                        .padding(20)
                        .background(
                            RoundedRectangle(cornerRadius: 16, style: .continuous)
                                .fill(.background)
                                .shadow(color: .black.opacity(0.08), radius: 12, x: 0, y: 6)
                        )
                    }
                    .padding(24) // Comfortable outer padding
                    .frame(maxWidth: 500) // Keep content readable on large screens
                }
            }
        }
        // On appear, verify the stored credential state with Apple.
        .task {
            checkCredentialStatus()
        }
        .onReceive(NotificationCenter.default.publisher(for: ASAuthorizationAppleIDProvider.credentialRevokedNotification)) { _ in
            // If the Apple ID credential is revoked, clear local state and sign out.
            print("Credential Revoked")
            UserDefaults.standard.removeObject(forKey: "appleUserID")
            signOut()
        }
    }
    
    private func handleAuthorization(_ authorization: ASAuthorization){
        
        // Ensure we received an Apple ID credential.
        guard let credential = authorization.credential as? ASAuthorizationAppleIDCredential else {
            print("Invalid Credential type")
            return
        }
        
        // Stable Apple user identifier for your app (store for future checks).
        let userID = credential.user
        UserDefaults.standard.set(userID, forKey: "appleUserID")
        print("UserID: \(userID)")
        
        // Optional: Identity token (JWT) useful for server-side validation.
        if let tokenData = credential.identityToken,
           let token = String(data: tokenData, encoding: .utf8) {
            print("Identity Token \(token)")
        }
        
        // Optional: Authorization code for server exchanges.
        if let codeData = credential.authorizationCode,
           let code = String(data: codeData, encoding: .utf8) {
            print("Authorization Code \(code)")
        }
        
        // Name is only guaranteed on the first authorization—store if present.
        if let fullName = credential.fullName {
            let givenName = fullName.givenName ?? ""
            let familyName = fullName.familyName ?? ""
            print("Name\(givenName) \(familyName)")
            
            let name = [fullName.givenName, fullName.familyName]
                .compactMap { $0 }
                .joined(separator: " ")
            if !name.isEmpty {
                UserDefaults.standard.set(name, forKey: "appleUserName")
            }
            
            //SAVE THIS
        }
        
        // Email may also only be provided once—persist if needed.
        if let email = credential.email {
            print("Email \(email)")
            UserDefaults.standard.set(email, forKey: "appleUserEmail")
        }
        
        UserDefaults.standard.set(userID, forKey: "appleUserID")
        
        // Update local UI state after persisting values.
        userName = UserDefaults.standard.string(forKey: "appleUserName") ?? "User"
        isSignedIn = true
        
    }
    
    private func checkCredentialStatus(){
        
        // If we have a stored Apple user ID, ask Apple for its current credential state.
        guard let userID = UserDefaults.standard.string(forKey: "appleUserID") else { return }
        
        let provider = ASAuthorizationAppleIDProvider()
        // Check credential state asynchronously and update UI on the main queue.
        provider.getCredentialState(forUserID: userID) { state, error in
        
            DispatchQueue.main.async {
                switch state {
                case .authorized:   // Still authorized; keep user signed in.
                    print("User is authorized")
                    userName = UserDefaults.standard.string(forKey: "appleUserName") ?? "User"
                    isSignedIn = true
                case .revoked:     // Access revoked; remove ID and sign out.
                    print("User revoked Access")
                    UserDefaults.standard.removeObject(forKey: "appleUserID")
                    signOut()
                case .notFound:    // No record found; sign out.
                    print("User has never logged in with Apple on this device.")
                    signOut()
                case .transferred: // Credential transferred to another Apple ID.
                    print("Credential transfered")
                    signOut()
                @unknown default:
                    signOut()
                    break
                }
            }
            
            
        }
    }
    
    private func signOut(){
        // Clear persisted identifiers and reset UI state.
        UserDefaults.standard.removeObject(forKey: "appleUserID")
        isSignedIn = false
        userName = ""
    }
}

#Preview {
    ContentView()
}

