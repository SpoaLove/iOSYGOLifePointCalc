//
//  ViewController.swift
//  LifePointCalc
//
//  Created by Tengoku no Spoa on 2017/12/29.
//  Copyright © 2017年 Tengoku no Spoa. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    
    private var currentPlayer:Int = 1
    private var currentPlayerLP:UILabel! {
        return currentPlayer == 1 ? firstPlayerLP : secondPlayerLP
    }
    
    @IBOutlet weak var firstPlayerLP: UILabel!
    @IBOutlet weak var secondPlayerLP: UILabel!
    @IBOutlet weak var inputNumber: UITextField!
    

    @IBAction func playerChanged(_ sender: UISegmentedControl) {
        currentPlayer = sender.selectedSegmentIndex+1
    }
    
    func reset(){
        let alert = UIAlertController(title: "Reset?", message: "Do you want to Reset?", preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "Yes", style: .default, handler: { (_) in
            self.firstPlayerLP.text = "8000"
            self.secondPlayerLP.text = "8000"
            self.inputNumber.text = ""
        }))
        alert.addAction(UIAlertAction(title: "No", style: .cancel, handler: nil))
        self.present(alert, animated: true, completion: nil)
    }
    
    func setLP(lifePoint:Int){
        if lifePoint <= 0{
            currentPlayerLP.text = "0"
            print("End Game")
            reset()
        }else{
            currentPlayerLP.text = String(lifePoint)
        }
    }
    
    
    @IBAction func operationButton(_ sender: UIButton) {
        switch sender.titleLabel!.text {
        case "+"?:
            setLP(lifePoint: currentPlayerLP.text!.toInt() + inputNumber.text!.toInt())
        case "-"?:
            setLP(lifePoint: currentPlayerLP.text!.toInt() - inputNumber.text!.toInt())
        case "set"?:
            setLP(lifePoint: inputNumber.text!.toInt())
        case "half"?:
            setLP(lifePoint: currentPlayerLP.text!.toInt() / 2)
        default:
            return
        }
    }
    
    @IBAction func numberButtonPressed(_ sender: UIButton) {
        inputNumber.text = String(describing: sender.titleLabel!.text!.toInt())
    }
    
    @IBAction func resetButtonDidPressed(_ sender: UIButton) {
        reset()
    }
    
    
    @IBAction func tossCoin(_ sender: UIButton) {
        let tossResult = 1.generateRandomIntWith(lowerBound: 0)
        let resultMessage = tossResult == 1 ? "Head" : "Tail"
        let alert = UIAlertController(title: "Coin:", message: resultMessage, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "Ok", style: .default, handler: nil))
        self.present(alert, animated: true, completion: nil)
    }
    
    @IBAction func rollDice(_ sender: UIButton) {
        let tossResultMessage = String(6.generateRandomIntWith(lowerBound: 0))
        let alert = UIAlertController(title: "Dice:", message: tossResultMessage, preferredStyle: .alert)
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

