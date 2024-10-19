//
//  DependencyContainer.swift
//  Injector
//
//  Created by lucasdeprit on 17/10/24.
//

import Foundation

public final class DependencyContainer {
    // Dictionary to store factories with key as type identifier
    private var factories = [String: FactoryWrapper]()
    
    public init() {}

    // Register method to add a factory for a given type
    public func register<T>(_ type: T.Type, name: String? = nil, scope: Scope = .transient, factory: @escaping () -> T) {
        let key = generateKey(for: type, name: name)
        let factoryWrapper = FactoryWrapper(factory: factory, scope: scope)
        factories[key] = factoryWrapper
    }

    // Resolve method to retrieve an instance
    public func resolve<T>(_ type: T.Type, name: String? = nil) -> T {
        let key = generateKey(for: type, name: name)
        guard let factoryWrapper = factories[key], let instance = factoryWrapper.getInstance() as? T else {
            fatalError("No registration found for type \(type)")
        }
        return instance
    }
    
    // Generate a unique key for each type/name combination
    private func generateKey<T>(for type: T.Type, name: String?) -> String {
        let typeName = String(describing: type)
        return name.map { "\(typeName)_\($0)" } ?? typeName
    }
}

