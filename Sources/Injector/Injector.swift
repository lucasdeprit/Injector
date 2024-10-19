import Foundation

@propertyWrapper
public struct Inject<T> {
    private var instance: T

    public init(name: String? = nil) {
        self.instance = AppContainer.resolve(T.self, name: name)
    }

    public var wrappedValue: T {
        return instance
    }
}

// Global container accessible across the app
public let AppContainer = DependencyContainer()
