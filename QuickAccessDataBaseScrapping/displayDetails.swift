//
//  displayDetails.swift
//  QuickAccessDataBaseScrapping
//
//  Created by Manolescu Mihai Alexandru on 19/08/2017.
//  Copyright © 2017 Manolescu Mihai Alexandru. All rights reserved.
//

import UIKit
import Foundation

class displayDetails: UIViewController
{


    @IBOutlet weak var descriptionLabel: UILabel!
    
    var objectDescription = String()
    
    override func viewDidLoad()
    {
        super.viewDidLoad()

        descriptionLabel.text = objectDescription
    }

    //this function hides the status bar upwards:
    override var prefersStatusBarHidden: Bool
    {
        return true
    }


}
