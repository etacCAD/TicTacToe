# Tic Tac Toe — iOS App

A polished Tic Tac Toe game built with **Swift + SwiftUI**, ready for the Apple App Store.

## Features

- 🎮 **Two game modes**: vs AI (smart opponent) and vs Friend (local 2-player)
- 🏆 **Score tracking**: X wins, O wins, and draws
- ✨ **Premium dark UI**: Glassmorphism, gradient accents, smooth animations
- 📱 **Universal**: Works on all iPhones and iPads
- 🤖 **Smart AI**: Prioritizes winning, blocking, center, corners

---

## Getting Started

### Prerequisites

- **macOS** with **Xcode 15+** installed
- An **Apple ID** (free for simulator testing)
- An **Apple Developer Program** membership ($99/year, required for App Store only)

### Open & Run

1. Open `TicTacToe.xcodeproj` in Xcode
2. Select an iPhone simulator (e.g., iPhone 16)
3. Press **⌘R** to build and run

> **Note**: If you see a signing error, go to the TicTacToe target → **Signing & Capabilities** → select your **Team** from the dropdown.

---

## App Store Deployment Guide

This guide walks you through every step to publish your app on the App Store.

### Step 1: Apple Developer Account

1. Go to [developer.apple.com/programs](https://developer.apple.com/programs/)
2. Click **Enroll** and sign in with your Apple ID
3. Pay the $99/year fee
4. Wait for approval (usually 24-48 hours)

### Step 2: Configure Signing in Xcode

1. Open the project in Xcode
2. Select the **TicTacToe** target in the project navigator
3. Go to **Signing & Capabilities**
4. Check **Automatically manage signing**
5. Select your **Team** (your Developer account)
6. Change the **Bundle Identifier** to something unique:
   ```
   com.yourname.tictactoe
   ```
   > The bundle ID must be globally unique across all apps on the App Store.

### Step 3: Create an App Icon

You need a **1024×1024 px** PNG image for your app icon.

1. Create or download a 1024×1024 icon image
2. In Xcode, open **Assets.xcassets** → **AppIcon**
3. Drag your image into the **iOS App 1024pt** slot
4. Xcode will auto-generate all required sizes

> **Tip**: Use tools like [Figma](https://figma.com), [Canva](https://canva.com), or [SF Symbols](https://developer.apple.com/sf-symbols/) for icon design.

### Step 4: Set Up App Store Connect

1. Go to [appstoreconnect.apple.com](https://appstoreconnect.apple.com)
2. Click **My Apps** → **+** → **New App**
3. Fill in:
   - **Platform**: iOS
   - **Name**: Tic Tac Toe (or your preferred name)
   - **Primary Language**: English
   - **Bundle ID**: Select the one matching your Xcode project
   - **SKU**: `tictactoe-1` (any unique string)
4. Click **Create**

### Step 5: Prepare App Store Listing

In your app's page on App Store Connect, fill in:

| Field | Value |
|-------|-------|
| **Subtitle** | Classic game, reimagined |
| **Category** | Games → Board |
| **Age Rating** | 4+ (no objectionable content) |
| **Price** | Free |
| **Privacy Policy URL** | See Step 6 below |
| **Description** | A beautifully designed Tic Tac Toe game. Play against a smart AI or challenge a friend. Features elegant animations, score tracking, and a premium dark interface. |
| **Keywords** | tic tac toe, board game, puzzle, strategy, two player |
| **Support URL** | Your website or GitHub page |

### Step 6: Privacy Policy

Apple requires a privacy policy URL for **all** apps. Since this app collects **no user data**, you can create a simple one:

**Option A**: Host a simple page on GitHub Pages, your website, or Notion with:

```
Privacy Policy for Tic Tac Toe

Last updated: [date]

This app does not collect, store, or share any personal data.
The app works entirely offline and does not connect to any servers.
No analytics, tracking, or advertising SDKs are used.

Contact: [your email]
```

**Option B**: Use a free generator like [privacypolicytemplate.net](https://privacypolicytemplate.net)

### Step 7: Screenshots

App Store Connect requires screenshots for specific device sizes:

| Device | Size (pixels) | Required? |
|--------|---------------|-----------|
| iPhone 6.7" (iPhone 16 Pro Max) | 1290 × 2796 | ✅ Yes |
| iPhone 6.1" (iPhone 16) | 1179 × 2556 | Recommended |
| iPad Pro 12.9" | 2048 × 2732 | If supporting iPad |

**How to capture screenshots from Simulator**:
1. Run your app in the Simulator with the right device
2. Press **⌘S** in the Simulator to save a screenshot
3. Screenshots save to your Desktop
4. Upload them to App Store Connect

> **Tip**: Capture screenshots of the game board, a winning state, and the mode selection for variety. Aim for 3-5 screenshots.

### Step 8: Archive & Upload

1. In Xcode, set the device to **Any iOS Device (arm64)**
2. Go to **Product** → **Archive**
3. Wait for the archive to build
4. The **Organizer** window will open
5. Select your archive → click **Distribute App**
6. Choose **App Store Connect** → **Upload**
7. Follow the prompts (accept defaults)
8. Wait for the upload to complete (2-5 minutes)

### Step 9: Submit for Review

1. Go back to [App Store Connect](https://appstoreconnect.apple.com)
2. Select your app → go to the **App Store** tab
3. Under **Build**, click **+** and select your uploaded build
4. Fill in any remaining required fields
5. Click **Submit for Review**

### Step 10: Wait for Review

- **Typical review time**: 24-48 hours (can be faster)
- You'll receive an email when it's approved (or if changes are needed)
- Once approved, it goes live on the App Store! 🎉

---

## Common Rejection Reasons & How to Avoid Them

| Reason | Prevention |
|--------|-----------|
| Missing privacy policy | Always include one (Step 6) |
| App crashes on launch | Test thoroughly on real devices |
| Placeholder content | Remove all "Lorem ipsum" or test data |
| Insufficient functionality | Our game has enough features ✅ |
| Missing screenshots | Provide all required sizes (Step 7) |
| Broken links | Verify support URL and privacy policy URL work |

---

## Project Structure

```
TicTacToe/
├── TicTacToe.xcodeproj/     # Xcode project file
├── TicTacToe/
│   ├── TicTacToeApp.swift    # App entry point
│   ├── ContentView.swift     # Main game screen
│   ├── GameViewModel.swift   # Game logic & AI
│   ├── Models.swift          # Data models
│   ├── BoardView.swift       # 3×3 grid component
│   ├── CellView.swift        # Individual cell view
│   ├── ScoreView.swift       # Score display
│   └── Assets.xcassets/      # App icon & colors
└── README.md                 # This file
```

## Customization Ideas

Once you've published v1, here are ideas for updates:

- 🎵 Add sound effects (tap, win, draw)
- 🏅 Game Center leaderboards
- 🎨 Multiple themes / color schemes
- 📊 Statistics tracking with charts
- 🧠 Harder AI using minimax algorithm
- 🌐 Online multiplayer via GameKit
