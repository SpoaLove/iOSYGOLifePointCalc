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

