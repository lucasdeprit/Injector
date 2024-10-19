//
//  FactoryWrapper.swift
//  Injector
//
//  Created by lucasdeprit on 17/10/24.
//

import Foundation

// Enum to define the lifecycle of the instances
public enum Scope {
    case singleton
    case transient
}

// Wrapper class to manage factory function and scope
final class FactoryWrapper {
    private let factory: () -> Any
    private let scope: Scope
    private var instance: Any?

    init(factory: @escaping () -> Any, scope: Scope) {
        self.factory = factory
        self.scope = scope
    }

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
