import UIKit

class ViewController: UIViewController, UITextFieldDelegate {
    var opArray: [Int] = []
    var numArray: [Double] = []
    
    var new = true
    var ind = 0
    var indO = 0
    var temp = ""
    var res = 0.0
    var change = false
    var mid = 0.0
    var delC = 0
    var d = false
    var p = false
    var pIn = 0.0
    var pCount = 0
    
    @IBOutlet var Eq: UITextField!
    @IBOutlet weak var rLabel: UILabel!
    
    func display() {
        var t = ""
        if floor(res) == res {
            t = "\(Int(res))"
        } else {
            t = "\(res)"
        }
        if res == 0.0 {
            if temp != "" {
                t = "\(temp)"
            }
        }
        if t.count >= 10{
            rLabel.text = String(t.prefix(10))
        } else {
            rLabel.text = String(t)
        }
    }
    
    func calcIn() {
        ind = numArray.count
        if opArray[indO - 2] == 1 {
            if p {
                if pIn != 0.0 {
                    pIn += numArray[ind - 1]
                } else {
                    pIn = numArray[ind - 2] + numArray[ind - 1]
                }
            } else {
                res = numArray[ind - 2] + numArray[ind - 1]
                numArray.removeLast(2)
                numArray.insert(res, at: ind - 2)
                opArray.removeLast()
            }
        } else if opArray[indO - 2] == 2{
            if p {
                if pIn != 0.0 {
                    pIn -= numArray[ind - 1]
                } else {
                    pIn = numArray[ind - 2] - numArray[ind - 1]
                }
            } else {
                res = numArray[ind - 2] - numArray[ind - 1]
            }
        } else if opArray[indO - 2] == 3 { //
            if p {
                pIn = numArray[ind - 2] * numArray[ind - 1]
            } else {
                res = numArray[ind - 2] * numArray[ind - 1]
            }
        } else {
            if p {
                pIn = numArray[ind - 2] / numArray[ind - 1]
            } else {
                res = numArray[ind - 2] / numArray[ind - 1]
            }
        }
        display()
    }
    
    func calc() {
        indO = opArray.count
        ind = numArray.count
        switch opArray[indO - 1] {
        case 1:
            if res == 0.0 {
                res = numArray[ind - 2] + numArray[ind - 1]
            } else if (p && pCount > 1){
                if pIn == 0.0 {
                    pIn = numArray[ind - 2] + numArray[ind - 1]
                } else {
                    pIn += numArray[ind - 1]
                }
            } else {
                if change {
                    res = numArray[ind - 2] + numArray[ind - 1]
                } else {
                    res += numArray[ind - 1]
                }
            }
        case 2:
            if res == 0.0 {
                res = numArray[ind - 2] - numArray[ind - 1]
            } else if (p && pCount > 1){
                if pIn == 0.0 {
                    pIn = numArray[ind - 2] - numArray[ind - 1]
                } else {
                    pIn -= numArray[ind - 1]
                }
            } else {
                if change {
                    res = numArray[ind - 2] - numArray[ind - 1]
                } else {
                    res -= numArray[ind - 1]
                }
            }
        case 3:
            if res == 0.0 {
                res = numArray[ind - 2] * numArray[ind - 1]
            } else if (p && pCount > 1){
                if pIn == 0.0 {
                    pIn = numArray[ind - 2] * numArray[ind - 1]
                } else {
                    mid = numArray[ind - 2] * numArray[ind - 1]
                    calcIn()
                }
            } else {
                mid = numArray[ind - 2] * numArray[ind - 1]
                numArray.removeLast(2)
                numArray.insert(mid, at: ind - 2)
                calcIn()
            }
        case 4:
            if res == 0.0 {
                res = numArray[ind - 2] / numArray[ind - 1]
            } else if (p && pCount > 1){
                if pIn == 0.0 {
                    pIn = numArray[ind - 2] / numArray[ind - 1]
                } else {
                    mid = numArray[ind - 2] / numArray[ind - 1]
                    calcIn()
                }
            } else {
                if change {
                    res = numArray[ind - 2] / numArray[ind - 1]
                } else {
                    mid = numArray[ind - 2] / numArray[ind - 1]
                    numArray.removeLast()
                    numArray.insert(mid, at: ind - 1)
                    calcIn()
                }
            }
        case 5:
            mid = numArray[ind - 1].squareRoot()
            if res == 0.0 {
                if opArray.count > 0 {
                    numArray.removeLast()
                    numArray.insert(mid, at: ind - 1)
                    opArray.removeLast()
                    calc()
                } else {
                    res = mid
                    opArray.removeLast()
                }
            } else {
                numArray.removeLast()
                numArray.insert(mid, at: ind - 1)
                opArray.removeLast()
                calcIn()
            }
        case 6:
            if res == 0.0 {
                res = pow(numArray[ind - 2], numArray[ind - 1])
                numArray.removeLast(2)
                numArray.insert(res, at: ind - 2)
            } else {
                mid = pow(numArray[ind - 2], numArray[ind - 1])
                numArray.removeLast(2)
                numArray.insert(mid, at: ind - 2)
            }
        default:
            return
        }
        if p {
            pCount += 1
        }
        display()
    }
    
