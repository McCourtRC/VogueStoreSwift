//
//  IonIconBtn1.swift
//  VogueStore
//
//  Created by Corey McCourt on 9/26/16.
//  Copyright © 2016 Corey McCourt. All rights reserved.
//

import UIKit

class IonIconBtn1: UIView {
    @IBOutlet var view: UIView!
    @IBOutlet weak var button: UIButton!
    @IBOutlet weak var imageView: UIImageView!
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        
        Bundle.main.loadNibNamed("IonIconBtn1", owner: self, options: nil)
        
        view.frame = bounds
        self.addSubview(self.view)
    }
    
}
