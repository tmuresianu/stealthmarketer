//
//  PhotoEditingViewController.swift
//  stealthmarketer
//
//  Created by Toby Muresianu on 5/2/15.
//  Copyright (c) 2015 tobymuresianu. All rights reserved.
//

import UIKit

class PhotoEditingViewController : UIViewController, UICollectionViewDelegate, UICollectionViewDataSource {
    
    @IBOutlet weak var photoView : UIImageView!
    
    @IBOutlet weak var categoryCollectionView : UICollectionView!
    @IBOutlet weak var brandCollectionView : UICollectionView!
    @IBOutlet weak var subImageCollectionView : UICollectionView!
    
    var image:UIImage?
    
    var categories:NSArray = []
    
    let COLLECTION_VIEW_CATEGORY = 1
    let COLLECTION_VIEW_IMAGE = 2
    let COLLECTION_VIEW_SUB_IMAGE = 3
    
    let COLLECTION_VIEW_CATEGORY_NAME_LABEL_TAG = 1
    let COLLECTION_VIEW_CATEGORY_BACKGROUND_IMAGE_VIEW_TAG = 2
    let COLLECTION_VIEW_IMAGE_CELL_PICTURE_TAG = 1
    let COLLECTION_VIEW_IMAGE_CELL_PRICE_LABEL_TAG = 2
    let COLLECTION_VIEW_SUB_IMAGE_CELL_PICTURE_TAG = 1
    
    var selectedCategoryIndex:Int = 0
    var selectedBrandIndex:Int = 0
    var selectedAngleIndex:Int?
    
    //category = category name + array of image categories
    //image category = image name, price, array of subimages
    //subimages: image name, price.
    
    
    class category {
        var name:String = ""
        var brands:NSArray = []
        var imageName:String?
    }
    class brand {
        var price:String?
        var imageName:String = ""
        var subImages:NSArray = []
    }
    class subImage {
        var price:String?
        var imageName:String = ""
    }
    
    func loadAdvertisements (){
        
        
        let cokeTestAngle:subImage = subImage()
        cokeTestAngle.price = "0.99"
        cokeTestAngle.imageName = "cellPlaceholder"
        
        let cokeTestAngle2:subImage = subImage()
        cokeTestAngle.price = "0.99"
        cokeTestAngle.imageName = "cellPlaceholder"
        
        let cokeBrand:brand = brand()
        cokeBrand.imageName = "cellPlaceholder"
        cokeBrand.price = "0.40"
        cokeBrand.subImages = [cokeTestAngle, cokeTestAngle2]
        
        let foodCategory:category = category()
        foodCategory.name = "Food"
        foodCategory.brands = [cokeBrand]
        foodCategory.imageName = "cellPlaceholder"
        
        categories = [foodCategory]
        
    }
    
    @IBAction func nextButtonPushed() {
        
        println("nextButtonPushed called")
        
        
    }
    
    override func viewDidLoad(){
        
        super.viewDidLoad()
        
        self.photoView.image = self.image
        
        loadAdvertisements()
        
    }
    
    func setImage(var newImage:UIImage){
        
        self.photoView.image = newImage
    }
    
    func collectionView(collectionView: UICollectionView, cellForItemAtIndexPath indexPath: NSIndexPath) -> UICollectionViewCell {
        
        println("cellForRow called - collection view tag: \(collectionView.tag) row: \(indexPath.row)")
        
        switch (collectionView.tag){
            
        case COLLECTION_VIEW_CATEGORY:
            return categoryCellAtIndex(indexPath)
        case COLLECTION_VIEW_IMAGE:
            return imageCellAtIndex(indexPath)
        case COLLECTION_VIEW_SUB_IMAGE:
            return subImageCellAtIndex(indexPath)
            
        default:
            
            assertionFailure("Unrecognized collection view")
            
            return categoryCellAtIndex(indexPath)
        }
        
        
    }
    
    func imageCellAtIndex(var indexPath:NSIndexPath) -> UICollectionViewCell {
        
        
        let cell:UICollectionViewCell = brandCollectionView.dequeueReusableCellWithReuseIdentifier("cell", forIndexPath: indexPath) as! UICollectionViewCell
        
        let priceLabel:UILabel = cell.viewWithTag(COLLECTION_VIEW_IMAGE_CELL_PRICE_LABEL_TAG) as! UILabel
        let imageView:UIImageView = cell.viewWithTag(COLLECTION_VIEW_IMAGE_CELL_PICTURE_TAG) as! UIImageView

        let currentBrand:brand = (categories.objectAtIndex(selectedCategoryIndex) as! category).brands.objectAtIndex(indexPath.row) as! brand
        
        priceLabel.text = currentBrand.price
        imageView.image = UIImage(named:currentBrand.imageName)
        
        return cell
    }
    
    func subImageCellAtIndex(var indexPath:NSIndexPath) -> UICollectionViewCell{
        
        let cell:UICollectionViewCell = subImageCollectionView.dequeueReusableCellWithReuseIdentifier("cell", forIndexPath: indexPath) as! UICollectionViewCell
        
        //let priceLabel:UILabel = cell.viewWithTag(COLLECTION_VIEW_SUB_IMAGE_CELL_PICTURE_TAG) as! UILabel
        let imageView:UIImageView = cell.viewWithTag(COLLECTION_VIEW_SUB_IMAGE_CELL_PICTURE_TAG) as! UIImageView
        
        
        let currentBrand:brand = (categories.objectAtIndex(selectedCategoryIndex) as! category).brands.objectAtIndex(selectedBrandIndex) as! brand
        
        let currentAngle:subImage = currentBrand.subImages.objectAtIndex(indexPath.row) as! subImage
        
        imageView.image = UIImage(named: currentAngle.imageName)
        
        return cell
    }
    
    func categoryCellAtIndex(var indexPath:NSIndexPath) -> UICollectionViewCell{
        
        var cell:UICollectionViewCell = categoryCollectionView.dequeueReusableCellWithReuseIdentifier("cell", forIndexPath: indexPath) as! UICollectionViewCell
        
        //println("COllection view category name label tag: \(COLLECTION_VIEW_CATEGORY_NAME_LABEL_TAG)")
        
        let nameLabel:UILabel = cell.viewWithTag(COLLECTION_VIEW_CATEGORY_NAME_LABEL_TAG) as! UILabel
        nameLabel.text = (categories.objectAtIndex(indexPath.row) as! category).name
        
        let imageName:String = (categories.objectAtIndex(indexPath.row) as! category).imageName!
    
        let backgroundImageView:UIImageView = cell.viewWithTag(COLLECTION_VIEW_CATEGORY_BACKGROUND_IMAGE_VIEW_TAG) as! UIImageView
        //TODO: Set image based on name. backgroundImageView.image
        backgroundImageView.image = UIImage(named: imageName)
        
        return cell
    }
    
    func collectionView(collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        
        switch (collectionView.tag){
            
        case COLLECTION_VIEW_CATEGORY:
            return categories.count
        case COLLECTION_VIEW_IMAGE:
            return (categories.objectAtIndex(selectedCategoryIndex) as! category).brands.count
        case COLLECTION_VIEW_SUB_IMAGE:
            return ((categories.objectAtIndex(selectedCategoryIndex) as! category).brands.objectAtIndex(selectedBrandIndex) as! brand).subImages.count
        default:
            return 0
        }
        
    }
    func collectionView(collectionView: UICollectionView, didSelectItemAtIndexPath indexPath: NSIndexPath) {
        
    }
    
}
