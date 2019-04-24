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

    func addNumbers(numbersToSend: [Int]) {
        for number in numbersToSend {
            _ = calculator.addNumber(newNumber: number)
        }
    }

    func testGiveOneOperatorInArrayWhenAddingOperator_addOperatorShouldReturnFalse() {
        let firstResult = calculator.addOperator(operatorToAdd: "+")
        let secondResult = calculator.addOperator(operatorToAdd: "*")
        XCTAssert(firstResult)
        XCTAssertFalse(secondResult)
    }

    func testGivenNoNumbers_ValidityExpressionShouldBeFalse() {
        XCTAssertFalse(calculator.isExpressionCorrect )
    }

    func testGivenNumberAndOperator_ValidityExpressionShouldBeIncorrect() {
        addNumbers(numbersToSend: [9])
        _ = calculator.addOperator(operatorToAdd: "+")
        XCTAssertFalse(calculator.isExpressionCorrect)
    }

    func testGivenSevenMinusOnePlusFive_ResultShouldBeElevenAndCurrentStateShouldBeEmpty() {
        addNumbers(numbersToSend: [7])
        _ = calculator.addOperator(operatorToAdd: "-")
        addNumbers(numbersToSend: [1])
        _ = calculator.addOperator(operatorToAdd: "+")
        addNumbers(numbersToSend: [5])
        // Testing the current State for display
        XCTAssertEqual(calculator.getCurrentState(), "7-1+5")
        // Testing if expression is correct send the good result
        XCTAssert(calculator.isExpressionCorrect)
        // Calculate the result
        let expressionResult = calculator.calculateTotal()
        XCTAssertEqual(expressionResult, "11")
        // Testing the current State for display
        XCTAssertEqual(calculator.getCurrentState(), "")
    }

    func testGivenFiveTimesFive_WhenCallingCalculateResult_ResultShouldBeTwentyFive() {
        addNumbers(numbersToSend: [5])
        _ = calculator.addOperator(operatorToAdd: "*")
        addNumbers(numbersToSend: [5])
        let expressionResult = calculator.calculateTotal()
        XCTAssertEqual(expressionResult, "25")
    }

    func testGivenFivePlusTenTimesFive_WhenCallingCalculateResult_ResultShouldBeFiftyFive() {
        addNumbers(numbersToSend: [5])
        _ = calculator.addOperator(operatorToAdd: "+")
        addNumbers(numbersToSend: [1, 0])
        _ = calculator.addOperator(operatorToAdd: "*")
        addNumbers(numbersToSend: [5])
        let expressionResult = calculator.calculateTotal()
        XCTAssertEqual(expressionResult, "55")
    }

    func testGivenFiftyDividedByFive_WhenCallingCalculateResult_ResultShouldBeTen() {
        addNumbers(numbersToSend: [5, 0])
        _ = calculator.addOperator(operatorToAdd: "/")
        addNumbers(numbersToSend: [5])
        let expressionResult = calculator.calculateTotal()
        XCTAssertEqual(expressionResult, "10")
    }

    func testGivenNumberOnOperation_CurrentStateShouldSendFloatOrIntGivenContect() {
        // Warning: 10 is a coma!
        addNumbers(numbersToSend: [7, 10, 4])
        _ = calculator.addOperator(operatorToAdd: "+")
        addNumbers(numbersToSend: [2])
        XCTAssertEqual(calculator.getCurrentState(), "7.4+2")
        let expressionResult = calculator.calculateTotal()
        XCTAssertEqual(expressionResult, "9.4")
    }

    func testGivenWeAddAComaWhitoutNumber_NumberIsZeroPointX() {
        addNumbers(numbersToSend: [10, 2])
        XCTAssertEqual(calculator.getCurrentState(), "0.2")
    }

    func testGivenADecimalNumber_WhenAddingAnotherDecimal_ThenCanAddNumberReturnFalse() {
        addNumbers(numbersToSend: [5, 10, 2])
        XCTAssertFalse(calculator.addNumber(newNumber: 10))
    }

    func testGivenAIntegerNumber_WhenAddingDecimal_ThenCanAddNumberReturnTrue() {
        addNumbers(numbersToSend: [5, 0])
        XCTAssert(calculator.addNumber(newNumber: 10))
    }
}
