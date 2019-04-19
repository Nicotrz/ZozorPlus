//
//  Calculator.swift
//  CountOnMe
//
//  Created by Nicolas Sommereijns on 18/04/2019.
//  Copyright © 2019 Ambroise Collon. All rights reserved.
//

import Foundation

class Calculator {

    enum ExpressionValidity {
        case correct
        case newCalculNeeded
        case incorrect
    }

    var stringNumbers: [String] = [String()]
    var operators: [String] = ["+"]

    var canAddOperator: Bool {
        if let stringNumber = stringNumbers.last {
            if stringNumber.isEmpty {
                return false
            }
        }
        return true
    }

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

    func addOperator(operatorToAdd: String) -> Bool {
        if canAddOperator {
            operators.append(operatorToAdd)
            stringNumbers.append("")
            return true
        }
        return false
    }

    func addNumber(newNumber: Int) {
        if let stringNumber = stringNumbers.last {
            var stringNumberMutable = stringNumber
            stringNumberMutable += "\(newNumber)"
            stringNumbers[stringNumbers.count-1] = stringNumberMutable
        }

    }

    func clear() {
        stringNumbers = [String()]
        operators = ["+"]
    }

    func calculateTotal() -> String {
        if isExpressionCorrect != .correct {
            return ""
        }

        var total = 0
        for (inc, stringNumber) in stringNumbers.enumerated() {
            if let number = Int(stringNumber) {
                if operators[inc] == "+" {
                    total += number
                } else if operators[inc] == "-" {
                    total -= number
                }
            }
        }
        clear()
        return ("\(total)")
    }

    func getArrayCurrentState() -> String {
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
