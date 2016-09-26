//
//  IonIconBtn2.swift
//  VogueStore
//
//  Created by Corey McCourt on 9/26/16.
//  Copyright © 2016 Corey McCourt. All rights reserved.
//

import UIKit

class IonIconBtn2: UIView {
    @IBOutlet var view: UIView!
    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var infoLabel: UILabel!
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        
        Bundle.main.loadNibNamed("IonIconBtn2", owner: self, options: nil)
        
        view.frame = bounds
        addSubview(self.view)
    }

}
