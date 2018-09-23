//
//  ViewController.swift
//  HW3
//
//  Created by Owen Dunn and Brandon Griggs on 9/17/18.
//  Copyright © 2018 Workbook-01. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var yardsInput: DecimalMinusTextField!
    @IBOutlet weak var metersInput: DecimalMinusTextField!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        // dismiss keyboard when tapping outside oftext fields
        let detectTouch = UITapGestureRecognizer(target: self, action:
            #selector(self.dismissKeyboard))
        self.view.addGestureRecognizer(detectTouch)
        
        // make this controller the delegate of the text fields.
        self.yardsInput.delegate = self
        self.metersInput.delegate = self
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @objc func dismissKeyboard() {
        self.view.endEditing(true)
    }

    @IBOutlet weak var calcBtn: UIButton!
    @IBOutlet weak var clearBtn: UIButton!
    
    @IBAction func calcBtnPressed(_ sender: Any) {
        if self.yardsInput.text == "" && self.metersInput.text != "" {  // calc meters
            let metersDouble = Double(self.metersInput.text!)
            self.yardsInput.text = String(metersDouble! * 1.09361)
        } else if self.metersInput.text == "" && self.yardsInput.text != "" {  // calc yard
            let yardsDouble = Double(self.yardsInput.text!)
            self.metersInput.text = String(yardsDouble! * 0.9144)
        } else {
            print("No value entered or both fields filled!")
            self.yardsInput.text = ""
            self.metersInput.text = ""
        }
        dismissKeyboard()
        yardsInput.doneTouchUpInside(calcBtn!)  // have text field lose focus
    }
    
    @IBAction func clearBtnPressed(_ sender: Any) {
        self.yardsInput.text = ""
        self.metersInput.text = ""
        dismissKeyboard()
        yardsInput.doneTouchUpInside(clearBtn) // have text field lose focus
    }
    
}

extension ViewController : UITextFieldDelegate {
    // This function clears the other text field when input begins. The controller must
    // be the delegate of the text fields for this to be called.
    func textFieldDidBeginEditing(_ textField: UITextField) {
        if textField == self.yardsInput {
            self.metersInput.text = ""
        } else if textField == self.metersInput {
            self.yardsInput.text = ""
        }
    }
//    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
//        if textField == self.yardsInput {
//            self.passwordField.becomeFirstResponder()
//        } else {
//            if self.validateFields() {
//                print(NSLocalizedString("Congratulations! You entered correct values.", comment: ""))
//            }
//        }
//        return true
//    }
}
