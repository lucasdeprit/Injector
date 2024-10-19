# Injector

![Swift](https://img.shields.io/badge/Swift-5.7%2B-orange.svg)
![Platform](https://img.shields.io/badge/Platform-iOS%20|%20macOS%20|%20tvOS%20|%20watchOS-blue.svg)
![License](https://img.shields.io/badge/License-MIT-lightgrey.svg)

**Injector** is a lightweight and easy-to-use dependency injection framework for Swift. Designed to simplify dependency management by supporting both singleton and transient scopes, it enables better modularization of your Swift projects.

## Features

- 📦 **Simple Registration & Resolution**: Easily register and resolve dependencies across your app.
- 🔄 **Singleton & Transient Scopes**: Control the lifecycle of your dependencies.
- 🏷 **Named Registrations**: Support for multiple instances of the same type with different identifiers.
- 🧩 **Modular Design**: Perfect for modular Swift projects using Swift Package Manager (SPM).

## Installation

### Swift Package Manager

Add the following line to your `Package.swift`:

```swift
dependencies: [
    .package(url: "https://github.com/yourusername/Injector.git", from: "1.0.0")
]
