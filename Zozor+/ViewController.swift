//
//  ViewController.swift
//  CountOnMe
//
//  Created by Ambroise COLLON on 30/08/2016.
//  Copyright © 2016 Ambroise Collon. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    // MARK: - Model
    let calculator  = Calculator()

    // MARK: - Outlet

    @IBOutlet weak var textView: UITextView!

    // MARK: - Actions

    // Called when one of the number is tapped.
    // Take the tag to know witch number
    // Note: Number 10 is take as a coma
    @IBAction func tappedNumberButton(_ sender: UIButton) {
        calculator.addNumber(newNumber: sender.tag)
            updateDisplay()
    }

    @IBAction func tappedClearButton(_ sender: Any) {
        calculator.clear()
        textView.text = "0"
    }

    // Called when one the user tap an operator
    // Tag 0 is +
    // Tag 1 is -
    // Tag 2 is *
    // Tag 3 is /
    // If addOperator sens back false, the operation cannot be done
    @IBAction func pushOperator(sender: UIButton) {
        var operatorToAdd: String
        if sender.tag == 0 {
            operatorToAdd = "+"
        } else if sender.tag == 1 {
            operatorToAdd = "-"
        } else if sender.tag == 2 {
            operatorToAdd = "*"
        } else {
            operatorToAdd = "/"
        }
        if calculator.addOperator(operatorToAdd: operatorToAdd) {
            updateDisplay()
        } else {
            showAlert(message: "SYNTAX ERROR!")
        }
    }

    // Called when the user tapp equal
    // First we check if the expression is valid
    // If it is, we calculate the result and put it on textView
    // Else, we display an error message
    @IBAction func equal() {
        if calculator.isExpressionCorrect {
            let resultCalculation = calculator.calculateTotal()
                textView.text = (textView.text + "=\(resultCalculation)")
        } else {
            showAlert(message: "SYNTAX ERROR!")
        }
    }

    // MARK: - Methods

    // Function to display a Syntax Error Alert
    func showAlert(message: String) {
        let tempText = textView.text
        textView.text = "ERR\n\(message)"
        DispatchQueue.global(qos: .background).async {
            sleep(3)
            DispatchQueue.main.async {
                self.textView.text = tempText
            }
        }
    }

    // Function to refresh the display depending on the current state of the model
    func updateDisplay() {
        textView.text = calculator.getCurrentState()
    }

}
