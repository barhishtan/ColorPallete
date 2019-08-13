//
//  ViewController.swift
//  ColorPallete
//
//  Created by Artur Sokolov on 28/07/2019.
//  Copyright © 2019 Artur Sokolov. All rights reserved.
//

import UIKit

// MARK: Pallete View Controller Delegate
protocol PalleteVCDelegate {
    
    func setBackgroundColor(_ red: Float,
                            _ green: Float,
                            _ blue: Float)
    
}

class PalleteViewController: UIViewController {
    
    // MARK: - Public Properties
    var red: Float!
    var green: Float!
    var blue: Float!
    var delegate: PalleteVCDelegate!
    
    // MARK: - IB Outlets
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

    // MARK: - Lifecycle
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.setNavigationBarHidden(true, animated: animated)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        redTF.delegate = self
        greenTF.delegate = self
        blueTF.delegate = self
        
        paletteView.layer.cornerRadius = paletteView.frame.width * 0.05
        paletteView.layer.borderWidth = 1.0
        paletteView.layer.borderColor = UIColor.gray.cgColor
        
        setSlidersValues()
        setDefaultValues()
        updatePaletteView()
        addDoneButton()
    }
    
    // MARK: - IB Actions
    @IBAction func sliderChanged(_ sender: UISlider) {
        let newValue = String(roundf(sender.value * 100) / 100)
        
        switch sender.tag {
        case 0:
            redLabel.text = newValue
            redTF.text = newValue
        case 1:
            greenLabel.text = newValue
            greenTF.text = newValue
        case 2:
            blueLabel.text = newValue
            blueTF.text = newValue
        default:
            break
        }
        
        updatePaletteView()
    }
    
    @IBAction func doneButtonPressed(_ sender: UIButton) {
        let red = redSlider.value
        let green = greenSlider.value
        let blue = blueSlider.value
        delegate.setBackgroundColor(red, green, blue)
        navigationController?.popViewController(animated: true)
    }
    
    // MARK: - Private Methods
    private func updatePaletteView() {
       paletteView.backgroundColor =
        UIColor(red: CGFloat(redSlider.value),
                green: CGFloat(greenSlider.value),
                blue: CGFloat(blueSlider.value),
                alpha: 1.0)
    }
    
    private func setDefaultValues() {
        redLabel.text = String(redSlider.value)
        redTF.text = String(redSlider.value)
        greenLabel.text = String(greenSlider.value)
        greenTF.text = String(greenSlider.value)
        blueLabel.text = String(blueSlider.value)
        blueTF.text = String(blueSlider.value)
    }
    
    private func setSlidersValues() {
        redSlider.value = roundf(red * 100) / 100
        greenSlider.value = roundf(green * 100) / 100
        blueSlider.value = roundf(blue * 100) / 100
    }
    
}


// MARK: Text field delegate
extension PalleteViewController: UITextFieldDelegate {
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        super.touchesBegan(touches, with: event)
        dismissKeyboard()
    }
    
    func textFieldDidEndEditing(_ textField: UITextField) {
    
        guard let valueTF = textField.text else { return }
        guard var value = Float(valueTF) else {
            showAlert()
            return
        }
        
        value = roundf(value * 100) / 100
        if value > 1 { value = 1 }
        else if value < 0 { value = 0 }
        
        textField.text = String(value)
        
        switch textField.tag {
        case 0:
            redSlider.value = value
            redLabel.text = String(value)
        case 1:
            greenSlider.value = value
            greenLabel.text = String(value)
        case 2:
            blueSlider.value = value
            blueLabel.text = String(value)
        default:
            break
        }
        
        updatePaletteView()
    }
}

// MARK: - Add Done Button
extension PalleteViewController {
    
    private func addDoneButton() {
        let toolbar = UIToolbar()
        let doneButton = UIBarButtonItem(title: "Done",
                                         style: .done,
                                         target: self,
                                         action: #selector(dismissKeyboard))
        let flexsibleSpace = UIBarButtonItem(barButtonSystemItem: .flexibleSpace,
                                             target: nil,
                                             action: nil)
        toolbar.items = [flexsibleSpace, doneButton]
        toolbar.sizeToFit()
        
        redTF.inputAccessoryView = toolbar
        greenTF.inputAccessoryView = toolbar
        blueTF.inputAccessoryView = toolbar
    }
    
    @objc private func dismissKeyboard() {
        view.endEditing(true)
    }
    
}

// MARK: Add Alert
extension PalleteViewController {
    
    private func showAlert() {
        let alert = UIAlertController(title: "Ошибка",
                                      message: "Введите числовое значение",
                                      preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "OK",
                                      style: .default,
                                      handler: nil))
        self.present(alert, animated: true, completion: nil)
    }
}
