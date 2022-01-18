//
//  ViewController.swift
//  Prework
//
//  Created by Ruihang(Henry) Liu on 1/17/22.
//

import UIKit

class ViewController: UIViewController {

    // Constants
    let tipOptions = [0.15, 0.18, 0.2]
    
    // variables:
    var billAmount = 0.0
    var tipPercent = 0.15
    var tipAmount = 0.0
    var totalAmount = 0.0
    
    // View Outlets:
    @IBOutlet weak var popularTipSelection: UIView!
    @IBOutlet weak var customTipSelection: UIView!
    @IBOutlet weak var selectionViewControl: UISegmentedControl!
    
    // Outlets:
    @IBOutlet weak var billAmountTextField: UITextField!
    @IBOutlet weak var tipAmountLabel: UILabel!
    @IBOutlet weak var tipControl: UISegmentedControl!
    @IBOutlet weak var totalLabel: UILabel!
    @IBOutlet weak var tipSlider: UISlider!
    @IBOutlet weak var tipPercentage: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        changeViewSelection(selectionViewControl as Any)
    }
    
    // helper func: calculate and display the correct tip
    func calculateTip() {
        tipAmount = billAmount * tipPercent
        totalAmount = billAmount + tipAmount
        
        // Update Tip Amount Label
        tipAmountLabel.text = String(format: "$%.2f", tipAmount)
        totalLabel.text = String(format: "$%.2f", totalAmount)
        
        // Update the Label width according to the contents
        tipAmountLabel.sizeToFit()
        totalLabel.sizeToFit()
    }
    
    @IBAction func changeViewSelection(_ sender: Any) {
        if (selectionViewControl.selectedSegmentIndex == 0) {
            popularTipSelection.isHidden = false
            customTipSelection.isHidden = true
            tipControl.selectedSegmentIndex = 0
            tipPercent = tipOptions[0]
            calculateTip()
        } else {
            popularTipSelection.isHidden = true
            customTipSelection.isHidden = false
            tipSlider.value = Float(tipPercent)
            tipPercentage.text = String(format: "%d", Int(tipPercent*100))
            tipPercentage.sizeToFit()
        }
    }
    
    
    @IBAction func updateBill(_ sender: Any) {
        billAmount = Double(billAmountTextField.text!) ?? 0
        calculateTip()
    }
    
    @IBAction func sliderUpdate(_ sender: Any) {
        // update the variable
        tipPercent = Double(tipSlider.value)
        // keep only two decimal place
        print("tipPercent from slider: ", tipPercent)
        tipPercent = round(tipPercent * 100) / 100.0
        print("tipPercent after convert: ", tipPercent)
        
        tipPercentage.text = String(format: "%d", Int(tipPercent*100))
        tipPercentage.sizeToFit()
        
        calculateTip()
    }
    
    @IBAction func tipPercentageUpdate(_ sender: Any) {
        tipPercent = Double(Int(tipPercentage.text!) ?? 0) / 100
        tipSlider.value = Float(tipPercent)
        calculateTip()
    }
    
    @IBAction func tipSelection(_ sender: Any) {
        // Get Total tip by multiplying tip * tipPercentage
        tipPercent =  tipOptions[tipControl.selectedSegmentIndex]
        
        calculateTip()
    }
}

