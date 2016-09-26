//
//  ShopViewController.swift
//  VogueStore
//
//  Created by Corey McCourt on 9/24/16.
//  Copyright © 2016 Corey McCourt. All rights reserved.
//

import UIKit
import Ionicons_Swift

class ShopViewController: UIViewController, UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
   
    @IBOutlet weak var collectionView: UICollectionView!
    
    enum Section: Int {
        case featured = 0
        case basic = 1
    }
    
    var data = [Item]()
    var featuredData = [Item]()
    var numCartItems = 0

    override func viewDidLoad() {
        super.viewDidLoad()
        
        collectionView.delegate = self
        collectionView.dataSource = self
        self.automaticallyAdjustsScrollViewInsets = false
        
        // Bar button items
        let leftBarBtnImg = UIImage.imageWithIonicon(.iOSArrowLeft, color: MyColor.blue, iconSize: 40, imageSize: CGSize(width: 40, height: 40))
        let leftBarBtn = UIBarButtonItem(image: leftBarBtnImg, style: .plain, target: self, action: #selector(backBtnAction))
        navigationItem.leftBarButtonItem = leftBarBtn
        
        let rightBarBtnImg = UIImage.imageWithIonicon(.iOSCart, color: MyColor.blue, iconSize: 40, imageSize: CGSize(width: 40, height: 40))
        let rightBarBtnView = BadgeButton(frame: CGRect(x: 0, y: 0, width: 40, height: 40))
        rightBarBtnView.button.setImage(rightBarBtnImg, for: .normal)
        rightBarBtnView.valueLabel.text = String(numCartItems)
        let rightBarBtn = UIBarButtonItem(customView: rightBarBtnView)
        navigationItem.rightBarButtonItem = rightBarBtn
        
        //Add dummy data
        addDummyData()
    }
    
    // MARK: - Collection View
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return featuredData.count > 0 ? 2 : 1
    }
    
    public func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return section == Section.featured.rawValue ? featuredData.count : data.count
    }
    
    
    
    public func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        var cell: UICollectionViewCell
        var item: Item
        
        switch indexPath.section {
        case Section.featured.rawValue:
            cell = collectionView.dequeueReusableCell(withReuseIdentifier: "featuredCell", for: indexPath)
            item = featuredData[indexPath.row]
            
            let nameLabel = cell.viewWithTag(100) as! UILabel
            nameLabel.text = item.name
            
            let priceLabel = cell.viewWithTag(200) as! UILabel
            priceLabel.text = item.price
            
            let imageView = cell.viewWithTag(300) as! UIImageView
            imageView.image = item.image
            
            let cartBtn = cell.viewWithTag(400) as! UIButton
            cartBtn.addTarget(self, action: #selector(addItemToCart), for: .touchUpInside)
            
            let saleView = cell.viewWithTag(500) as! UIImageView
            saleView.image = UIImage(named: "bigSale")
            break
        default: // Section.basic
            cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cell", for: indexPath)
            item = data[indexPath.row]
            
            let nameLabel = cell.viewWithTag(100) as! UILabel
            nameLabel.text = item.name
            
            let priceLabel = cell.viewWithTag(200) as! UILabel
            priceLabel.text = item.price
            
            let imageView = cell.viewWithTag(300) as! UIImageView
            imageView.image = item.image
            imageView.layer.borderWidth = 1.0
            imageView.layer.borderColor = MyColor.lightGray.cgColor
            
            let cartBtn = cell.viewWithTag(400) as! UIButton
            cartBtn.addTarget(self, action: #selector(addItemToCart), for: .touchUpInside)
            break
        }
        
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        var size: CGSize
        
        switch indexPath.section {
        case Section.featured.rawValue:
            size = CGSize(width: 325, height: 204)
        default:
            size = CGSize(width: 150, height: 204)
        }
        
        return size
    }

    
    // MARK: - Actions
    func backBtnAction() {
        _ = navigationController?.popViewController(animated: true)
    }
    
    func cartBtnAction() {
        print("Cart Button Action")
    }
    
    func addItemToCart() {
        numCartItems += 1
        //update cart badge
        let rightBarBtn = self.navigationItem.rightBarButtonItem?.customView as! BadgeButton
        rightBarBtn.valueLabel.text = String(numCartItems)
    }
    
    // MARK: Dummy Data
    func addDummyData() {
        // Featured content
        let item1 = Item(name: "Magician Hat", price: "$39.00", imageName: "magicianHat")
        featuredData.append(item1)
        
        // Basic content
        let item2 = Item(name: "Sneakers A", price: "$49.95", imageName: "sneakersA")
        data.append(item2)
        let item3 = Item(name: "Shoes B", price: "$79.95", imageName: "shoesB")
        data.append(item3)
        let item4 = Item(name: "Dress A", price: "$99.00", imageName: "dressA")
        data.append(item4)
        let item5 = Item(name: "Dress B", price: "$89.00", imageName: "dressB")
        data.append(item5)
        let item6 = Item(name: "Sneakers A", price: "$49.95", imageName: "sneakersA")
        data.append(item6)
        let item7 = Item(name: "Shoes B", price: "$79.95", imageName: "shoesB")
        data.append(item7)
    }
}
