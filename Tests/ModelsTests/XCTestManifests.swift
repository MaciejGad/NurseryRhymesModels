import XCTest

#if !canImport(ObjectiveC)
public func allTests() -> [XCTestCaseEntry] {
    return [
        testCase(BookListForRhymeTests.allTests),
        testCase(BookTests.allTests),
        testCase(ListItemTests.allTests),
        testCase(ListsTests.allTests),
        testCase(RhymeTests.allTests),
    ]
}
#endif
