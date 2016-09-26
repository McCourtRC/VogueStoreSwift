//
//  HomeViewController.swift
//  VogueStore
//
//  Created by Corey McCourt on 9/24/16.
//  Copyright © 2016 Corey McCourt. All rights reserved.
//

import UIKit
import Alamofire
import SwiftyJSON
import Ionicons_Swift

class HomeViewController: UIViewController, UICollectionViewDelegate, UICollectionViewDataSource {
    
    let ionIconSize = CGSize(width: 40, height: 40)
    
    @IBOutlet weak var shopBtn: IonIconBtn1!
    @IBOutlet weak var eventsBtn: IonIconBtn1!
    @IBOutlet weak var personalBtn: IonIconBtn1!
    
    @IBOutlet weak var loyaltyBtn: IonIconBtn2!
    @IBOutlet weak var offersBtn: IonIconBtn2!
    
    @IBOutlet weak var collectionView: UICollectionView!
    @IBOutlet weak var indicatorImage: UIImageView!

    var data = [Item]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        collectionView.delegate = self
        collectionView.dataSource = self
        
        loadDummyData()
        
        makeInfiniteScrollArray()
        
        // Navigation title image
        let imageView = UIImageView(frame: CGRect(x: 0, y: 0, width: 20, height: 20))
        imageView.contentMode = .scaleAspectFit
        let titleImage = UIImage(named: "logo-phrase")
        imageView.image = titleImage
        navigationItem.titleView = imageView
        
        // Bar button Items
        let leftBarBtnImg = UIImage.imageWithIonicon(.Navicon, color: MyColor.blue, iconSize: 40, imageSize: ionIconSize)
        let leftBarBtn = UIBarButtonItem(image: leftBarBtnImg, style: .plain, target: self, action: #selector(navBtnAction))
        navigationItem.leftBarButtonItem = leftBarBtn
        
        let rightBarBtnImg = UIImage.imageWithIonicon(.Person, color: MyColor.blue, iconSize: 35, imageSize: CGSize(width: 35, height: 35))
        let rightBarBtn = UIBarButtonItem(image: rightBarBtnImg, style: .plain, target: self, action: #selector(personBtnAction))
        navigationItem.rightBarButtonItem = rightBarBtn

        // Initialize custom buttons
        let shopBtnImage = UIImage.imageWithIonicon(.iOSCart, color: .white, iconSize: 40, imageSize: ionIconSize)
        shopBtn.imageView.image = shopBtnImage
        shopBtn.button.setTitle("Shop", for: .normal)
        shopBtn.button.backgroundColor = MyColor.blue
        shopBtn.button.addTarget(self, action: #selector(shopBtnAction), for: .touchUpInside)
        
        let eventsBtnImage = UIImage.imageWithIonicon(.Calendar, color: .white, iconSize: 40, imageSize: ionIconSize)
        eventsBtn.imageView.image = eventsBtnImage
        eventsBtn.button.setTitle("Events", for: .normal)
        eventsBtn.button.addTarget(self, action: #selector(eventsBtnAction), for: .touchUpInside)
        
        let personalBtnImage = UIImage.imageWithIonicon(.Bag, color: .white, iconSize: 40, imageSize: ionIconSize)
        personalBtn.imageView.image = personalBtnImage
        personalBtn.button.setTitle("Book Personal Shopper", for: .normal)
        personalBtn.button.addTarget(self, action: #selector(personalBtnAction), for: .touchUpInside)
        
        offersBtn.titleLabel.text = "Offers"
        offersBtn.imageView.image = UIImage.imageWithIonicon(.Pricetag, color: .white, iconSize: 40, imageSize: ionIconSize)
        offersBtn.infoLabel.text = "1 new offer"
        
        loyaltyBtn.titleLabel.text = "Loyalty"
        loyaltyBtn.imageView.image = UIImage.imageWithIonicon(.Trophy, color: .white, iconSize: 40, imageSize: ionIconSize)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        
        // Get loyalty points
        let params = [
            "username": "Michael",
            "grandTotal": "0"
        ]
        Alamofire.request("http://54.191.35.66:8181/pfchang/api/buy", method: .post, parameters: params).responseJSON { (response) in
            if let res = response.result.value {
                let json = JSON(res)
                let points = json["rewardPoints"]
                self.loyaltyBtn.infoLabel.text = "\(points) pts."
            }
        }
    }
    
    // MARK: - Collection View
    public func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return data.count
    }
    
    public func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cell", for: indexPath)
        let item = data[indexPath.row]
        
        let imageView = cell.viewWithTag(100) as! UIImageView
        imageView.image = item.image
        
        let titleView = cell.viewWithTag(200)! as UIView
        titleView.isHidden = item.name == ""
        
        let nameView = cell.viewWithTag(300) as! UILabel
        nameView.text = item.name
        
        let descriptionView = cell.viewWithTag(400) as! UILabel
        descriptionView.text = item.description
        
        let actionBtn = cell.viewWithTag(500) as! UIButton
        actionBtn.isHidden = item.action == ""
        actionBtn.titleLabel?.text = item.action
        
        return cell
    }
    
    // MARK: - Actions
    func navBtnAction() {
        print("Nav Button Action")
    }
    
    func personBtnAction() {
        print("Person Button Action")
    }
    
    func shopBtnAction() {
        self.performSegue(withIdentifier: "shop", sender: self)
    }
    
    func eventsBtnAction() {
        print("Events Button Action")
    }
    
    func personalBtnAction() {
        print("Personal Button Action")
    }
    
    // MARK: - Infinite Scroll
    
    // Copy first two elements to back of array
    // Allows for forward and backward scrolling
    // Scroll to new position if at the edge of array
    func makeInfiniteScrollArray() {
        let firstCopy = data[0]
        let secondCopy = data[1]
        data.append(firstCopy)
        data.append(secondCopy)
    }
    
    func scrollViewDidEndDecelerating(_ scrollView: UIScrollView) {
        let offsetWhenFullyRight = collectionView.frame.size.width * CGFloat(data.count - 1)
        
        // user is scrolling to the right from the last item to the 'fake' item 1.
        // reposition offset to show the 'real' item 1 at the left-hand end of the collection view
        if scrollView.contentOffset.x == offsetWhenFullyRight {
            let newIndexPath = IndexPath(item: 1, section: 0)
            collectionView.scrollToItem(at: newIndexPath, at: .left, animated: false)
        }
        // user is scrolling to the left from the first item to the fake 'item N'.
        // reposition offset to show the 'real' item N at the right end end of the collection view
        else if scrollView.contentOffset.x == 0 {
            let newIndexPath = IndexPath(item: data.count - 2, section: 0)
            collectionView.scrollToItem(at: newIndexPath, at: .left, animated: false)
        }
        
        //update indicator image
        let currentImgNum = collectionView.indexPathsForVisibleItems.first!.row % (data.count - 2)
        indicatorImage.image = UIImage(named: "indicator\(currentImgNum)")
    }
    
    // MARK: - Load Dummy Data
    func loadDummyData() {
        let item1 = Item(name: "", price: "0", imageName: "sneakersA")
        data.append(item1)
        
        let item2 = Item(name: "", price: "0", imageName: "shoesB")
        data.append(item2)
        
        let item3 = Item(name: "Fashion Show", price: "0", imageName: "fashionShow", description: "December 1st 2015", action: "Get Tickets")
        data.append(item3)
        
        let item4 = Item(name: "Personal Shopper", price: "0", imageName: "personalShopper", action: "Book Now")
        data.append(item4)
    }
}
