//
//  SettingsViewController.swift
//  HW3
//
//  Created by CIS Student on 9/22/18.
//  Copyright © 2018 Workbook-01. All rights reserved.
//

import UIKit

class SettingsViewController: UIViewController {
    
    

    override func viewDidLoad() {
        super.viewDidLoad()

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
            if let destVC = segue.destination.childViewControllers[0] as? SettingsViewController {
                //destVC.
            }
        }
    }
    
    @IBOutlet weak var saveBtn: UIBarButtonItem!
    @IBOutlet weak var cancelBtn: UIBarButtonItem!
    @IBOutlet weak var pickerView: UIPickerView!
    // picker view here?
    
    // Save user choices of top and bottom units and return to the conversion calculator.
    @IBAction func saveBtnPressed(_ sender: Any) {
        
    }
    
}
