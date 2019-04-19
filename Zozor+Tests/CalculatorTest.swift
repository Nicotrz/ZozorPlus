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

    func testGivenLastNumberOfArrayIsEmptyWhenAddingOperator_addOperatorShouldReturnFalse() {
        let boolResult = calculator.addOperator(operatorToAdd: "-")
        XCTAssertFalse(boolResult)
    }

    func testGivenNoNumbers_ValidityExpressionShouldBeNeedNewCalcul() {
        XCTAssertEqual(calculator.isExpressionCorrect, .newCalculNeeded )
    }

    func testGivenNumberAndOperator_ValidityExpressionShouldBeIncorrect() {
        calculator.addNumber(newNumber: 9)
        _ = calculator.addOperator(operatorToAdd: "+")
        XCTAssertEqual(calculator.isExpressionCorrect, .incorrect)
    }

    func testGivenExpression_WhenCallingCalculateResult_CheckResultValidityAndCurrentStateMustBeCleaned() {
        // Testing 9 + 56. Result Should be 65
        calculator.addNumber(newNumber: 9)
        _ = calculator.addOperator(operatorToAdd: "+")
        calculator.addNumber(newNumber: 5)
        calculator.addNumber(newNumber: 6)
        XCTAssertEqual(calculator.isExpressionCorrect, .correct)
        var expressionResult = calculator.calculateTotal()
        XCTAssertEqual(expressionResult, "65" )

        // Testing 7 - 1 + 5. Result Should be 11
        calculator.addNumber(newNumber: 7)
        _ = calculator.addOperator(operatorToAdd: "-")
        calculator.addNumber(newNumber: 1)
        XCTAssertEqual(calculator.isExpressionCorrect, .correct)
        _ = calculator.addOperator(operatorToAdd: "+")
        calculator.addNumber(newNumber: 5)
        // Testing the current State for display
        XCTAssertEqual(calculator.getCurrentState(), "7-1+5")
        expressionResult = calculator.calculateTotal()
        XCTAssertEqual(expressionResult, "11")
        // Testing the current State for display
        XCTAssertEqual(calculator.getCurrentState(), "")
    }
}
