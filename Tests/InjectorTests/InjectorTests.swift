import XCTest
@testable import Injector

//// protocol for testing
//protocol testservice {
//    func fetchdata() -> string
//}
//
//// mock implementations
//class mockservice: testservice {
//    func fetchdata() -> string {
//        return "mock data"
//    }
//}
//
//class anothermockservice: testservice {
//    func fetchdata() -> string {
//        return "another mock data"
//    }
//}
//
// Class using the Inject property wrapper
//class TestClass {
//    @Inject var service: TestService
//    
//    func getData() -> String {
//        return service.fetchData()
//    }
//}

final class InjectTests: XCTestCase {
    
    override func setUp() {
        super.setUp()
        
        // Register mock services for testing
        AppContainer.register(TestService.self, scope: .singleton) {
            MockService()
        }
        
        AppContainer.register(TestService.self, name: "alternative", scope: .transient) {
            AnotherMockService()
        }
    }
    
    func testInjectSingletonService() {
        let testInstance = TestClass()

        // Ensure the service resolves correctly and is the expected instance
        XCTAssertEqual(testInstance.getData(), "Mock Data")
        
        // Verify that the injected service is the same instance (singleton)
        let service1 = testInstance.service
        let service2 = testInstance.service
        
        XCTAssertTrue(service1 === service2, "Inject should return the same instance for singleton")
    }
    
    func testInjectTransientService() {
        let testInstance1 = TestClass() // First instance of TestClass
        let testInstance2 = TestClass() // Second instance of TestClass
        
        // Ensure the service resolves correctly
        XCTAssertEqual(testInstance1.getData(), "Mock Data")
        XCTAssertEqual(testInstance2.getData(), "Mock Data")
        
        // Verify that the injected services are different instances (transient)
        XCTAssertFalse(testInstance1 === testInstance2, "Inject should return different instances for transient services")
    }
}
