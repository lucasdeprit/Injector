import Foundation

/// A property wrapper that automatically injects a dependency from the global `AppContainer`.
///
/// `Inject` simplifies the process of dependency injection by resolving an instance of the specified type
/// from the global `AppContainer`. This allows for a clean and easy way to inject dependencies into your classes
/// without manually resolving them.
///
/// By default, the wrapper uses the type alone to resolve the dependency, but you can also provide a specific
/// name if multiple instances of the same type are registered under different names.
///
/// - Usage:
///   ```swift
///   @Inject var myService: MyService
///   ```
@propertyWrapper
public struct Inject<T> {
    
    /// The resolved instance of the dependency.
    private var instance: T

    /// Initializes the `Inject` property wrapper, automatically resolving the dependency from the global `AppContainer`.
    ///
    /// - Parameter name: An optional name to identify a specific registration of the type. Default is `nil`.
    /// - Warning: This will cause a runtime crash if no matching registration is found in `AppContainer`.
    public init(name: String? = nil) {
        self.instance = AppContainer.resolve(T.self, name: name)
    }

    /// The wrapped value that represents the injected dependency.
    ///
    /// Accessing this property will return the resolved instance from `AppContainer`.
    public var wrappedValue: T {
        return instance
    }
}

/// A global container that holds all registered dependencies for the application.
///
/// `AppContainer` serves as a shared instance of `DependencyContainer`, allowing for centralized
/// registration and resolution of dependencies across the entire app.
///
/// - Usage:
///   ```swift
///   AppContainer.register(MyService.self) { MyServiceImplementation() }
///   let service = AppContainer.resolve(MyService.self)
///   ```
public let AppContainer = DependencyContainer()
