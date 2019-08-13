//
//  MainViewController.swift
//  ColorPallete
//
//  Created by Artur Sokolov on 13/08/2019.
//  Copyright © 2019 Artur Sokolov. All rights reserved.
//

import UIKit

class MainViewController: UIViewController {
    
    // MARK: - Public Properties
    var red: Float = 1.0
    var green: Float = 1.0
    var blue: Float = 1.0

    // MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = UIColor(red: CGFloat(red),
                                       green: CGFloat(green),
                                       blue: CGFloat(blue),
                                       alpha: 1)
    }
    
    // MARK: Navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let palleteVC = segue.destination as! PalleteViewController
        palleteVC.red = red
        palleteVC.blue = blue
        palleteVC.green = green
    }
    
}
