//
//  BadgeButton.swift
//  VogueStore
//
//  Created by Corey McCourt on 9/26/16.
//  Copyright © 2016 Corey McCourt. All rights reserved.
//

import UIKit

class BadgeButton: UIView {
    @IBOutlet var view: UIView!
    @IBOutlet weak var button: UIButton!
    @IBOutlet weak var circleView: UIView!
    @IBOutlet weak var valueLabel: UILabel!

    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        
        Bundle.main.loadNibNamed("BadgeButton", owner: self, options: nil)
        
        circleView.layer.cornerRadius = 5
        circleView.layer.masksToBounds = true
        
        view.frame = bounds
        addSubview(self.view)
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        Bundle.main.loadNibNamed("BadgeButton", owner: self, options: nil)
        
        circleView.layer.cornerRadius = 10
        circleView.layer.masksToBounds = true
        
        view.frame = bounds
        addSubview(self.view)
    }
}
