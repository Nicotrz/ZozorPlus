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
        let boolResult = calculator.addOperator(operatorToAdd: "-")
        calculator.addNumber(newNumber: "9")
        XCTAssert(calculator.stringNumbers[1] == "9")
        XCTAssert(boolResult)
    }

    func testGivenStringNumberIsEmpty_CanAddOperatorShouldBeFalse() {
        XCTAssertFalse(calculator.canAddOperator)
    }

    func testGivenAddOperatorsAddAnOperatorWhenGiven() {
        calculator.addNumber(newNumber: "8")
        let boolResult = calculator.addOperator(operatorToAdd: "-")
        XCTAssert(calculator.operators.count == 2)
        XCTAssert(boolResult)
    }

    func testGivenLastNumberOfArrayIsEmptyWhenAddingOperator_addOperatorShouldReturnFalse() {
        let boolResult = calculator.addOperator(operatorToAdd: "-")
        XCTAssertFalse(boolResult)
    }

    func testGivenNoNumbers_ValidityExpressionShouldBeNeedNewCalcul() {
        XCTAssertEqual(calculator.isExpressionCorrect, .newCalculNeeded )
    }

    func testGivenNumberAndOperator_ValidityExpressionShouldBeIncorrect() {
        calculator.addNumber(newNumber: "9")
        _ = calculator.addOperator(operatorToAdd: "+")
        XCTAssertEqual(calculator.isExpressionCorrect, .incorrect)
    }

    func testGivenCorrectExpression_ValidityExpressionShouldBeCorrect() {
        calculator.addNumber(newNumber: "99")
        _ = calculator.addOperator(operatorToAdd: "-")
        calculator.addNumber(newNumber: "87")
        XCTAssertEqual(calculator.isExpressionCorrect, .correct)
    }

    func testGivenCorrectExpression_WhenCallingClear_ArrayShouldBeReinitialised() {
        calculator.addNumber(newNumber: "9")
        _ = calculator.addOperator(operatorToAdd: "-")
        calculator.addNumber(newNumber: "9")
        calculator.clear()
        XCTAssertEqual(calculator.operators, ["+"])
        XCTAssertEqual(calculator.stringNumbers, [""])
    }

    func testGivenExpressionIsIncorrect_WhenCallingCalculateResult_StringResultShouldBeEmpty() {
        calculator.addNumber(newNumber: "9")
        _ = calculator.addOperator(operatorToAdd: "-")
        let expressionResult = calculator.calculateTotal()
        XCTAssertEqual(expressionResult, "")
    }

    func testGivenExpression_WhenCallingCalculateResult_CheckResultValidity() {
        calculator.addNumber(newNumber: "9")
        _ = calculator.addOperator(operatorToAdd: "+")
        calculator.addNumber(newNumber: "56")
        var expressionResult = calculator.calculateTotal()
        XCTAssertEqual(expressionResult, "65" )
        calculator.addNumber(newNumber: "7")
        _ = calculator.addOperator(operatorToAdd: "-")
        calculator.addNumber(newNumber: "1")
        expressionResult = calculator.calculateTotal()
        XCTAssertEqual(expressionResult, "6")
    }
}
