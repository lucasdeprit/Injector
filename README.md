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
```

---

# Dependency Injection Framework

This is a Swift-based dependency injection framework that allows you to easily manage dependencies in your project by registering and resolving instances. It supports both singleton and transient scopes, as well as named dependencies, making it flexible and easy to use.

## Installation

You can add this package to your project using Xcode:

1. Go to **File > Add Packages**.
2. Paste the repository URL and select the appropriate version.

## Usage

### 1. Register a Dependency

You can register dependencies using singleton or transient scopes. Singleton instances are created once and reused, while transient instances are created each time they are resolved.

#### Registering a Singleton

```swift
AppContainer.register(Service.self, scope: .singleton) {
    MyService()
}
```

In this example, `MyService` will be instantiated only once, and the same instance will be returned every time `Service` is resolved.

#### Registering a Transient

```swift
AppContainer.register(Service.self, scope: .transient) {
    AnotherService()
}
```

Here, `AnotherService` will be instantiated each time `Service` is resolved, ensuring a fresh instance for every call.

### 2. Resolve a Dependency

Resolving dependencies is as simple as calling the `resolve` method on the `AppContainer`.

```swift
let service: Service = AppContainer.resolve(Service.self)
```

This retrieves the registered instance of `Service`, depending on how it was set up (singleton or transient).

### 3. Using `@Inject` Property Wrapper

To make dependency injection even more seamless, you can use the `@Inject` property wrapper:

```swift
class MyViewController {
    @Inject var service: Service

    func loadData() {
        let data = service.getData()
        // Use data
    }
}
```

In this case, `@Inject` automatically resolves `Service` from the `AppContainer`, reducing boilerplate code.

### 4. Named Dependencies

You can register multiple implementations of the same protocol using names:

```swift
AppContainer.register(Service.self, name: "premiumService") {
    PremiumService()
}

let premiumService: Service = AppContainer.resolve(Service.self, name: "premiumService")
```

This allows you to resolve different instances of the same type, which is useful if you have multiple configurations or variants.

## Example

Here's a complete example to illustrate the setup and usage:

```swift
// Define a protocol
protocol Service {
    func getData() -> String
}

// Implement the protocol
class MockService: Service {
    func getData() -> String {
        return "Mocked Data"
    }
}

// Register the service
AppContainer.register(Service.self, scope: .singleton) {
    MockService()
}

// Use @Inject to access the service
class MyFeature {
    @Inject var service: Service

    func printData() {
        print(service.getData()) // Output: Mocked Data
    }
}

// Example usage
let feature = MyFeature()
feature.printData()
```

## License

This project is licensed under the MIT License - see the [LICENSE](LICENSE) file for details.

--- 

Feel free to modify or expand on this as needed!
