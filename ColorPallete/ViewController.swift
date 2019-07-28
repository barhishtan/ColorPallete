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
        willSet (newValue) {
            redLabel.text = String(newValue)
            redSlider.value = newValue
            redTF.text = String(newValue)
        }
    }
    private var greenValue: Float! {
        willSet (newValue) {
            greenLabel.text = String(newValue)
            greenSlider.value = newValue
            greenTF.text = String(newValue)
        }
    }
    private var blueValue: Float!{
        willячSet (newValue) {
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
    }
    
    func roundValue(_ value: Float) -> Float {
        return roundf(value / 0.01) * 0.01
    }
    
    func setDefaultValues() {
        redValue = roundValue(redSlider.value)
        greenValue = roundValue(greenSlider.value)
        blueValue = roundValue(blueSlider.value)
        paletteView.backgroundColor = UIColor(red: CGFloat(redValue), green: CGFloat(greenValue), blue: CGFloat(blueValue), alpha: 1.0)
    }
}

