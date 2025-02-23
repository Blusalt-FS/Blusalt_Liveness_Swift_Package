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
    .package(url: "https://github.com/Blusalt-FS/Blusalt_Liveness_Swift_Package.git", from: "0.2.0")
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
import BlusaltLivenessOnly
import SwiftUI
```

2. Start using the components:
```swift

struct ContentView: View {
   
    var clientId: String = ""
    var appName: String = ""
    var apiKey: String = ""
    var isDev: Bool = false

  @EnvironmentObject var theme: Theme
  @Environment(\.presentationMode) var presentationMode

  @State private var showImagePicker = false
  @State private var startSDK = false

  @State private var livenessResult: Data? = nil

  @State private var imageFile: Data? = nil

  var body: some View {

    GeometryReader { geometry in
      ZStack {
        Color(
          hex: 0xFFF5_F5F5
        ).edgesIgnoringSafeArea(.all)

        ScrollView {
          VStack(alignment: .center) {

            Spacer().frame(height: 32)

            Group {
              Text("Liveness Check Demo App")
                .font(.system(size: 20, weight: .bold)).multilineTextAlignment(.center)
                .foregroundColor(Color(hex: 0xFF07_1B2B))

              Spacer().frame(height: 13.heightPercentage)
            }
              
            Group {
              if let livenessResult = livenessResult, let uiImage = UIImage(data: livenessResult) {
                Image(uiImage: uiImage)
                  .resizable()
                  .scaledToFit()
                  .frame(maxWidth: .infinity)
                  .layoutPriority(1)

              } else {
                Text(
                  "Your processed image will display here.\n You are required to pick an image containing your face so it can do comparison"
                )
                .multilineTextAlignment(.center)
                .foregroundColor(Color(hex: 0xFFAA_AAAA)).onTapGesture {

                  if let windowScene = UIApplication.shared.connectedScenes.first
                    as? UIWindowScene,
                    let viewController = windowScene.windows.first?.rootViewController
                  {
                    LivenessOnlyManager.shared
                      .startFaceDetectionOnlySDK(
                        viewController, clientId: clientId, appName: appName, apiKey: apiKey,
                        isDev: isDev, livenessDetectionOnlyType: .MOTIONAL,
                        onComplete: { jsonRawValue, livenessSuccess in
                          if let base64 = livenessSuccess.faceDetectionData?.livenessImage {
                            livenessResult = Data(base64Encoded: base64)
                          }
                          print(
                            "startLivenessDetectionOnlySDK Demo app is called and is successful")

                          print(
                            "\(String(describing: livenessSuccess.isProcedureValidationPassed))")

                        },
                        onFailure: {
                          statusCode, errorText in

                          print(
                            "startFacialComparisonSDK Demo app is called and is failed: \(statusCode) \(errorText)"
                          )

                        })
                  }
                }
              }

              Spacer().frame(height: 10.heightPercentage)

              CustomButton(
                title: livenessResult == nil ? "Try out" : "Try again",
                width: 200,
                onTap: {
                  showImagePicker.toggle()
                }

              ).ignoresSafeArea(.all).sheet(isPresented: $startSDK) {
              }
              .ignoresSafeArea(.all).sheet(isPresented: $showImagePicker) {

                CustomImagePicker {
                  url in
                  if url != nil {

                    // Pick image from gallery and pass to SDK
                    let data: Data? = try? Data(contentsOf: url!)
                    if let data = data {

                      //                      print("image picked")
                      //                      print(clientId)
                      imageFile = data

                      if let windowScene = UIApplication.shared.connectedScenes.first
                        as? UIWindowScene,
                        let viewController = windowScene.windows.first?.rootViewController
                      {

                        let livenessOnlyManager = LivenessOnlyManager.shared
                        livenessOnlyManager.startFacialComparisonSDK(
                          viewController, clientId: clientId, appName: appName, apiKey: apiKey,
                          isDev: isDev, fileByteData: data, livenessFacialComparisonType: .MOTIONAL,
                          onComplete: { jsonRawValue, livenessSuccess in

                            if let base64 = livenessSuccess.faceDetectionData?.livenessImage {
                              livenessResult = Data(base64Encoded: base64)
                            }

                            print("startFacialComparisonSDK Demo app is called and is successful")
                            print(
                              "\(String(describing: livenessSuccess.isProcedureValidationPassed))")

                          },
                          onFailure: { statusCode, errorText in

                            print(
                              "startFacialComparisonSDK Demo app is called and is failed: \(statusCode) \(errorText)"
                            )

                          })
                      }

                    }
                  }
                }
              }

              Group {
                Spacer().frame(height: 13.heightPercentage)
                BlusaltLogo()
                Spacer().frame(height: 5.heightPercentage)
              }.layoutPriority(1)
            }.frame(width: .infinity, height: .infinity)  // VStack
          }.padding(EdgeInsets(top: 0, leading: 16, bottom: 0, trailing: 16))  // ScrollView
            .frame(maxWidth: .infinity, maxHeight: .infinity)
            .scrollIndicators(ScrollIndicatorVisibility.hidden)
        }  // ZStack
      }  // GeometryReader
    }  // NavigationView

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
