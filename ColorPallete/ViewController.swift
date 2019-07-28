//
//  ViewController.swift
//  ColorPallete
//
//  Created by Artur Sokolov on 28/07/2019.
//  Copyright © 2019 Artur Sokolov. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var paletteView: UIView!
    
    @IBOutlet weak var redLabel: UILabel!
    @IBOutlet weak var greenLabel: UILabel!
    @IBOutlet weak var blueLabel: UILabel!
    
    @IBOutlet weak var redSlider: UISlider!
    @IBOutlet weak var greenSlider: UISlider!
    @IBOutlet weak var blueSlider: UISlider!
    
    @IBOutlet weak var redTF: UITextField!
    @IBOutlet weak var greenTF: UITextField!
    @IBOutlet weak var blueTF: UITextField!
    
    private var redValue: Float! {
        willSet (value) {
            let newValue = roundf(value * 100) / 100
            redLabel.text = String(newValue)
            redSlider.value = newValue
            redTF.text = String(newValue)
        }
    }
    private var greenValue: Float! {
        willSet (value) {
            let newValue = roundf(value * 100) / 100
            greenLabel.text = String(newValue)
            greenSlider.value = newValue
            greenTF.text = String(newValue)
        }
    }
    private var blueValue: Float!{
        willSet (value) {
            let newValue = roundf(value * 100) / 100
            blueLabel.text = String(newValue)
            blueSlider.value = newValue
            blueTF.text = String(newValue)
        }
    }
    
    override func viewWillLayoutSubviews() {
        paletteView.layer.cornerRadius = paletteView.frame.width * 0.05
        paletteView.layer.borderWidth = 1.0
        paletteView.layer.borderColor = UIColor.gray.cgColor
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setDefaultValues()
        addDoneButton()
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        dismissKeyboard()
    }
    
    @IBAction func sliderChanged(_ sender: UISlider) {
        switch sender.tag {
        case 0:
            redValue = redSlider.value
        case 1:
            greenValue = greenSlider.value
        case 2:
            blueValue = blueSlider.value
        default:
            break
        }
        
        updatePaletteView()
    }
    
    @IBAction func textFieldChanged(_ sender: UITextField) {
        guard let valueTF = sender.text else { return }
        guard var value = Float(valueTF) else {
            showAlert()
            return
        }
        
        if value > 1 {
            value = 1
        } else if value < 0 {
            value = 0
        }
        
        
        switch sender.tag {
        case 0:
            redValue = value
        case 1:
            greenValue = value
        case 2:
            blueValue = value
        default:
            break
        }
        
        updatePaletteView()
    }
    
    private func updatePaletteView() {
       paletteView.backgroundColor = UIColor(red: CGFloat(redValue), green: CGFloat(greenValue), blue: CGFloat(blueValue), alpha: 1.0)
    }
    
    private func setDefaultValues() {
        redValue = redSlider.value
        greenValue = greenSlider.value
        blueValue = blueSlider.value
        updatePaletteView()
    }
    
    func addDoneButton() {
        let toolbar = UIToolbar()
        let doneButton = UIBarButtonItem(title: "Done", style: .done,
                                         target: self, action: #selector(dismissKeyboard))
        toolbar.items = [doneButton]
        toolbar.sizeToFit()
        
        redTF.inputAccessoryView = toolbar
        greenTF.inputAccessoryView = toolbar
        blueTF.inputAccessoryView = toolbar
    }
    
    @objc func dismissKeyboard() {
        view.endEditing(true)
    }
    
    func showAlert() {
        let alert = UIAlertController(title: "Ошибка", message: "Введите числовое значение", preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
        self.present(alert, animated: true, completion: nil)
    }
    
}


