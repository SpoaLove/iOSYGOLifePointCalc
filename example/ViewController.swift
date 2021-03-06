//
//  ViewController.swift
//  LifePointCalc
//
//  Created by Tengoku no Spoa on 2017/12/29.
//  Copyright © 2017年 Tengoku no Spoa. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    @IBOutlet private weak var firstPlayerLP: UILabel!
    @IBOutlet private weak var secondPlayerLP: UILabel!
    @IBOutlet private weak var inputTextField: UITextField!
    
    // Define currentPlayer
    private var currentPlayer:Int = 1
    private var currentPlayerLP:UILabel! {
        return currentPlayer == 1 ? firstPlayerLP : secondPlayerLP
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        
        // add GestureRecognizer
        self.view.addGestureRecognizer(UITapGestureRecognizer(target:self, action:#selector(handleTap(sender:))))
    }
    
    @IBAction private func playerChanged(_ sender: UISegmentedControl) {
        // set currentPlayer to the chosen segment
        currentPlayer = sender.selectedSegmentIndex+1
    }
    
    @IBAction private func reset() {
        let alert = UIAlertController(title: "Reset?", message: "Do you want to Reset?", preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "Yes", style: .destructive, handler: { (_) in
            // reset status
            self.firstPlayerLP.text = "8000"
            self.secondPlayerLP.text = "8000"
            self.inputTextField.text = nil
        }))
        alert.addAction(UIAlertAction(title: "No", style: .cancel, handler: nil))
        self.present(alert, animated: true, completion: nil)
    }
    
    private func setLP(lifePoint:Int) {
        if lifePoint <= 0{
            currentPlayerLP.text = "0"
            print("End Game")
            reset()
        }else{
            currentPlayerLP.text = String(lifePoint)
        }
    }
    
    @IBAction private func operationButton(_ sender: UIButton) {
        switch sender.titleLabel!.text {
        case "+"?:
            guard currentPlayerLP.text!.count <= 18 && inputTextField.text!.count <= 18 else { return }
            setLP(lifePoint: currentPlayerLP.text!.toInt() + inputTextField.text!.toInt())
        case "-"?:
            guard inputTextField.text!.count <= 18 else { return }
            setLP(lifePoint: currentPlayerLP.text!.toInt() - inputTextField.text!.toInt())
        case "Set"?:
            guard inputTextField.text!.count <= 18 else { return }
            setLP(lifePoint: inputTextField.text!.toInt())
        case "Half"?:
            if currentPlayerLP.text!.toInt() != 1  {
                setLP(lifePoint: currentPlayerLP.text!.toInt() / 2)
            } else {
                let alert = UIAlertController(title: "Warning", message: "You cannot half your LP when your LP is 1", preferredStyle: .alert)
                alert.addAction(UIAlertAction(title: "Ok", style: .default, handler: nil))
                self.present(alert, animated: true, completion: nil)
            }
        default:
            return
        }
    }
    
    @objc private func handleTap(sender: UITapGestureRecognizer) {
        if sender.state == .ended {
            inputTextField.resignFirstResponder()
        }
        sender.cancelsTouchesInView = false
    }

    @IBAction private func numberButtonPressed(_ sender: UIButton) {
        inputTextField.text = String(describing: inputTextField.text!.toInt() + sender.titleLabel!.text!.toInt())
    }
    
    @IBAction private func clearInput(_ sender: UIButton) {
        inputTextField.text = nil
    }
    
    @IBAction private func tossCoin(_ sender: UIButton) {
        let tossResult = 1.generateRandomIntWith(lowerBound: 0)
        let resultMessage = tossResult == 1 ? "Head" : "Tail"
        let alert = UIAlertController(title: "Coin:", message: resultMessage, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "Ok", style: .default, handler: nil))
        self.present(alert, animated: true, completion: nil)
    }
    
    @IBAction private func rollDice(_ sender: UIButton) {
        let rollResultMessage = String(6.generateRandomIntWith(lowerBound: 1))
        let alert = UIAlertController(title: "Dice:", message: rollResultMessage, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "Ok", style: .default, handler: nil))
        self.present(alert, animated: true, completion: nil)
    }
    

    @IBAction private func janken(_ sender: UIButton) {
        let winner = 1.generateRandomIntWith(lowerBound: 0)
        let resultMessage = winner == 1 ? "Player 1 Have Won" : "Player 2 Have Won"
        let alert = UIAlertController(title: "Janken:", message: resultMessage, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "Ok", style: .default, handler: nil))
        self.present(alert, animated: true, completion: nil)
    }
    
}


extension Int {
    func generateRandomIntWith(lowerBound:Int)->Int{
        return Int(arc4random_uniform(UInt32(self+1)) + UInt32(lowerBound))
    }
}

extension String {
    func toInt()->Int{
        if let result = Int(self){
            return result
        } else {
            return 0
        }
    }
}
