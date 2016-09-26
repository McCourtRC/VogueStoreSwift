//
//  ItemModel.swift
//  VogueStore
//
//  Created by Corey McCourt on 9/25/16.
//  Copyright © 2016 Corey McCourt. All rights reserved.
//

import Foundation
import UIKit

struct Item {
    var name: String
    var price: String
    var image: UIImage
    var description: String?
    var action: String?
    init(name: String, price: String, imageName: String, description: String = "", action: String = "") {
        self.name = name
        self.price = price
        self.image = UIImage(named: imageName)!
        self.description = description
        self.action = action
    }
}
