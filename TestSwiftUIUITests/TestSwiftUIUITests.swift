//
//  TestSwiftUIUITests.swift
//  TestSwiftUIUITests
//
//  Created by Kevin Patel on 4/22/21.
//

import XCTest

class TestSwiftUIUITests: XCTestCase {

    override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.

        // In UI tests it is usually best to stop immediately when a failure occurs.
        continueAfterFailure = false

        // In UI tests it’s important to set the initial state - such as interface orientation - required for your tests before they run. The setUp method is a good place to do this.
    }

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    
        
    func testFullIntegration() throws {
        // UI tests must launch the application that they test.
        let app = XCUIApplication()
        app.launch()
        let globalIncrementButton = app.buttons["Global Increment"]
        globalIncrementButton.tap()
        globalIncrementButton.tap()
        app.buttons["Settings"].tap()
        globalIncrementButton.tap()
        globalIncrementButton.tap()
        app.navigationBars["_TtGC7SwiftUIP13$7fff57adc30428DestinationHosting"].buttons["Back"].tap()
        
        XCTAssert(app.staticTexts["Global Count 4"].exists)

        // Use recording to get started writing UI tests.
        // Use XCTAssert and related functions to verify your tests produce the correct results.
    }

    func testCounter() throws {
        // UI tests must launch the application that they test.
        let app = XCUIApplication()
        app.launchArguments = ["COUNTER-TEST"]

        app.launch()
        
        let globalIncrementButton = app.buttons["Global Increment"]
        globalIncrementButton.tap()
        globalIncrementButton.tap()
        globalIncrementButton.tap()
        
        XCTAssert(app.staticTexts["Global Count 3"].exists)
       
        // Use recording to get started writing UI tests.
        // Use XCTAssert and related functions to verify your tests produce the correct results.
    }
    
    func testLaunchPerformance() throws {
        if #available(macOS 10.15, iOS 13.0, tvOS 13.0, *) {
            // This measures how long it takes to launch your application.
            measure(metrics: [XCTApplicationLaunchMetric()]) {
                XCUIApplication().launch()
            }
        }
    }
}
