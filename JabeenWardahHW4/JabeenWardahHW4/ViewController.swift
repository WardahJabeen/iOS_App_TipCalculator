//
//  ViewController.swift
//  JabeenWardahHW4
//
//  Created by Student on 9/25/22.
//

import UIKit

class ViewController: UIViewController {
    var billAmount_ : Double = 0.0;
    var taxPercent_ : Double = 7.5;
    var taxAmount_ : Double = 0.0;
    var subtotal_ : Double = 0.0;
    var tipValue_ : Double = 0.0;
    var tipPercent_ : Double = 0.0;
    var totalWithTip_ : Double = 0.0;
    var totalSplit_ : Double = 0.0;
    var tipFlag_ : Bool = true;
    var splitNum_ : Int = 0;
    
    @IBOutlet weak var billAmount: UILabel!
    @IBOutlet weak var splitNum: UILabel!
    @IBOutlet weak var taxPercent: UISegmentedControl!
    @IBOutlet weak var tipPercent: UILabel!
    @IBOutlet weak var subtotal: UILabel!
    @IBOutlet weak var tipValue: UILabel!
    @IBOutlet weak var taxAmount: UILabel!
    @IBOutlet weak var totalWithTip: UILabel!
    @IBOutlet weak var totalSplit: UILabel!
    @IBOutlet weak var tipPerentageSlider: UISlider!
    
    @IBOutlet weak var resetButton: UIButton!
    @IBOutlet weak var splitStepper: UIStepper!
    @IBOutlet weak var includeTaxSwitch: UISwitch!
    
    @IBOutlet weak var tipCalculatorLabel: UILabel!
    @IBOutlet weak var billLabel: UILabel!
    @IBOutlet weak var segmentLabel: UILabel!
    
    @IBOutlet weak var includeTaxLabel: UILabel!
    //  @IBOutlet weak var includeTaxLabel: UIButton!
    @IBOutlet weak var evenSplitLabel: UILabel!
    
  //  @IBOutlet var view: UIView!
    //@IBOutlet weak var view: UIView!
    @IBOutlet weak var taxLabel: UILabel!
    @IBOutlet weak var subtotalLabel: UILabel!
    
//    @IBOutlet weak var view: UIView!
    @IBOutlet weak var totalPerPersonLabel: UILabel!
    @IBOutlet weak var totalWithTipLabel: UILabel!
    @IBOutlet weak var tipLabel: UILabel!

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        setDefaultValues()
        billAmount.becomeFirstResponder()
        
        billAmount.accessibilityIdentifier = HW4AccessibilityIdentifiers.billTextField
        taxPercent.accessibilityIdentifier = HW4AccessibilityIdentifiers.segmentedTax
        includeTaxSwitch.accessibilityIdentifier = HW4AccessibilityIdentifiers.includeTaxSwitch
        tipPerentageSlider.accessibilityIdentifier = HW4AccessibilityIdentifiers.tipSlider
        splitStepper.accessibilityIdentifier = HW4AccessibilityIdentifiers.splitStepper
        resetButton.accessibilityIdentifier = HW4AccessibilityIdentifiers.resetButton

        taxAmount.accessibilityIdentifier = HW4AccessibilityIdentifiers.taxAmountLabel
        subtotal.accessibilityIdentifier = HW4AccessibilityIdentifiers.subtotalAmountLabel
        tipValue.accessibilityIdentifier = HW4AccessibilityIdentifiers.tipAmountLabel
        totalWithTip.accessibilityIdentifier = HW4AccessibilityIdentifiers.totalWithTipAmountLabel
        totalSplit.accessibilityIdentifier = HW4AccessibilityIdentifiers.totalPerPersonAmountLabel
        tipPercent.accessibilityIdentifier = HW4AccessibilityIdentifiers.sliderLabel
        splitNum.accessibilityIdentifier = HW4AccessibilityIdentifiers.splitLabel