    func changes(){
        temp = ""
        numArray = []
        opArray = []
        res = 0.0
        new = true
        let store = Array(Eq.text!)
        for i in 0..<store.count {
            if store[i].isNumber {
                if new == true {
                    temp = "\(store[i])"
                    numArray.insert(Double(temp)!, at: 0)
                    new = false
                    change = false
                } else {
                    if temp != "" {
                        temp += String(store[i])
                        ind = numArray.count
                        numArray.removeLast()
                        numArray.insert(Double(temp)!, at: ind - 1)
                        change = true
                    } else {
                        temp = "\(store[i])"
                        ind = numArray.count
                        numArray.insert(Double(temp)!, at: ind)
                        change = false
                    }
                }
            } else {
                indO = opArray.count
                if store[i] == "+" {
                    opArray.insert(1, at: indO)
                    temp = ""
                    //if indO - 1 > 0 {
                    //    M = res
                    //}
                } else if store[i] == "-" {
                    opArray.insert(2, at: indO)
                    temp = ""
                    //if indO - 1 > 0 {
                    //    M = res
                    //}
                } else if store[i] == "x" {
                    opArray.insert(3, at: indO)
                    temp = ""
                } else if store[i] == "/" {
                    opArray.insert(4, at: indO)
                    temp = ""
                } else if store[i] == "." {
                    temp += "."
                    numArray.removeLast()
                    numArray.insert(Double(temp)!, at: ind - 1)
                    change = true
                } else if store[i] == "π" {
                    ind = numArray.count
                    if temp != "" {
                        numArray.insert(3.14159265, at: ind)
                        opArray.insert(3, at: indO)
                        change = false
                        calc()
                    } else {
                        numArray.insert(3.14159265, at: ind)
                        change = false
                    }
                } else if store[i] == "%" {
                    if temp != "" {
                        ind = numArray.count
                        if ind == 1 {
                            res = Double(temp)!/100
                        } else {
                            if opArray[indO - 1] == 4 {
                                mid = numArray[ind - 2] / (numArray[ind - 1]/100)
                                numArray.removeLast(2)
                                numArray.insert(mid, at: ind - 2)
                            }
                            if opArray[indO - 1] == 3{
                                mid = numArray[ind - 2] * (numArray[ind - 1]/100)
                                numArray.removeLast(2)
                                numArray.insert(mid, at: ind - 2)
                            }
                            if opArray[indO - 1] == 2{
                                mid = numArray[ind - 2] - (numArray[ind - 1]/100)
                                numArray.removeLast(2)
                                numArray.insert(mid, at: ind - 2)
                            }
                            if opArray[indO - 1] == 1{
                                mid = numArray[ind - 2] + (numArray[ind - 1]/100)
                                numArray.removeLast(2)
                                numArray.insert(mid, at: ind - 2)
                            }
                            calcIn()
                        }
                    } else {
                        let alert = UIAlertController(title: "Data Validation Error", message: "Invalid Input", preferredStyle: UIAlertController.Style.alert)
                        alert.addAction(UIAlertAction(title: "Close", style: .default, handler: { (action: UIAlertAction!) in print("Data Validation Checking Completed") } ))
                        Eq.text = ""
                        present(alert, animated: true, completion: nil)
                    }
                } else if store[i] == "(" {
                    p = true
                    pCount = 0
                    opArray.insert(7, at: indO)
                    if temp != "" {
                        opArray.insert(3, at: indO-1)
                    }
                    if opArray[indO - 1] < 3 {
                        numArray.removeAll()
                        numArray.insert(res, at: 0)
                        let mid = opArray[indO - 1]
                        opArray.removeAll()
                        opArray.insert(mid, at: 0)
                    }
                } else if store[i] == ")"{
                    if !p {
                        let alert = UIAlertController(title: "Data Validation Error", message: "Invalid Input", preferredStyle: UIAlertController.Style.alert)
                        alert.addAction(UIAlertAction(title: "Close", style: .default, handler: { (action: UIAlertAction!) in print("Data Validation Checking Completed")}))
                        Eq.text = ""
                        present(alert, animated: true, completion: nil)
                    } else {
                        p = false
                        ind = numArray.count
                        numArray.removeLast(ind - 2)
                        numArray.insert(pIn, at: 1)
                        opArray.removeLast(ind - 2)
                        calcIn()
                    }
                } else if store[i] == "√" {
                    if temp == "" {
                        opArray.insert(5, at: indO)
                    } else {
                        let alert = UIAlertController(title: "Data Validation Error", message: "Invalid Input", preferredStyle: UIAlertController.Style.alert)
                        alert.addAction(UIAlertAction(title: "Close", style: .default, handler: { (action: UIAlertAction!) in print("Data Validation Checking Completed")}))
                        Eq.text = ""
                        present(alert, animated: true, completion: nil)
                    }
                } else if store[i] == "^" {
                    if temp != "" {
                        opArray.insert(6, at: indO)
                        temp = ""
                    } else {
                        let alert = UIAlertController(title: "Data Validation Error", message: "Invalid Input", preferredStyle: UIAlertController.Style.alert)
                        alert.addAction(UIAlertAction(title: "Close", style: .default, handler: { (action: UIAlertAction!) in print("Data Validation Checking Completed")}))
                        Eq.text = ""
                        present(alert, animated: true, completion: nil)
                    }
                } else {
                    let alert = UIAlertController(title: "Data Validation Error", message: "Invalid Input", preferredStyle: UIAlertController.Style.alert)
                    alert.addAction(UIAlertAction(title: "Close", style: .default, handler: { (action: UIAlertAction!) in print("Data Validation Checking Completed")}))
                    Eq.text = ""
                    present(alert, animated: true, completion: nil)
                }
            }
            if (opArray.count > 0 && store[i].isNumber) {
                calc()
            }
        }
        print("A")
         print("num: \(numArray)")
         print("opA: \(opArray)")
         print("pIn: \(pIn)")
         print("res: \(res)")
         print("mid: \(mid)")
         print("\n")
        display()
    }
           
    
    @IBAction func edited(_ sender: Any) {
        d = false
        delC = 0
        changes()
    }
   
