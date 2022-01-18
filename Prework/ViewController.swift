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
        
        // retrieve previously stored variable in previous app usage
        let savedBillAmount = UserDefaults.standard.double(forKey: "billAmount")
        let timeOpened = Date()
        
        if let refreshingTime = UserDefaults.standard.object(forKey: "refreshingTime") as? Date {
            if (timeOpened < refreshingTime) {
                billAmount = savedBillAmount
                billAmountTextField.text = String(format: "%.2f", billAmount)
                calculateTip()
            }
        }
    }
    
    // Make the billAmountTextField the first responder
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        billAmountTextField.becomeFirstResponder()
    }
    
    // helper func: calculate and display the correct tip
    func calculateTip() {
        tipAmount = billAmount * tipPercent
        totalAmount = billAmount + tipAmount
        
        // Update Tip Amount Label
        let formatter = NumberFormatter()
        formatter.numberStyle = .currency
        if let formattedTipAmount = formatter.string(from: tipAmount as NSNumber) {
            tipAmountLabel.text = "\(formattedTipAmount)"
        }
        // Update total Amount Label
        if let formattedTotalAmount = formatter.string(from: totalAmount as NSNumber) {
            totalLabel.text = "\(formattedTotalAmount)"
        }
        
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
    
    // override the viewWillDisappear to store information for the next launch
    override func viewDidDisappear(_ animated: Bool) {
        super.viewDidDisappear(animated)
        
        // saving the Bill Amount to default
        UserDefaults.standard.set(billAmount, forKey: "billAmount")
        
        // save the next refreshing time (10 minutes = 600 seconds)
        let nextRefreshingTime = Date().addingTimeInterval(600)
        UserDefaults.standard.set(nextRefreshingTime, forKey: "refreshingTime")
    }
}

