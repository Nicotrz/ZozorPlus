//
//  Zozor_Tests.swift
//  CountOnMeTests
//
//  Created by Ambroise COLLON on 30/08/2016.
//  Copyright © 2016 Ambroise Collon. All rights reserved.
//

import XCTest
@testable import CountOnMe

class CalculatorTest: XCTestCase {

    var calculator =  Calculator()

    override func setUp() {
        calculator = Calculator()
        super.setUp()
    }

    func testGivenTabsShouldExist() {
        XCTAssertNotNil(calculator.operators)
    }

    func testWhenAddingNumberToStringNumbers_ArrayShouldFollow() {
        calculator.addNumber(newNumber: "7")
        XCTAssert(calculator.stringNumbers[0] == "7")
        calculator.addNumber(newNumber: "8")
        XCTAssert(calculator.stringNumbers[0] == "78")
        calculator.addOperator(operatorToAdd: "-")
        calculator.addNumber(newNumber: "9")
        XCTAssert(calculator.stringNumbers[1] == "9")
    }

    func testGivenStringNumberIsEmpty_CanAddOperatorShouldBeFalse() {
        XCTAssertFalse(calculator.canAddOperator)
    }

    func testGivenAddOperatorsAddAnOperatorWhenGiven() {
        calculator.addNumber(newNumber: "8")
        calculator.addOperator(operatorToAdd: "-")
        XCTAssert(calculator.operators.count == 2)
    }
}
