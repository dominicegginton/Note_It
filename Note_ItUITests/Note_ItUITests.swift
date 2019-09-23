//
//  Note_ItUITests.swift
//  Note_ItUITests
//
//  Created by Dominic Egginton on 18/09/2019.
//  Copyright © 2019 Dominic Egginton. All rights reserved.
//

import XCTest

class Note_ItUITests: XCTestCase {

    override func setUp() {
        // Put setup code here. This method is called before the invocation of each test method in the class.

        // In UI tests it is usually best to stop immediately when a failure occurs.
        continueAfterFailure = false

        // UI tests must launch the application that they test. Doing this in setup will make sure it happens for each test method.
        XCUIApplication().launch()

        // In UI tests it’s important to set the initial state - such as interface orientation - required for your tests before they run. The setUp method is a good place to do this.
    }

    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    func testAddEmptyNote() {
        let app = XCUIApplication()
        // Open new Note
        app.buttons["newNoteButton"].tap()
        XCTAssertTrue(app.navigationBars["New Note"].exists)
        // Save empty note and goto main screne
        app.navigationBars.buttons.element(boundBy: 0).tap()
    }
    
    func testAddTestNote() {
        let app = XCUIApplication()
        // Open new note
        app.buttons["newNoteButton"].tap()
        XCTAssertTrue(app.navigationBars["New Note"].exists)
        // Type Note Text
        app.textFields["noteTitleText"].tap()
        app.textFields["noteTitleText"].typeText("Test Note")
        app.textViews["noteTextArea"].tap()
        app.textViews["noteTextArea"].typeText("This is the boady of the test note")
        // Save note and goto main screen
        app.buttons["doneButton"].tap()
        app.navigationBars.buttons.element(boundBy: 0).tap()
        // Check if note was added to table view
    }

}
