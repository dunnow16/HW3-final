//
//  CalcViewController.swift
//  HW3
//
//  Created by Owen Dunn and Brandon Griggs on 9/17/18.
//  Copyright © 2018 Workbook-01. All rights reserved.
//

import UIKit

class CalcViewController: UIViewController, MyProtocol {

    var mode: String? = CalculatorMode.Length.rawValue  // initialize to length
    var u1: String?, u2: String?  // the two units: top, bottom
    var modeHold: Int = 1
    
    @IBOutlet weak var topInput: DecimalMinusTextField!
    @IBOutlet weak var bottomInput: DecimalMinusTextField!
    @IBOutlet weak var topUnit: UILabel!
    @IBOutlet weak var bottomUnit: UILabel!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        // dismiss keyboard when tapping outside oftext fields
        let detectTouch = UITapGestureRecognizer(target: self, action:
            #selector(self.dismissKeyboard))
        self.view.addGestureRecognizer(detectTouch)
        
        // make this controller the delegate of the text fields.
        self.topInput.delegate = self
        self.bottomInput.delegate = self
        //self.topUnit.delegate = self
        //self.bottomUnit.delegate = self
        
        self.topUnit.text = LengthUnit.Yards.rawValue
        self.bottomUnit.text = LengthUnit.Meters.rawValue
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
    @IBOutlet weak var modeBtn: UIButton!
    
    @IBAction func calcBtnPressed(_ sender: Any) {
        if self.topInput.text == "" && self.bottomInput.text != "" {  // calc bottom equivalent
            // use length or volume key
            if mode! == CalculatorMode.Length.rawValue {
                let top = LengthUnit(rawValue: self.topUnit.text!)
                let bottom = LengthUnit(rawValue: self.bottomUnit.text!)
                let convKey = LengthConversionKey(toUnits: top!,
                                                  fromUnits: bottom!)
                let bottomDouble = Double(self.bottomInput.text!)
                let toVal = bottomDouble! * lengthConversionTable[convKey]!
                self.topInput.text = String(toVal)
            } else if mode! == CalculatorMode.Volume.rawValue {
                let top = VolumeUnit(rawValue: self.topUnit.text!)
                let bottom = VolumeUnit(rawValue: self.bottomUnit.text!)
                let convKey = VolumeConversionKey(toUnits: top!,
                                                  fromUnits: bottom!)
                let bottomDouble = Double(self.bottomInput.text!)
                let toVal = bottomDouble! * volumeConversionTable[convKey]!
                self.topInput.text = String(toVal)
            } else {
                print("ERROR! Mode should be Length or Volume only.")
                // exit
            }
        } else if self.bottomInput.text == "" && self.topInput.text != "" {  // calc top equivalent
            if mode! == CalculatorMode.Length.rawValue {
                let top = LengthUnit(rawValue: self.topUnit.text!)
                let bottom = LengthUnit(rawValue: self.bottomUnit.text!)
                let convKey = LengthConversionKey(toUnits: bottom!,
                                                  fromUnits: top!)
                let topDouble = Double(self.topInput.text!)
                let toVal = topDouble! * lengthConversionTable[convKey]!
                self.bottomInput.text = String(toVal)
            } else if mode! == CalculatorMode.Volume.rawValue {
                let top = VolumeUnit(rawValue: self.topUnit.text!)
                let bottom = VolumeUnit(rawValue: self.bottomUnit.text!)
                let convKey = VolumeConversionKey(toUnits: bottom!,
                                                  fromUnits: top!)
                let topDouble = Double(self.topInput.text!)
                let toVal = topDouble! * volumeConversionTable[convKey]!
                self.bottomInput.text = String(toVal)
            } else {
                print("ERROR! Mode should be Length or Volume only.")
                // exit
            }
        } else {
            print("No value entered or both fields filled!")
            self.topInput.text = ""
            self.bottomInput.text = ""
        }
        dismissKeyboard()
        topInput.doneTouchUpInside(calcBtn!)  // have text field lose focus (unwrap button?)
    }
    
    @IBAction func clearBtnPressed(_ sender: Any) {
        self.topInput.text = ""
        self.bottomInput.text = ""
        dismissKeyboard()
        topInput.doneTouchUpInside(clearBtn!) // have text field lose focus (unwrap button?)
    }
    
    // Toggle between length and volume conversions.
    @IBAction func modeBtnPressed(_ sender: Any) {
        if mode! == CalculatorMode.Length.rawValue {
            modeHold = 2
            mode = CalculatorMode.Volume.rawValue
            topUnit.text = VolumeUnit.Gallons.rawValue
            bottomUnit.text = VolumeUnit.Liters.rawValue
        } else if mode! == CalculatorMode.Volume.rawValue {
            modeHold = 1
            mode = CalculatorMode.Length.rawValue
            topUnit.text = LengthUnit.Yards.rawValue
            bottomUnit.text = LengthUnit.Meters.rawValue
        } else {
            print("ERROR! Mode should be Length or Volume only.")
            // exit
        }
        // Clear old data and go back to starting state.
        self.topInput.text = ""
        self.bottomInput.text = ""
        dismissKeyboard()
        topInput.doneTouchUpInside(modeBtn!) // have text field lose focus (unwrap button?)
    }
    
    // UIKit calls whenever segue. This might go on settings controller instead to save changes. (or too?)
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "segueToSettings" {
            if let destVC = segue.destination.childViewControllers[0] as? SettingsViewController {
                destVC.modeControl = modeHold
                destVC.myProtocol = self
            }
        }
    }
    func setLabels(fLabel: String, tLabel: String){
        topUnit.text = fLabel
        bottomUnit.text = tLabel
    }

}

extension CalcViewController : UITextFieldDelegate {
    // This function clears the other text field when input begins. The controller must
    // be the delegate of the text fields for this to be called.
    func textFieldDidBeginEditing(_ textField: UITextField) {
        if textField == self.topInput {
            self.bottomInput.text = ""
        } else if textField == self.bottomInput {
            self.topInput.text = ""
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
