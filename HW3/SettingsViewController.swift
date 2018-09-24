//
//  SettingsViewController.swift
//  HW3
//
//  Created by CIS Student on 9/22/18.
//  Copyright © 2018 Workbook-01. All rights reserved.
//

import UIKit
//protocol used to carry string data backwards
protocol MyProtocol {
    func setLabels(fLabel: String, tLabel: String)
}

class SettingsViewController: UIViewController {
    private let dataSource1 = ["Yards", "Meters", "Miles"]
    private let dataSource2 = ["Liters", "Gallons","Quarts"]
    
    //whatButton == 1 is from button. whatButton == 2 is to Button
    private var whatButton: Int = 0  //used to specify the data source when calling pickerview
    
    //mode == 1 is distance. mode == 2 is volume
    var modeControl: Int = 0 //used to specify the mode the user is in before settings is clicked
    
    var myProtocol: MyProtocol?
 
    @IBOutlet weak var fromLabel: UIButton!
    @IBOutlet weak var toLabel: UIButton!
    
    @IBOutlet weak var pickerView: UIPickerView!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        pickerView.dataSource = self
        pickerView.delegate = self
        pickerView.isHidden = true

        // Do any additional setup after loading the view.
        // make this controller the delegate of the text fields.
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
        if segue.identifier == "segueToCalc" {
            if let destVC = segue.destination.childViewControllers[0] as? CalcViewController {
                destVC.u1 = fromLabel.title(for: .normal)
                destVC.u2 = toLabel.title(for: .normal)
            }
        }
    }
    
    @IBOutlet weak var saveBtn: UIBarButtonItem!
    @IBOutlet weak var cancelBtn: UIBarButtonItem!
    // picker view here?
    
    // Save user choices of top and bottom units and return to the conversion calculator.
    @IBAction func saveBtnPressed(_ sender: Any) {
        if(fromLabel.titleLabel!.text!.isEqual("Unit")) {
            self.dismiss(animated: true, completion: nil)
        }
        else if(toLabel.titleLabel!.text!.isEqual("Unit")) {
            self.dismiss(animated: true, completion: nil)
        }
        else{
            myProtocol?.setLabels(fLabel: fromLabel.titleLabel!.text!, tLabel: toLabel.titleLabel!.text!)
            self.dismiss(animated: true, completion: nil)
        }
        
    }
    //cancels and changes made in settings and returns you to the main page
    @IBAction func cancelButtonPressed(_ sender: Any) {
        self.dismiss(animated: true, completion: nil)
        
    }
    //when the unit button is pressed, show pickerview and specify the button for the pickerview
    @IBAction func fromLabelPressed(_ sender: Any) {
        pickerView.isHidden = false
        whatButton = 1
    }
    //when the unit button is pressed, show pickerview and specify the button for the pickerview
    @IBAction func toLabelPressed(_ sender: Any) {
        pickerView.isHidden = false
        whatButton = 2
    }
    
    
}
//extention is for pickerview and pickerview functions
extension SettingsViewController: UIPickerViewDelegate, UIPickerViewDataSource {
    
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        if(modeControl == 1){
            return dataSource1.count
        }
        if(modeControl == 2){
            return dataSource2.count
        }
        return dataSource1.count
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int,  inComponent component: Int) {
        if (whatButton == 1) {
            if(modeControl == 1){
                fromLabel.setTitle(dataSource1[row], for: UIControlState.normal)
                pickerView.isHidden = true
            }
            if(modeControl == 2){
                fromLabel.setTitle(dataSource2[row], for: UIControlState.normal)
                pickerView.isHidden = true
            }
        }
        if (whatButton == 2) {
            if(modeControl == 1) {
                toLabel.setTitle(dataSource1[row], for: UIControlState.normal)
                pickerView.isHidden = true
            }
            if(modeControl == 2) {
                toLabel.setTitle(dataSource2[row], for: UIControlState.normal)
                pickerView.isHidden = true
            }
        }
    }
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int,  forComponent component: Int) -> String? {
        if(modeControl == 1) {
            return dataSource1[row]
        }
        if(modeControl == 2) {
            return dataSource2[row]
        }
        return dataSource2[row]
    }
}
