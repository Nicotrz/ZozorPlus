//
//  Calculator.swift
//  CountOnMe
//
//  Created by Nicolas Sommereijns on 18/04/2019.
//  Copyright © 2019 Ambroise Collon. All rights reserved.
//

import Foundation

class Calculator {

    // MARK: Enum
    enum ErrorCase {
        case valid
        case tooLarge
        case twoComa
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

    // This variable contain the result of the last operation
    private var lastResult: Float = 0

    // MARK: Public properties

    // isExpressionCorrect contain an ExpressionValidity to check if it is safe to calculate the result
    var isExpressionCorrect: Bool {
        if let stringNumber = stringNumbers.last {
            if stringNumber.isEmpty {
                return false
            }
        }
        return true
    }

    // MARK: Private Methods

    // This function calculate the Multiplication / Division operations
    // and send it back as an array containing two String arrays

    private func calculateMultiplicationDivision() -> [[String]] {
        // Array containing the result array of numbers only with + and - operations
        var tempNumbersArray = stringNumbers
        // Array containing the result array of operations only with + and -
        var tempOperatorsArray = operators

        // While there are * or / , we need to loop this function
        while priorPresence(operatorArray: tempOperatorsArray) {
            // For all operators in the operatorArray, we check if we have a * or a /
            for (inc, operatorString) in tempOperatorsArray.enumerated() {
                if operatorString == "*" || operatorString == "/" {
                    // We do. We calculate it then..And put the result number on index-1
                    if let firstNumber = Float(tempNumbersArray[inc-1]) {
                        if let secondNumber = Float(tempNumbersArray[inc]) {
                            if operatorString == "*" {
                                tempNumbersArray[inc-1] = ("\(firstNumber * secondNumber)")
                     } else if operatorString == "/" {
                                tempNumbersArray[inc-1] = ("\(firstNumber / secondNumber)")
                    }
                }
                       // Everything is calculate. We can remove the index number and operation
                       tempNumbersArray.remove(at: inc)
                       tempOperatorsArray.remove(at: inc)
                       // We need to exit the for loop or we will have an out of range error
                       break
                       }
                }
            }
        }
        // Returning the results
        return[tempNumbersArray, tempOperatorsArray]
    }

    // This function check if there is a * or a / on the operatorArray
    private func priorPresence(operatorArray: [String]) -> Bool {
        for operatorString in operatorArray where operatorString == "*" || operatorString == "/" {
            return true
        }
        return false
    }

    // This function test if the number sended is a decimal or a integer
    private func isThisADecimalFromString(numberToTest: String) -> Bool {
        for character in numberToTest.enumerated() where character.element == "." {
                return true
        }
        return false
    }

    private func isThisADecimalFromFloat(numberToTest: Float) -> Bool {
        return !(numberToTest.truncatingRemainder(dividingBy: 1.0) == 0)
    }

    // This function convert a float to string. If there is no decimal number, it is transformed into an Integer
    private func convertToString(toConvert: Float) -> String {
        if !isThisADecimalFromFloat(numberToTest: toConvert) {
            let int = Int(toConvert)
            return ("\(int)")
        }
        return ("\(toConvert)")
    }

    // MARK: Public Methods

    // Clear all arrays
    func clear() {
        stringNumbers = [String()]
        operators = ["+"]
        lastResult = 0
    }

    // This function add an operator to the array and send true if success - false if not (cannot addOperator)
    func addOperator(operatorToAdd: String) -> Bool {
        if canAddOperator {
            operators.append(operatorToAdd)
            stringNumbers.append("")
            return true
        } else {
            if stringNumbers[0].isEmpty {
                stringNumbers[0] = (convertToString(toConvert: lastResult))
                operators.append(operatorToAdd)
                stringNumbers.append("")
                return true
            }
        }
        return false
    }

    // This function add a number to the array
    func addNumber(newNumber: Int) -> ErrorCase {
        if let stringNumber = stringNumbers.last {
            if stringNumber.count == 7 {
                return .tooLarge
            }
            var stringNumberMutable = stringNumber
            // If the number is 10, we have a coma! We add it to the array
            if newNumber == 10 {
                if isThisADecimalFromString(numberToTest: stringNumberMutable) {
                    return .twoComa
                }
                if stringNumberMutable == "" {
                       stringNumberMutable += "0."
                } else {
                    stringNumberMutable += "."
                }
            } else {
            stringNumberMutable += "\(newNumber)"
            }
            stringNumbers[stringNumbers.count-1] = stringNumberMutable
        }
        return .valid
    }

    // This function calculate the result and send it back as a String
    func calculateTotal() -> String {
        var total: Float = 0
        let tempArray = calculateMultiplicationDivision()
        for (inc, stringNumber) in tempArray[0].enumerated() {
            if let number = Float(stringNumber) {
                if tempArray[1][inc] == "+" {
                    total += number
                } else if tempArray[1][inc] == "-" {
                    total -= number
                }
            }
        }
        clear()
        lastResult = total
        return convertToString(toConvert: total)
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
