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
    @IBAction func tappedNumberButton(_ sender: UIButton) {
        calculator.addNumber(newNumber: sender.tag)
            updateDisplay()
    }

    // Called when one the user tap an operator
    // Tag 0 is +
    // Tag 1 is -
    // If addOperator sens back false, the operation cannot be done
    @IBAction func pushOperator(sender: UIButton) {
        var operatorToAdd: String
        if sender.tag == 0 {
            operatorToAdd = "+"
        } else {
            operatorToAdd = "-"
        }
        if calculator.addOperator(operatorToAdd: operatorToAdd) {
            updateDisplay()
        } else {
            showAlert(message: "Expression incorrecte!", title: "Erreur")
        }
    }

    // Called when the user tapp equal
    // First we check if the expression is valid
    // If it is, we calculate the result and put it on textView
    // Else, we display an error message
    @IBAction func equal() {
        switch calculator.isExpressionCorrect {
        case .correct:
            let resultCalculation = calculator.calculateTotal()
                textView.text = (textView.text + "=\(resultCalculation)")
        case .incorrect:
            showAlert(message: "Entrez une expression correcte!", title: "Zéro")
        case .newCalculNeeded:
            showAlert(message: "Démarrez un nouveau calcul", title: "Zéro")
        }
    }

    // MARK: - Methods

    // Function to display a message alert with the title title
    func showAlert(message: String, title: String) {
        let alertVC = UIAlertController(title: title, message: message, preferredStyle: .alert)
        alertVC.addAction(UIAlertAction(title: "OK", style: .cancel, handler: nil))
        self.present(alertVC, animated: true, completion: nil)
    }

    // Function to refresh the display depending on the current state of the model
    func updateDisplay() {
        textView.text = calculator.getCurrentState()
    }

}
