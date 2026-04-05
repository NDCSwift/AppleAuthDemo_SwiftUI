# 🍎 Sign in with Apple — SwiftUI Demo

A minimal SwiftUI sample that demonstrates "Sign in with Apple" using `AuthenticationServices` with a polished UI and inline documentation.

---

## 🤔 What this is

This project shows the complete Sign in with Apple flow in SwiftUI — from requesting scopes and handling the first-time credential response, to checking credential state on subsequent launches and handling revocation. Every decision is documented inline so you understand *why*, not just *what*.

## ✅ Why you'd use it

- **Full auth lifecycle covered** — first sign-in, returning user, credential state check, and revocation handling
- **Privacy-aware patterns** — explains why Apple only returns email/name on the *first* sign-in and what to do about it
- **SwiftUI-native** — uses `SignInWithAppleButton` with a gradient background and card-style layout, no UIKit bridging
- **`UserDefaults` demo persistence** — shows where and why to persist the user ID (and what to use in production instead)

## 📺 Watch on YouTube

[![Watch on YouTube](https://img.shields.io/badge/YouTube-Watch%20the%20Tutorial-red?style=for-the-badge&logo=youtube)](https://youtu.be/8nox8nPlq2U)

> This project was built for the [NoahDoesCoding YouTube channel](https://www.youtube.com/@NoahDoesCoding97). Subscribe for weekly SwiftUI tutorials.

---

## Prerequisites

- Xcode 15 or later
- iOS 17+ target recommended
- An Apple Developer Program membership to enable Sign in with Apple and run on device

## Project Highlights

- SwiftUI UI with a gradient background and card-style layout
- Sign in with Apple via `SignInWithAppleButton`
- Inline comments explaining:
  - Requested scopes and first-time data behavior
  - Credential state checks and revocation handling
  - Where/why values are persisted (UserDefaults for demo)

## 🚀 Getting Started

### 1. Clone the Repo
```bash
git clone https://github.com/NDCSwift/AppleAuthDemo_SwiftUI.git
cd AppleAuthDemo_SwiftUI
```
Or select "Clone Git Repository…" when Xcode launches.

### 2. Open in Xcode
- Double-click the `.xcodeproj` or `.xcworkspace`.

### 3. Add the Capability
Go to **Target → Signing & Capabilities** and add **Sign in with Apple**.

### 4. Set Your Development Team

In Xcode, navigate to: **TARGET → Signing & Capabilities → Team**
- Select your personal or organizational team.

### 5. Update the Bundle Identifier
- Change `com.example.MyApp` to a unique identifier.

### 6. Run
Some flows require a real device signed into an Apple ID. iOS 17+ recommended.

---

## 🛠️ Notes

- If you see a code signing error, check that Team and Bundle ID are set
- Requires an Apple Developer Program membership to enable Sign in with Apple on device
- Building for a device requires your provisioning profile to include the Sign in with Apple capability

## 📦 Requirements

- Xcode 15+
- iOS 17+

📺 [Watch the guide on YouTube](https://youtu.be/8nox8nPlq2U)
