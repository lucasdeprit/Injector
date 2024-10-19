import XCTest
@testable import Injector

final class FactoryWrapperTests: XCTestCase {
    
    func testSingletonScope() {
        let factoryWrapper = FactoryWrapper(factory: { MockService() }, scope: .singleton)
        
        // Get the first instance
        let instance1 = factoryWrapper.getInstance() as! MockService
        // Get the second instance
        let instance2 = factoryWrapper.getInstance() as! MockService
        
        // Verify that both instances are the same (singleton behavior)
        XCTAssertTrue(instance1 === instance2, "Singleton instances should be the same")
        XCTAssertEqual(instance1.fetchData(), "Mock Data")
    }
    
    func testTransientScope() {
        let factoryWrapper = FactoryWrapper(factory: { MockService() }, scope: .transient)
        
        // Get the first instance
        let instance1 = factoryWrapper.getInstance() as! MockService
        // Get the second instance
        let instance2 = factoryWrapper.getInstance() as! MockService
        
        // Verify that both instances are different (transient behavior)
        XCTAssertFalse(instance1 === instance2, "Transient instances should not be the same")
        XCTAssertEqual(instance1.fetchData(), "Mock Data")
        XCTAssertEqual(instance2.fetchData(), "Mock Data")
    }
}