    @IBAction func num(_ sender: UIButton) {
        d = false
        delC = 0
        if new == true {
            if sender.tag < 10 {
                temp = "\(sender.tag)"
                Eq.text = String(temp)
                new = false
            } else {
                temp = "0."
                Eq.text = temp
                new = false
            }
        } else {
            if sender.tag < 10 {
                Eq.text?.append(String(sender.tag))
            } else {
                Eq.text?.append(".")
            }
        }
        changes()
    }
    
    @IBAction func operation(_ sender: UIButton) {
        d = false
        delC = 0
        switch (sender.tag) {
        case 1:
            Eq.text?.append("+")
        case 2:
            Eq.text?.append("-")
        case 3:
            Eq.text?.append("x")
        case 4:
            Eq.text?.append("/")
        case 5: //
            Eq.text?.append("(")
        case 6: //
            Eq.text?.append(")")
        default:
            return
        }
        changes()
    }
    
    @IBAction func del(_ sender: Any) {
        var t = Eq.text!
        d = true
        if Eq.text?.count == 1 || delC > 1{
            Eq.text = ""
            rLabel.text = ""
            temp = ""
            res = 0.0
            change = false
            mid = 0.0
            //M = 0.0
            p = false
            pIn = 0.0
            delC = 0
            d = false
        }else{
            t.remove(at: t.index(before: t.endIndex))
            Eq.text = t
            if temp.count != 0 {
                temp.remove(at: temp.index(before: temp.endIndex))
            }
            changes()
            delC += 1
        }
    }
    
    @IBAction func Equal(_ sender: Any) {
        temp = ""
        Eq.text = rLabel.text
        rLabel.text = ""
        new = true
        d = false
        delC = 0
    }
    
    @IBAction func percent(_ sender: Any) { //
        d = false
        delC = 0
        Eq.text?.append("%")
        changes()
    }
    
    @IBAction func sqrt(_ sender: Any) {
        d = false
        delC = 0
        Eq.text?.append("√")
    }
    
    @IBAction func power(_ sender: Any) {
        d = false
        delC = 0
        Eq.text?.append("^")
    }
    
    @IBAction func pi(_ sender: Any) {
        d = false
        delC = 0
        Eq.text?.append("π")
        changes()
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return false
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        view.endEditing(true)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        Eq.delegate = self
    }
}

