//
//  ViewController.swift
//  Tipster
//
//  Created by Craig Vargas on 9/22/16.
//  Copyright © 2016 Booker's_Lab. All rights reserved.
//

import UIKit

class ViewController: UIViewController, UITextFieldDelegate {

    @IBOutlet weak var userControlsView: UIView!
    
    @IBOutlet weak var tipSlider: UISlider!
    
    @IBOutlet weak var tipPctTopLabel: UILabel!
    
    @IBOutlet weak var tipPctBottomLabel: UILabel!
    
    @IBOutlet weak var tipNotionalLabel: UILabel!
    
    @IBOutlet weak var totalBillLabel: UILabel!
    
    @IBOutlet weak var customerBillField: UITextField!
    
    var billIsFinalized: Bool = true
    var appIsAlreadyRunning: Bool = false
    
    var currencyFormatter = NSNumberFormatter()
    var billFormatter = NSNumberFormatter()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    @IBAction func onTapAction(sender: AnyObject) {
        view.endEditing(true)
    }

    @IBAction func onTipPctChanged(sender: UISlider) {
        updateUi()
    }
    
    //User started typing in text field
    @IBAction func onCustomerBillBeginEditing(sender: UITextField) {
        billIsFinalized=false
        sender.text = ""
        updateUi()
    }
    
    //User is typing in Bill text field
    @IBAction func onCustomerBillChanged(sender: UITextField) {
        billIsFinalized=false
        updateUi()
    }
    
    //User has finished typing in Bill text field
    @IBAction func onCustomerBillFinalized(sender: UITextField) {
        billIsFinalized=true
        updateUi()
    }
    
    func calcTip(bill: Double, tipPct: Int){
        let tipNotional = bill * Double(tipPct)/100
        let totalBill = bill + tipNotional
        
        tipNotionalLabel.text = String(format: "$%.2f", tipNotional)
        totalBillLabel.text = String(format: "$%.2f", totalBill)
    }
    
    func updateUi(){
        let userTipPct = Int(tipSlider.value)
        let stringBill = customerBillField.text!
        let userBill = formatBillToDouble(stringBill)
        
        let tipNotional = userBill * Double(userTipPct)/100
        let totalBill = userBill + tipNotional
        
        tipNotionalLabel.text = currencyFormatter.stringFromNumber(tipNotional)
        totalBillLabel.text = currencyFormatter.stringFromNumber(totalBill)
        tipPctTopLabel.text = "\(userTipPct)%"
        tipPctBottomLabel.text = "\(userTipPct)%"
        if billIsFinalized{
            var formattedBill = ""
            billFormatter.numberStyle = NSNumberFormatterStyle.CurrencyStyle
            formattedBill = billFormatter.stringFromNumber(userBill)!
            customerBillField.text = formattedBill
        }
    }
    
    func formatBillToDouble(bill: String) -> Double {
        if bill == ""{return 0}
        print("formatBillToDouble: \(billFormatter.numberFromString(bill))")

        if bill[bill.startIndex] == "$"{
            return Double(currencyFormatter.numberFromString(bill)!)
        }else{
            return Double(bill) ?? 0
        }
    }
    
    //Initialize view
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        
        userControlsView.layer.cornerRadius = 10
        userControlsView.layer.masksToBounds = true
        
        let defaults = NSUserDefaults.standardUserDefaults()
        let defaultTip = defaults.integerForKey("default_tip")
        tipSlider.setValue(Float(defaultTip), animated: true)
        billIsFinalized=false
        updateUi()
    }
    
    //Initialize view part 2
    override func viewDidAppear(animated: Bool) {
        super.viewDidAppear(animated)
        billFormatter.numberStyle = NSNumberFormatterStyle.CurrencyStyle
        currencyFormatter.numberStyle = NSNumberFormatterStyle.CurrencyStyle
        if appIsAlreadyRunning{
            
        }else{
            //App has just started so make text field first responder
            //Tell the program that the app is already running
            customerBillField.delegate = self
            customerBillField.becomeFirstResponder()
            appIsAlreadyRunning = true
        }
    }
    
    override func viewWillDisappear(animated: Bool) {
        super.viewWillDisappear(animated)
    }
    
}

