import Injector
import Foundation

protocol TestService: AnyObject {
    func fetchData() -> String
}

class MockService: TestService {
    func fetchData() -> String {
        return "Mock Data"
    }
}

class AnotherMockService: TestService {
    func fetchData() -> String {
        return "Another Mock Data"
    }
}

// A class to test the Inject property wrapper
class TestClass {
    @Inject var service: TestService // Using the property wrapper
    let id = UUID().uuidString // Return a unique UUID each time

    func getData() -> String {
        return service.fetchData()
    }
}
