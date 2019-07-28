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
    
    override func viewWillLayoutSubviews() {
        paletteView.layer.cornerRadius = paletteView.frame.width * 0.05
        paletteView.layer.borderWidth = 1.0
        paletteView.layer.borderColor = UIColor.gray.cgColor
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
}

