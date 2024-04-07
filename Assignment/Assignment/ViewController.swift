//
//  ViewController.swift
//  Assignment
//
//  Created by Cyrena Fong on 8/10/2019.
//  Copyright © 2019 cyrenafong. All rights reserved.
//

import UIKit

class ViewController: UIViewController, UITextFieldDelegate {
    
    var temp = ""
    var prevOp = 0
    var opTag = 0
    var prevN = 0.0
    var result = 0.0
    var inner = 0.0
    var brIn = 0.0
    
    
    @IBOutlet var textField: UITextField!
    @IBOutlet var iLabel: UILabel!
    
    @IBOutlet var debug: UILabel!
    
    func cal (_ op: Int) -> Double {
        if op == 1 {
            result = prevN + Double(temp)!
        }
        if op == 2 {
            result = prevN - Double(temp)!
        }
        if op == 3 {
            let mid = inner * Double(temp)!
            if prevOp == 1 {
                result = prevN + mid
            }
            if prevOp == 2 {
                result = prevN - mid
            }
        }
        if op == 4 {
            let mid = inner / Double(temp)!
            if prevOp == 1 {
                result = prevN + mid
            }
            if prevOp == 2 {
                result = prevN - mid
            }
        }
        if op == 6 {
            inner = Double(temp)!.squareRoot()
            if prevOp == 1 {
                result = prevN + inner
            }
            if prevOp == 2 {
                result = prevN - inner
            }
        }
        return result
    }
    
    @IBAction func textFieldEdit(_ sender: UITextField) {
        if temp.count > 0 {
            temp = ""
        }
        let store = Array(textField.text!)
        prevOp = 0
        result = 0.0
        inner = 0.0
        
        for t in 0..<store.count {
            if store[t].isNumber {
                temp = temp + String(store[t])
                cal(opTag)
            } else {
                /*if store[t] == "." {
                    temp = temp + "."
                }*/
                if store[t] == "+" {
                    if prevOp == 0 {
                        prevOp = opTag
                        prevN = Double(temp)!
                        opTag = 1
                        temp = ""
                    } else {
                        prevN = result
                        opTag = 1
                        temp = ""
                    }
                }
                /*if store[t] == "-" {
                    if prevOp == 0 {
                        prevOp = opTag
                        prevN = Double(temp)!
                        opTag = 2
                        temp = ""
                    } else {
                        prevN = result
                        opTag = 2
                        temp = ""
                    }
                }
                if store[t] == "x" {
                    prevOp = opTag
                    inner = Double(temp)!
                    opTag = 3
                    temp = ""
                }
                if store[t] == "/" {
                    if opTag == 6 {
                        if prevOp == 1 {
                            result = result - prevN
                        }
                        if prevOp == 2 {
                            result = result + prevN
                        }
                    } else {
                        inner = Double(temp)!
                        prevOp = opTag
                    }
                    opTag = 4
                    temp = ""
                }
                if store[t] == "%" {
                    let mid = Double(temp)!/100
                    if prevOp == 1 {
                        result = prevN + inner/mid
                    }
                    if prevOp == 2 {
                        result = prevN - inner/mid
                    }
                    if floor(result) == result {
                        iLabel.text = String(Int(result))
                    }else{
                        iLabel.text = String(result)
                    }
                 }
                if store[t] == "√" {
                    prevN = result
                    prevOp = opTag
                    opTag = 6
                }
                if store[t] == "(" { }
                if store[t] == ")" { }*/
            }
        }
        
        debug.text = "count: \(store.count), temp: \(temp)"
    }
    
    @IBAction func number(_ sender: UIButton) {
        if sender.tag < 10 {
            temp = temp + String(sender.tag)
            textField.text?.append(String(sender.tag))
        }else{
            temp = temp + "."
            textField.text?.append(".")
        }
        if opTag != 0 {
            let res = cal(opTag)
            if floor(res) == res {
                iLabel.text = String(Int(res))
            }else{
                iLabel.text = String(res)
            }
        } else {
            iLabel.text = temp
        }
        
    }
    
    @IBAction func addition(_ sender: Any) {
        if prevOp == 0 {
            prevOp = opTag
            prevN = Double(temp)!
            opTag = 1
            temp = ""
            textField.text?.append("+")
        } else {
            prevN = result
            opTag = 1
            temp = ""
            textField.text?.append("+")
        }
    }
    
    @IBAction func subtraction(_ sender: Any) {
        if prevOp == 0 {
            prevOp = opTag
            prevN = Double(temp)!
            opTag = 2
            temp = ""
            textField.text?.append("-")
        } else {
            prevN = result
            opTag = 2
            temp = ""
            textField.text?.append("-")
        }
    }
    
    @IBAction func multiplication(_ sender: Any) {
        prevOp = opTag
        inner = Double(temp)!
        opTag = 3
        temp = ""
        textField.text?.append("x")
    }
    
    @IBAction func division(_ sender: Any) {
        if opTag == 6 {
            if prevOp == 1 {
                result = result - prevN
            }
            if prevOp == 2 {
                result = result + prevN
            }
        } else {
            inner = Double(temp)!
            prevOp = opTag
        }
        opTag = 4
        temp = ""
        textField.text?.append("/")
    }
    @IBAction func percentage(_ sender: Any) {
        textField.text?.append("%")
        let mid = Double(temp)!/100
        if prevOp == 1 {
            result = prevN + inner/mid
        }
        if prevOp == 2 {
            result = prevN - inner/mid
        }
        if floor(result) == result {
            iLabel.text = String(Int(result))
        }else{
            iLabel.text = String(result)
        }
    }
    
    @IBAction func del(_ sender: Any) {
        /*var dText = textField.text!
        dText.remove(at: dText.index(before: dText.endIndex))
        textField.text = dText*/
    }
    
    @IBAction func sqrt(_ sender: Any) {
        prevN = result
        prevOp = opTag
        opTag = 6
        textField.text?.append("√")
    }
    
    @IBAction func bracket(_ sender: UIButton) {
        if sender.tag == 0 {
            brIn = 0.0
            
        }
        if sender.tag == 1{
            cal(opTag)
        }
    }
    @IBAction func equal(_ sender: Any) { //end
        textField.text = iLabel.text
        iLabel.text = ""
        temp = ""
        prevOp = 0
        opTag = 0
        prevN = 0.0
        result = 0.0
        inner = 0.0
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        textField.delegate = self
    }

    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        view.endEditing(true)
    }

}
