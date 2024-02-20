# ThePugApp
The Pug App Swift - iOS Application to handle The Pug challenge using Xcode and Swift

- [Architecture](#Architecture)
- [Frameworks](#Frameworks)
- [Installation](#Installation)
- [Structure](#Structure)

## Architecture

The app is using MVVM architecture, the main goal is to mantain everything under a simple but effective MVVM implementation.

- ### Modules
    Each Module has `ViewModel`, `Models`, `Views` to handle the base Architecture design.

- ### ViewModels
    `ViewModel` is the main component of this architecture pattern. `ViewModel` never knows what the view is or what the view does. This makes this architecture more testable and removes complexity from the view. 
    The `ViewModel` invokes changes in the `Model` and updates itself with the updated `Model`, and since we have a binding between the View and the `ViewModel`, the first is updated accordingly.

- ### Models
    `Model` refers either to a domain model, which represents simple data.

- ### Network Layer
    `Network layer` is a set of Services Protocols to handle the API calls to the Endpoints using an Adapter and Protocol Oriented programming.

Please consider this article if it is your first time using MVVM:
https://medium.com/@azamsharp/mvvm-in-ios-from-net-perspective-580eb7f4f129

## Frameworks

The app is using some external frameworks dependencies using Cocoapods:

- ### Alamofire 
    - A network layer to handle REST API requests for HTTP request, used to implement the Service Network API calls.

- ### SDWebImage
    - A framework to handle image URL downloads easy and quick to download and display the Pug Images

- ### SwiftLint
    - A framework to handle best practices lint rules for Swift used as a best practice

## Installation

This project use Xcode 12.4 and CocoaPods for dependencies, 

1. **Clone Repo**:             
`git clone git@github.com:devcarlos/ThePugApp.git`

2. **CD Directory**:           
`cd ThePugApp`

3. **Install dependencies**:   
`pod install`

4. **Open Project**:           
`open ThePugApp.xcworkspace`

5. **Build and Execute**:      
`build using Xcode CMD + R using a Simulator or Device`

## Structure
In the root of the project we found this folder structure and files:
```
|-- ThePugApp
  |-- App
  |-- Assets
  |-- Common
  |-- Extensions
  |-- Network
  |-- Modules
    |-- Home
        |-- Views
          |-- Cells
          |-- Storyboards
          |-- Controllers
        |-- Models
        |-- ViewModel
  |-- Storyboards
  |-- SupportFiles
    |-- Info.plist
|-- Podfile
|-- Podfile.lock
|-- LICENSE
|-- README.md
|-- RESULTS.json
|-- .gitignore

```
Where all app code is hosted in `ThePugApp` folder, all the Info.plist settings files for xcode project are hosted in `SupportFiles`. For each module of the app we use the folder structure show it in `Modules` folder.