        tipCalculatorLabel.accessibilityIdentifier = HW4AccessibilityIdentifiers.tipCalculaterLabel
        billLabel.accessibilityIdentifier = HW4AccessibilityIdentifiers.billLabel
        segmentLabel.accessibilityIdentifier = HW4AccessibilityIdentifiers.segmentedLabel
        includeTaxLabel.accessibilityIdentifier = HW4AccessibilityIdentifiers.includeTaxLabel
        evenSplitLabel.accessibilityIdentifier = HW4AccessibilityIdentifiers.evenSplitLabel
        taxLabel.accessibilityIdentifier  = HW4AccessibilityIdentifiers.taxLabel
        subtotalLabel.accessibilityIdentifier = HW4AccessibilityIdentifiers.subtotalLabel
        tipLabel.accessibilityIdentifier = HW4AccessibilityIdentifiers.tipLabel
        totalWithTipLabel.accessibilityIdentifier = HW4AccessibilityIdentifiers.totalWithTipLabel
        totalPerPersonLabel.accessibilityIdentifier = HW4AccessibilityIdentifiers.totalPerPersonLabel

    //    view.accessibilityIdentifier = HW4AccessibilityIdentifiers.view
        
    }

    @IBAction func TipOnOff(_ sender: UISwitch) {
        tipFlag_ = sender.isOn
        updateUI()
    }
    
    @IBAction func BillAmountChanged(_ sender: UITextField) {
        if let value = sender.text {
            if (!value.isEmpty) {
                billAmount_ = Double(value)!
                updateUI()
            }
        }
    }
  
    @IBAction func TipSlider(_ sender: UISlider) {
      
        tipPercent_ = Double(sender.value)
        print(tipPercent_)

        updateUI()
    }
    
    @IBAction func TipStepper(_ sender: UIStepper) {
//        print("\(Int(sender.value + 0.5))")
        splitNum_ = Int(sender.value)
        print(splitNum_)
        updateUI()
    }
  
    
    @IBAction func BackgroundButton(_ sender: UIButton) {
        billAmount.resignFirstResponder()
    }
    
    
    @IBAction func BackgroundButtonInnerView1(_ sender: Any) {
        billAmount.resignFirstResponder()
    }
    @IBAction func BackgroundButtonInnerView2(_ sender: UIButton) {
        billAmount.resignFirstResponder()
    }
    @IBAction func TaxSelector(_ sender: UISegmentedControl) {
        let index = sender.selectedSegmentIndex
        taxPercent_ = Double(sender.titleForSegment(at: index)!)!
        updateUI()
    }
  
    @IBAction func ClearAllDidTapped(_ sender: UIButton) {
        clearAll()
    }
    
    func clearAll(){
        let alert = UIAlertController(title:"Alert", message: "Are you sure you want to clear all", preferredStyle: .alert)
        let yesAction = UIAlertAction(title: "Yes", style: .default, handler: {action in    self.setDefaultValues()
            self.updateLabels()
            self.billAmount.text = ""
            self.taxPercent.selectedSegmentIndex = 0
            self.includeTaxSwitch.isOn = true
            self.tipPerentageSlider.value = 0
            
        })
        let cancelAction = UIAlertAction(title: "Cancel", style: .destructive)
        alert.addAction(yesAction)
        alert.addAction(cancelAction)
        present(alert, animated: true)
        
    }
    
    func setDefaultValues() {
        billAmount_ = 0.00;
        taxPercent_ = 7.5;
        taxAmount_ = 0.00;
        subtotal_ = 0.00;
        tipValue_ = 0.00;
        tipPercent_ = 0.00;
        totalWithTip_ = 0.00;
        totalSplit_ = 0.00;
        tipFlag_ = true;
        splitNum_ = 1;
        
        
    }
    
    func updateUI(){
        calculations()
        updateLabels()
        
    }
    func calculations() {
        let percent = 0.01
        taxAmount_ = (billAmount_ * taxPercent_) * percent
        if (tipFlag_) {
            subtotal_ = billAmount_ + taxAmount_
        }
        else {
            subtotal_ = billAmount_
        }
        
        tipValue_ = subtotal_ * tipPercent_ * percent
        totalWithTip_ = billAmount_ + taxAmount_ + tipValue_
        totalSplit_ = totalWithTip_ / Double(splitNum_)
    }
    
    func updateLabels(){
        splitNum.text = "\(splitNum_)"
        tipPercent.text = "\(Int(tipPercent_)) %"
        
        tipValue!.text = String(format: "$%.2f", tipValue_)
        subtotal.text! = String(format:  "$%.2f", subtotal_)
      
  
        taxAmount.text! = String(format: "$%.2f", taxAmount_)
        totalWithTip.text! = String(format: "$%.2f", totalWithTip_)
        totalSplit.text! = String(format: "$%.2f", totalSplit_)
    }
    
  
    
}

