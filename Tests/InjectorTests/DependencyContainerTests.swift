import XCTest
@testable import Injector

final class DependencyContainerTests: XCTestCase {
    
    var container: DependencyContainer!
    
    override func setUp() {
        super.setUp()
        container = DependencyContainer()
    }
    
    override func tearDown() {
        container = nil
        super.tearDown()
    }

    // Test case for registering and resolving a singleton instance
    func testRegisterAndResolveSingleton() {
        container.register(TestService.self, scope: .singleton) {
            MockService()
        }
        
        let service1: TestService = container.resolve(TestService.self)
        let service2: TestService = container.resolve(TestService.self)
        
        XCTAssertTrue(service1.fetchData() == "Mock Data")
        XCTAssertTrue(service2.fetchData() == "Mock Data")
        XCTAssert(service1 as AnyObject === service2 as AnyObject, "Singleton should return the same instance")
    }
    
    // Test case for registering and resolving a transient instance
    func testRegisterAndResolveTransient() {
        container.register(TestService.self, scope: .transient) {
            MockService()
        }
        
        let service1: TestService = container.resolve(TestService.self)
        let service2: TestService = container.resolve(TestService.self)
        
        XCTAssertTrue(service1.fetchData() == "Mock Data")
        XCTAssertTrue(service2.fetchData() == "Mock Data")
        XCTAssert(service1 as AnyObject !== service2 as AnyObject, "Transient should return different instances")
    }

    // Test case for registering and resolving named dependencies
    func testRegisterAndResolveNamedDependencies() {
        container.register(TestService.self, name: "default") {
            MockService()
        }
        
        container.register(TestService.self, name: "alternative") {
            AnotherMockService()
        }
        
        let defaultService: TestService = container.resolve(TestService.self, name: "default")
        let alternativeService: TestService = container.resolve(TestService.self, name: "alternative")
        
        XCTAssertEqual(defaultService.fetchData(), "Mock Data")
        XCTAssertEqual(alternativeService.fetchData(), "Another Mock Data")
    }
    
    // Test case for resolving an unregistered type
//    func testResolveUnregisteredType() {
//        XCTAssertThrowsError({
//            let _: TestService = self.container.resolve(TestService.self)
//        }(), "Should throw an error when trying to resolve an unregistered type")
//    }
//    
//    // Test case for verifying fatalError is called for an unregistered type
//    func testResolveFatalError() {
//        expectFatalError {
//            _ = self.container.resolve(TestService.self)
//        }
//    }
}

// Helper to test for fatal errors
//extension XCTestCase {
//    func expectFatalError(expectedMessage: String? = nil, testcase: @escaping () -> Void) {
//        let expectation = self.expectation(description: "Expecting fatalError")
//        
//        FatalErrorUtil.replaceFatalError { message, _, _ in
//            if let expectedMessage = expectedMessage {
//                XCTAssertEqual(message, expectedMessage)
//            }
//            expectation.fulfill()
//            // Simulate fatalError
//            Swift.fatalError(message) // Ensure it halts the execution
//        }
//        
//        DispatchQueue.global(qos: .userInitiated).async {
//            testcase()
//        }
//        
//        waitForExpectations(timeout: 2.0) { _ in
//            FatalErrorUtil.restoreFatalError()
//        }
//    }
//}
//
//struct FatalErrorUtil {
//    typealias FatalErrorClosureType = (String, StaticString, UInt) -> Never
//
//    static var fatalErrorClosure: FatalErrorClosureType = defaultFatalErrorClosure
//    private static let defaultFatalErrorClosure: FatalErrorClosureType = { message, _, _ in
//        Swift.fatalError(message)
//    }
//
//    static func replaceFatalError(closure: @escaping FatalErrorClosureType) {
//        fatalErrorClosure = closure
//    }
//
//    static func restoreFatalError() {
//        fatalErrorClosure = defaultFatalErrorClosure
//    }
//}
//
//// Override Swift's fatalError
//func fatalError(_ message: @autoclosure () -> String = "", file: StaticString = #file, line: UInt = #line) -> Never {
//    FatalErrorUtil.fatalErrorClosure(message(), file, line)
//}
