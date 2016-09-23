//
//  ViewController.swift
//  Tipster
//
//  Created by Craig Vargas on 9/22/16.
//  Copyright © 2016 Booker's_Lab. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var tipSlider: UISlider!
    
    @IBOutlet weak var tipPctTopLabel: UILabel!
    
    @IBOutlet weak var tipPctBottomLabel: UILabel!
    
    @IBOutlet weak var tipNotionalLabel: UILabel!
    
    @IBOutlet weak var totalBillLabel: UILabel!
    
    @IBOutlet weak var customerBillField: UITextField!
    
    var isBillFinalized: Bool = true
    
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
        let userTipPct = Int(sender.value)
        tipPctTopLabel.text = "\(userTipPct)%"
        tipPctBottomLabel.text = "\(userTipPct)%"
        
        let userBill = Double(customerBillField.text!) ?? 0
        
        calcTip(userBill, tipPct: userTipPct)
        
//        tipPctTopLabel.text = tipPctBottomLabel.text = String(format: "%d", userTipPct)
    }
    
    //User started typing in text field
    @IBAction func onCustomerBillBeginEditing(sender: UITextField) {
        sender.text = ""
        calcTip(0, tipPct: 0)
    }
    
    //User is typing in Bill text field
    @IBAction func onCustomerBillChanged(sender: UITextField) {
        let userTipPct = Int(tipSlider.value) ?? 0
        let userBill = Double(customerBillField.text!) ?? 0
        
//        customerBillField.text = String(format: "$%.2f", userBill)
        
        calcTip(userBill, tipPct: userTipPct)
    }
    
    //User has finished typing in Bill text field
    @IBAction func onCustomerBillFinalized(sender: UITextField) {
        isBillFinalized = true
        
        let userTipPct = Int(tipSlider.value) ?? 0
        let userBill = Double(customerBillField.text!) ?? 0
        
        customerBillField.text = String(format: "$%.2f", userBill)
        
        calcTip(userBill, tipPct: userTipPct)
    }
    
    func calcTip(bill: Double, tipPct: Int){
        
        let tipNotional = bill * Double(tipPct)/100
        let totalBill = bill + tipNotional
        
        tipNotionalLabel.text = String(format: "$%.2f", tipNotional)
        totalBillLabel.text = String(format: "$%.2f", totalBill)
    }
    
    //Initialize view
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        tipPctTopLabel.text = "\(tipSlider.value)%"
        tipPctBottomLabel.text = "\(tipSlider.value)%"
//        let defaults = NSUserDefaults.standardUserDefaults()
//        let defaultTip = defaults.integerForKey("default_tip")
//        tipSlider.setValue(Float(defaultTip), animated: true)
        print("view will appear")
    }
    
}

