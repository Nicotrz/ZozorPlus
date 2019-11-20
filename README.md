# CountOnMe
> An iOS Calculator app for the project number 5 of the iOS Developer training program of OpenclassRooms
<a href="https://github.com/Nicotrz"><img src="https://github.com/Nicotrz/ZozorPlus/blob/master/Capture%20d’écran%202019-11-20%20à%2021.41.43.png?raw=true" title="CountOnMe" alt="Nicotrz"></a>
<!-- [![FVCproductions](https://github.com/Nicotrz/ZozorPlus/blob/master/Capture%20d’écran%202019-11-20%20à%2021.41.43.png?raw=true)](https://github.com/Nicotrz) -->

## Setup

To edit the code, just clone the repo.
This app is not available on the App Store

## Features

Make basic math operations on iOS.

- All basic operations (+,-,\*,\/) are supported
- Decimal numbers are supported
- You can use the result from the last operation to make a new operation

## Purpose of the project

The main purpose of the project was to start from a buggy / unresponsive / badly coded app to make a beautiful well coded and responsive app with MVC Architecture

## First step: Reponsiveness of the app

<img src="https://github.com/Nicotrz/ZozorPlus/blob/master/Capture%20d’écran%202019-11-20%20à%2021.51.49.png?raw=true" title="CountOnMe" alt="Nicotrz">

The purpose of this step is to make a nice app suitable for all the iDevices

## Second step: clean code architecture

All of the logic code was on the ViewController. So all of the code needed to be better organised to respect the MVC Architecture.

Example from the ViewController initial commit:

```Swift
class ViewController: UIViewController {
    // MARK: - Properties
    var stringNumbers: [String] = [String()]
    var operators: [String] = ["+"]
    var index = 0
    var isExpressionCorrect: Bool {
        if let stringNumber = stringNumbers.last {
            if stringNumber.isEmpty {
                if stringNumbers.count == 1 {
                    let alertVC = UIAlertController(title: "Zéro!", message: "Démarrez un nouveau calcul !", preferredStyle: .alert)
                    alertVC.addAction(UIAlertAction(title: "OK", style: .cancel, handler: nil))
                    self.present(alertVC, animated: true, completion: nil)
                } else {
                    let alertVC = UIAlertController(title: "Zéro!", message: "Entrez une expression correcte !", preferredStyle: .alert)
                    alertVC.addAction(UIAlertAction(title: "OK", style: .cancel, handler: nil))
                    self.present(alertVC, animated: true, completion: nil)
                }
                return false
            }
        }
        return true
    }

    var canAddOperator: Bool {
        if let stringNumber = stringNumbers.last {
            if stringNumber.isEmpty {
                let alertVC = UIAlertController(title: "Zéro!", message: "Expression incorrecte !", preferredStyle: .alert)
                alertVC.addAction(UIAlertAction(title: "OK", style: .cancel, handler: nil))
                self.present(alertVC, animated: true, completion: nil)
                return false
            }
        }
        return true
        }
 }
 ```
 
 This code has been moved on the newly created model:
 ```Swift
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
```

        
