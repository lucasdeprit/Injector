//
//  TestService.swift
//  Injector
//
//  Created by lucasdeprit on 19/10/24.
//


import Foundation

protocol TestService: AnyObject {
    func fetchData() -> String
}

class MockService: TestService {
    func fetchData() -> String {
        return UUID().uuidString // Return a unique UUID each time
    }
}

class AnotherMockService: TestService {
    func fetchData() -> String {
        return UUID().uuidString // Return a unique UUID each time
    }
}
