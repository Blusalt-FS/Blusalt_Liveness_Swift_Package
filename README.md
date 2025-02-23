# Blusalt_Liveness_Swift_Package Library Integration Guide

## Overview
This guide will help you integrate the Blusalt Liveness library into your SwiftUI project using Swift Package Manager (SPM). Blusalt Liveness provides a collection of reusable SwiftUI components to enhance your iOS application's user interface.

## Requirements
- Xcode 14.0 or later
- iOS 14.0+ / macOS 12.0+
- Swift 5+

## Installation

### Using Xcode
1. Open your project in Xcode
2. Click on `File` → `Add Packages...`
3. In the search field of the Swift Package Manager window, paste the repository URL:
   ```
   https://github.com/Blusalt-FS/Blusalt_Liveness_Swift_Package
   ```
4. Select the version rule:
   - Exact Version: Choose a specific version
   - Up to Next Major Version: Automatically update to minor versions
   - Up to Next Minor Version: Automatically update to patch versions
5. Click `Add Package`
6. Select the target where you want to add the package
7. Click `Add Package` to finalize the installation

### Using Package.swift
If you're developing a Swift package, add the dependency to your `Package.swift` file:

```swift
dependencies: [
    .package(url: "https://github.com/Blusalt-FS/Blusalt_Liveness_Swift_Package.git", from: "0.1.0")
]
```

Then add the dependency to your target:

```swift
targets: [
    .target(
        name: "YourTarget",
        dependencies: ["Blusalt_Liveness_Swift_Package"]
    )
]
```

## Usage

1. Import the package in your SwiftUI view:
```swift
import Blusalt_Liveness_Swift_Package
```

2. Start using the components:
```swift
struct ContentView: View {
    var body: some View {
        CustomButton(title: "Press Me") {
            print("Button pressed!")
        }
    }
}
```

## Troubleshooting

### Common Issues

1. **Package Loading Failed**
   - Verify your internet connection
   - Check if the repository URL is correct
   - Ensure you have access to the repository
   - Try File → Packages → Reset Package Caches

2. **Version Compatibility**
   - Verify the package supports your deployment target
   - Check the package's minimum required Xcode version

3. **Build Errors**
   - Clean the build folder (Shift + Command + K)
   - Clean the build cache and restart Xcode
   - Update to the latest package version

### Still Having Issues?
- Check our [Issues](https://github.com/Blusalt-FS/Blusalt_Liveness_Swift_Package/issues) page
- Create a new issue with detailed reproduction steps
- Contact support at support@blusalt.net

## Contributing
We welcome contributions! Please see our [Contributing Guidelines](CONTRIBUTING.md) for details.

## License
This project is licensed under the MIT License - see the [LICENSE](LICENSE) file for details.
