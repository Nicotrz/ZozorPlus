//
//  ViewController.swift
//  CountOnMe
//
//  Created by Ambroise COLLON on 30/08/2016.
//  Copyright © 2016 Ambroise Collon. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    // MARK: - Properties
    let calculator  = Calculator()

    // MARK: - Outlets

    @IBOutlet weak var textView: UITextView!

    // MARK: - Action

    @IBAction func tappedNumberButton(_ sender: UIButton) {
        calculator.addNumber(newNumber: sender.tag)
            updateDisplay()
    }

    @IBAction func pushOperator(sender: UIButton) {
        var operatorToAdd: String
        if sender.tag == 0 {
            operatorToAdd = "+"
        } else {
            operatorToAdd = "-"
        }
        if calculator.addOperator(operatorToAdd: operatorToAdd) {
            updateDisplay()
        }
    }

    @IBAction func equal() {
        switch calculator.isExpressionCorrect {
        case .correct:
            let resultCalculation = calculator.calculateTotal()
            if resultCalculation != "" {
                textView.text = (textView.text + "=\(resultCalculation)")
            }
        case .incorrect:
            showAlert(message: "Entrez une expression correcte!", title: "Zéro")
        case .newCalculNeeded:
            showAlert(message: "Démarrez un nouveau calcul", title: "Zéro")
        }
    }

    // MARK: - Methods

    func showAlert(message: String, title: String) {
        let alertVC = UIAlertController(title: title, message: message, preferredStyle: .alert)
        alertVC.addAction(UIAlertAction(title: "OK", style: .cancel, handler: nil))
        self.present(alertVC, animated: true, completion: nil)
    }

    func updateDisplay() {
        textView.text = calculator.getArrayCurrentState()
    }

}
