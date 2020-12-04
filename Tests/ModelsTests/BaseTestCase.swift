import XCTest
import Models

open class BaseTestCase: XCTestCase {
    var jsonEncoder: JSONEncoder!
    var jsonDecoder: JSONDecoder!
    
    open override func setUp() {
        jsonEncoder = JSONEncoder()
        if #available(iOS 11.0, *) {
            jsonEncoder.outputFormatting = [.sortedKeys]
        }
        jsonDecoder = JSONDecoder()
    }
    
    open override func tearDown() {
        jsonEncoder = nil
        jsonDecoder = nil
    }
    
}
