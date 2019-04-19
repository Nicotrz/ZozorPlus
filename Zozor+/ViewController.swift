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
    @IBOutlet var numberButtons: [UIButton]!

    // MARK: - Action

    @IBAction func tappedNumberButton(_ sender: UIButton) {
        for (inc, numberButton) in numberButtons.enumerated() where sender == numberButton {
            calculator.addNumber(newNumber: inc)
            updateDisplay()
        }
    }

    @IBAction func plus() {
        if calculator.addOperator(operatorToAdd: "+") {
            updateDisplay()
        }
    }

    @IBAction func minus() {
        if calculator.addOperator(operatorToAdd: "-") {
            updateDisplay()
        }
    }

    @IBAction func equal() {
        let resultCalculation = calculator.calculateTotal()
        if resultCalculation != "" {
            textView.text = (textView.text + "=\(resultCalculation)")
        }
    }

    // MARK: - Methods

    func updateDisplay() {
        textView.text = calculator.getArrayCurrentState()
    }

}
