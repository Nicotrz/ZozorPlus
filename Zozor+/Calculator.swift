//
//  Calculator.swift
//  CountOnMe
//
//  Created by Nicolas Sommereijns on 18/04/2019.
//  Copyright © 2019 Ambroise Collon. All rights reserved.
//

import Foundation

class Calculator {

    // MARK: Type
    enum ExpressionValidity {
        case correct
        case newCalculNeeded
        case incorrect
    }

    // MARK: Private Properties

    // StringNumbers contain the numbers to calculate
    private var stringNumbers: [String] = [String()]
    // Operators contain the operators to use
    private var operators: [String] = ["+"]

    // canAddOperator contain a bool to check if it is safe to insert a new operator
    private var canAddOperator: Bool {
        if let stringNumber = stringNumbers.last {
            if stringNumber.isEmpty {
                return false
            }
        }
        return true
    }

    // MARK: Public properties

    // isExpressionCorrect contain an ExpressionValidity to check if it is safe to calculate the result
    var isExpressionCorrect: ExpressionValidity {
        if let stringNumber = stringNumbers.last {
            if stringNumber.isEmpty {
                if stringNumbers.count == 1 {
                    return .newCalculNeeded
                } else {
                    return .incorrect
                }
            }
        }
        return .correct
    }

    // MARK: Private Methods

    // This function clear the two arrays
    private func clear() {
        stringNumbers = [String()]
        operators = ["+"]
    }

    private func calculateMultiplicationDivision() -> [[String]] {
        var tempNumbersArray = stringNumbers
        var tempOperatorsArray = operators

        for (inc, operatorString) in tempOperatorsArray.enumerated() {
            if operatorString == "*" {
                if let firstNumber = Int(tempNumbersArray[inc-1]) {
                    if let secondNumber = Int(tempNumbersArray[inc]) {
                        tempNumbersArray[inc-1] = ("\(firstNumber * secondNumber)")
                        tempNumbersArray.remove(at: inc)
                        tempOperatorsArray.remove(at: inc)
                    }
                }
            } else if operatorString == "/" {
                if let firstNumber = Int(tempNumbersArray[inc-1]) {
                    if let secondNumber = Int(tempNumbersArray[inc]) {
                        tempNumbersArray[inc-1] = ("\(firstNumber / secondNumber)")
                        tempNumbersArray.remove(at: inc)
                        tempOperatorsArray.remove(at: inc)
                    }
                }

            }
        }
        return[tempNumbersArray, tempOperatorsArray]
    }

    // MARK: Public Methods

    // This function add an operator to the array and send true if success - false if not (cannot addOperator)
    func addOperator(operatorToAdd: String) -> Bool {
        if canAddOperator {
            operators.append(operatorToAdd)
            stringNumbers.append("")
            return true
        }
        return false
    }

    // This function add a number to the array
    func addNumber(newNumber: Int) {
        if let stringNumber = stringNumbers.last {
            var stringNumberMutable = stringNumber
            stringNumberMutable += "\(newNumber)"
            stringNumbers[stringNumbers.count-1] = stringNumberMutable
        }

    }

    // This function calculate the result and send it back as a String
    func calculateTotal() -> String {
        var total = 0
        let tempArray = calculateMultiplicationDivision()
        for (inc, stringNumber) in tempArray[0].enumerated() {
            if let number = Int(stringNumber) {
                if tempArray[1][inc] == "+" {
                    total += number
                } else if tempArray[1][inc] == "-" {
                    total -= number
                }
            }
        }
        clear()
        return ("\(total)")
    }

    // This function send the current state of the arrays ( operation ) and send it back as a String
    func getCurrentState() -> String {
        var text = ""
        for (inc, stringNumber) in stringNumbers.enumerated() {
            // Add operator
            if inc > 0 {
                text += operators[inc]
            }
            // Add number
            text += stringNumber
        }
        return text
    }

}
