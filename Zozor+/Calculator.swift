//
//  Calculator.swift
//  CountOnMe
//
//  Created by Nicolas Sommereijns on 18/04/2019.
//  Copyright © 2019 Ambroise Collon. All rights reserved.
//

import Foundation

class Calculator {

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

    func addOperator(operatorToAdd: String) {
        if canAddOperator {
            operators.append(operatorToAdd)
            stringNumbers.append("")
        }
    }

    func addNumber(newNumber: String) {
        if let stringNumber = stringNumbers.last {
            var stringNumberMutable = stringNumber
            stringNumberMutable += "\(newNumber)"
            stringNumbers[stringNumbers.count-1] = stringNumberMutable
        }

    }
}
