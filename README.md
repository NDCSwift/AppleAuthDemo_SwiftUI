# 🚀 Getting Started

## 1. Clone the Repo

```bash
git clone https://github.com/NDCSwift/REPO-NAME.git
cd REPO-NAME
```

Or select “Clone Git Repository…” when Xcode launches.

⸻

## 2. Open in Xcode

    •	Double-click the .xcodeproj or .xcworkspace.

⸻

## 3. Set Your Development Team

In Xcode, navigate to:

TARGET → Signing & Capabilities → Team
• Select your personal or organizational team.

⸻

## 4. Update the Bundle Identifier

    •	Change com.example.MyApp to a unique identifier (e.g., com.yourname.MyApp).

⸻

🛠️ Notes

    •	If you see a code signing error, check that Team and Bundle ID are set.
    •	If building for a device, ensure your provisioning profile supports the required capabilities (Push, iCloud, etc.).

📺 YouTube
[Click here to check out the guide on YouTube](https://www.youtube.com/@NoahDoesCoding97)

# AppleAuthDemo_SwiftUI

A minimal SwiftUI sample that demonstrates “Sign in with Apple” using AuthenticationServices with a polished UI and inline documentation.

## Prerequisites

- Xcode 15 or later (project created/tested with recent Xcode versions)
- iOS 17+ target recommended
- An Apple Developer Program membership (paid) to enable Sign in with Apple and run on device

## Project Highlights

- SwiftUI UI with a gradient background and card-style layout
- Sign in with Apple via `SignInWithAppleButton`
- Inline comments explaining:
  - Requested scopes and first-time data behavior
  - Credential state checks and revocation handling
  - Where/why values are persisted (UserDefaults for demo)

## Getting Started

1. Open the project in Xcode.
2. Select the app target > Signing & Capabilities.
3. Add the capability: “Sign in with Apple”.
4. Ensure a valid Team is selected and automatic signing is enabled.
5. Build and run on a device or simulator (note that some flows require a real device signed into an Apple ID).

## How Sign in with Apple works in this demo

- The sign-in button configures the request with the following scopes:

```swift
request.requestedScopes = [.fullName, .email]
```
