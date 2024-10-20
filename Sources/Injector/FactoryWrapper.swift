import Foundation

/// Enum that defines the lifecycle of the instances.
///
/// - singleton: The same instance is reused every time.
/// - transient: A new instance is created every time.
public enum Scope {
    case singleton
    case transient
}

/// A wrapper class that manages the creation of instances based on the defined factory function and scope.
///
/// `FactoryWrapper` is used to encapsulate the logic of creating and managing instances according to a specific
/// lifecycle (`Scope`). Depending on whether the scope is `.singleton` or `.transient`, it will either reuse an existing
/// instance or create a new one each time.
///
/// - Author: lucasdeprit
final class FactoryWrapper {
    
    /// The factory function that creates an instance of a specific type.
    private let factory: () -> Any
    
    /// The scope that determines the lifecycle of the instance.
    private let scope: Scope
    
    /// Holds the singleton instance if the scope is `.singleton`.
    private var instance: Any?

    /// Initializes a new `FactoryWrapper` with a factory function and a specified scope.
    ///
    /// - Parameters:
    ///   - factory: A closure that produces an instance of the desired type.
    ///   - scope: The lifecycle scope for the instance (`.singleton` or `.transient`).
    init(factory: @escaping () -> Any, scope: Scope) {
        self.factory = factory
        self.scope = scope
    }

    /// Retrieves an instance based on the defined scope.
    ///
    /// - Returns: An instance created by the factory function. If the scope is `.singleton`,
    ///            it returns the same instance each time. If the scope is `.transient`, it creates
    ///            a new instance each time this method is called.
    func getInstance() -> Any {
        switch scope {
        case .singleton:
            if instance == nil {
                instance = factory()
            }
            return instance!
        case .transient:
            return factory()
        }
    }
}
