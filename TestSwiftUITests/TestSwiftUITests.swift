//
//  TestSwiftUITests.swift
//  TestSwiftUITests
//
//  Created by Kevin Patel on 4/22/21.
//

import XCTest
@testable import TestSwiftUI

class TestSwiftUITests: XCTestCase {

    override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    func testExample() throws {
        // This is an example of a functional test case.
        let foo = Counter()
        XCTAssert(foo.count == 0)
        foo.increment()
        foo.increment()
        foo.increment()
        XCTAssert(foo.count == 3, "Expected 3 Actual \(foo.count)")
        // Use XCTAssert and related functions to verify your tests produce the correct results.
    }

    func testPerformanceExample() throws {
        // This is an example of a performance test case.
        self.measure {
            // Put the code you want to measure the time of here.
        }
    }

}
