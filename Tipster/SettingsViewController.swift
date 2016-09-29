//
//  SettingsViewController.swift
//  Tipster
//
//  Created by Craig Vargas on 9/23/16.
//  Copyright © 2016 Booker's_Lab. All rights reserved.
//

import UIKit

class SettingsViewController:
    UIViewController,
    UIPickerViewDataSource,
    UIPickerViewDelegate{
    
    @IBOutlet weak var tipDefaultPicker: UIPickerView!
    
    @IBOutlet weak var defaultTipLabel: UILabel!
    
    @IBOutlet weak var styleSwitch: UISwitch!
    
    @IBOutlet weak var settingsView: UIView!
    
    @IBOutlet weak var draculaImage: UIImageView!
    
    var defaultTip: Int = 0
    var defaultTipHundreds: Int = 0
    var defaultTipTens: Int = 0
    var defaultTipOnes: Int = 0
    
    var tipPickerArray = [
        ["0","1"],
        ["0", "1", "2", "3", "4", "5", "6", "7", "8", "9"],
        ["0", "1", "2", "3", "4", "5", "6", "7", "8", "9"]
        ]
    //[0, 1, 2, 3, 4, 5, 6, 7, 8, 9]
    
    static let defaultTipKey = "default_tip"
    static let draculaModeSettingKey = "dracula_mode"
    
//    struct tipsterColors {
    //Outer Space: #424B54
    static let draculaPrimary =
    UIColor(red: 0x42 / 0xFF, green: 0x4B / 0xFF, blue: 0x54 / 0xFF, alpha: 0xFF / 0xFF)
    
    //Medium Purple: #8E83F5
    static let draculaSecondary =
    UIColor(red: 0x8E / 0xFF, green: 0x83 / 0xFF, blue: 0xF5 / 0xFF, alpha: 0xFF / 0xFF)
    
    //Medium Spring Green: #00F0B5
    static let draculaAccent =
    UIColor(red: 0x00 / 0xFF, green: 0xF0 / 0xFF, blue: 0xB5 / 0xFF, alpha: 0xFF / 0xFF)
    
    
    //Dodger Blue: #2196F3
    static let tipsterPrimary =
    UIColor(red: 0x21 / 0xFF, green: 0x96 / 0xFF, blue: 0xF3 / 0xFF, alpha: 0xFF / 0xFF)
    
    //Sunset Orange: #FF5656
    static let tipsterSecondary =
    UIColor(red: 0xFF / 0xFF, green: 0x56 / 0xFF, blue: 0x56 / 0xFF, alpha: 0xFF / 0xFF)
    
    //Radical Red: #FF3366
    static let tipsterAccent2 =
    UIColor(red: 0xFF / 0xFF, green: 0x33 / 0xFF, blue: 0x66 / 0xFF, alpha: 0xFF / 0xFF)
    
    //Lemon Glacier: #F2FF00
    static let tipsterAccent =
    UIColor(red: 0xF2 / 0xFF, green: 0xFF / 0xFF, blue: 0x00 / 0xFF, alpha: 0xFF / 0xFF)
//    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.tipDefaultPicker.dataSource = self;
        self.tipDefaultPicker.delegate = self;

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */
    
    func numberOfComponentsInPickerView(pickerView: UIPickerView) -> Int {
        return 3
    }
    
    func pickerView(pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return tipPickerArray[component].count;
    }
    
    func pickerView(pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return tipPickerArray[component][row]
    }
    
    func pickerView(pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int)
    {
        switch component {
        case 0:
            defaultTipHundreds = (Int(tipPickerArray[component][row])! ?? 0) * 100
            print("switch hundreds: \(defaultTipHundreds)")
            break
        case 1:
            defaultTipTens = (Int(tipPickerArray[component][row])! ?? 0) * 10
            print("switch tens: \(defaultTipTens)")
            break
        case 2:
            defaultTipOnes = (Int(tipPickerArray[component][row])! ?? 0) * 1
            print("switch ones: \(defaultTipOnes)")
            break
        default:
            break
        }
        printEachDigit();
        defaultTip = defaultTipHundreds + defaultTipTens + defaultTipOnes
        if defaultTip > 100 {
            defaultTip = 100
        }
        defaultTipLabel.text = "\(defaultTip)%"
        print("Inside user picked pickerview. DefaultTip = \(defaultTip)")
    }
    
    func pickerView(pickerView: UIPickerView, attributedTitleForRow row: Int, forComponent component: Int) -> NSAttributedString? {
        let titleData = tipPickerArray[component][row]
        let myTitle = NSAttributedString(string: titleData, attributes: [NSFontAttributeName:UIFont(name: "Georgia", size: 15.0)!,NSForegroundColorAttributeName:UIColor.whiteColor()])
        return myTitle
    }
    
    func printEachDigit(){
        print("\(defaultTipHundreds), \(defaultTipTens), \(defaultTipOnes)")
    }
    
    func saveDefault(){
        let defaults = NSUserDefaults.standardUserDefaults()
        defaults.setInteger(
            defaultTip,
            forKey: SettingsViewController.defaultTipKey)
        defaults.setBool(
            styleSwitch.on,
            forKey: SettingsViewController.draculaModeSettingKey)
        defaults.synchronize()
    }
    
    
    @IBAction func onStyleSwitchValueChanged(sender: UISwitch) {
        let draculaModeIsOn = styleSwitch.on
        updateUiStyle(draculaModeIsOn)
    }
    
    func updateUiStyle(draculaModeIsOn: Bool){
        print("styleSwitch state: \(draculaModeIsOn)")
        if draculaModeIsOn{
            settingsView.backgroundColor =
                SettingsViewController.draculaPrimary
            tipDefaultPicker.backgroundColor =
                SettingsViewController.draculaSecondary
            defaultTipLabel.textColor =
                SettingsViewController.draculaAccent
            UIView.animateWithDuration(1, animations: {
                self.draculaImage.alpha = 1
            })

        }else{
            settingsView.backgroundColor =
                SettingsViewController.tipsterPrimary
            tipDefaultPicker.backgroundColor =
                SettingsViewController.tipsterSecondary
            defaultTipLabel.textColor =
                SettingsViewController.tipsterAccent
            UIView.animateWithDuration(1, animations: {
                self.draculaImage.alpha = 0
            })

        }
        styleSwitch.setOn(draculaModeIsOn, animated: true)
        
    }
    
    //Initialize view
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        let defaults = NSUserDefaults.standardUserDefaults()
        //Initialize default tip percentage to zero
        defaultTip = 0
        
        //Get default tip from settings
        defaultTip = defaults.integerForKey(
            SettingsViewController.defaultTipKey)
        
        //Calculate the hunreths, tens, and ones digit values
        let hundreds = Int(defaultTip/100)
        defaultTipHundreds = hundreds * 100
        let tens = Int(defaultTip/10)-hundreds*10
        defaultTipTens = tens*10
        let ones =
            defaultTip - (hundreds*100) - (tens*10)
        defaultTipOnes = ones
        
        //Set the picker values to teh users last default tip value
        tipDefaultPicker
            .selectRow(hundreds, inComponent: 0, animated: true)
        tipDefaultPicker
            .selectRow(tens, inComponent: 1, animated: true)
        tipDefaultPicker
            .selectRow(ones, inComponent: 2, animated: true)
        
        //Set up the Picker corners
        tipDefaultPicker.layer.cornerRadius = 10;
        tipDefaultPicker.layer.masksToBounds = true;
        
        //Set the default tip text
        defaultTipLabel.text = "\(defaultTip)%"
        
        let draculaModeIsOn = defaults.boolForKey(
            SettingsViewController.draculaModeSettingKey)
        updateUiStyle(draculaModeIsOn)
    }
    
    override func viewDidAppear(animated: Bool) {
        super.viewDidAppear(animated)
    }
    
    //Save important items
    override func viewWillDisappear(animated: Bool) {
        super.viewWillDisappear(animated)
        
        saveDefault()
    }
}
