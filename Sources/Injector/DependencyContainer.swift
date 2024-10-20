import Foundation

/// A container for managing dependency injection by registering and resolving instances of various types.
///
/// `DependencyContainer` allows you to register factories that create instances of specific types
/// and then resolve them when needed. It supports different lifecycle scopes (`.singleton` and `.transient`)
/// and can manage multiple named registrations for the same type.
public final class DependencyContainer {
    
    /// A dictionary to store factory wrappers, where the key is a unique identifier for the type and name.
    private var factories = [String: FactoryWrapper]()
    
    /// Initializes a new, empty `DependencyContainer`.
    public init() {}

    /// Registers a factory to create an instance of a given type.
    ///
    /// Use this method to add a factory function that will be used to create instances of the specified type.
    /// The factory can be registered with a name, allowing for multiple factories for the same type under different names.
    /// The lifecycle scope determines whether the instance should be reused (`.singleton`) or created anew (`.transient`) each time.
    ///
    /// - Parameters:
    ///   - type: The type of the instance to register.
    ///   - name: An optional name to identify the registration. Default is `nil`.
    ///   - scope: The lifecycle scope for the instance (`.singleton` or `.transient`). Default is `.transient`.
    ///   - factory: A closure that produces an instance of the desired type.
    public func register<T>(_ type: T.Type, name: String? = nil, scope: Scope = .transient, factory: @escaping () -> T) {
        let key = generateKey(for: type, name: name)
        let factoryWrapper = FactoryWrapper(factory: factory, scope: scope)
        factories[key] = factoryWrapper
    }

    /// Resolves an instance of the specified type.
    ///
    /// Attempts to retrieve an instance of the registered type. If a name was used during registration,
    /// the same name should be used when resolving. If no matching registration is found, a runtime error occurs.
    ///
    /// - Parameters:
    ///   - type: The type of the instance to resolve.
    ///   - name: An optional name to identify the registration. Default is `nil`.
    /// - Returns: An instance of the specified type.
    /// - Warning: This method will cause a runtime crash if no registration is found for the requested type and name.
    public func resolve<T>(_ type: T.Type, name: String? = nil) -> T {
        let key = generateKey(for: type, name: name)
        guard let factoryWrapper = factories[key], let instance = factoryWrapper.getInstance() as? T else {
            fatalError("No registration found for type \(type)")
        }
        return instance
    }
    
    /// Generates a unique key for each type and name combination.
    ///
    /// This method creates a unique identifier string based on the type and an optional name.
    /// If a name is provided, the key will be a combination of the type name and the given name.
    ///
    /// - Parameters:
    ///   - type: The type for which the key is being generated.
    ///   - name: An optional name to differentiate multiple registrations of the same type.
    /// - Returns: A unique string key for the type and name combination.
    private func generateKey<T>(for type: T.Type, name: String?) -> String {
        let typeName = String(describing: type)
        return name.map { "\(typeName)_\($0)" } ?? typeName
    }
}
