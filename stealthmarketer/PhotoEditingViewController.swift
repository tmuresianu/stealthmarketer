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
    let COLLECTION_VIEW_IMAGE_CELL_PICTURE_TAG = 2
    let COLLECTION_VIEW_IMAGE_CELL_PRICE_LABEL_TAG = 1
    let COLLECTION_VIEW_SUB_IMAGE_CELL_PICTURE_TAG = 1
    
    let NO_SELECTION = -999
    
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
        var hashtags:NSArray = []
    }
    
    func loadAdvertisements (){
        
        
        let cokeTestAngle:subImage = subImage()
        cokeTestAngle.price = "0.99"
        cokeTestAngle.imageName = "cellPlaceholder"
        cokeTestAngle.hashtags = ["#Coke", "#ShareACokeWithDad", "#99CentsLimitedTime", "#MyCokeAddiction"]
        
        let cokeTestAngle2:subImage = subImage()
        cokeTestAngle2.price = "0.99"
        cokeTestAngle2.imageName = "cellPlaceholder"
        
        let cokeBrand:brand = brand()
        cokeBrand.imageName = "sprite"
        cokeBrand.price = "0.40"
        cokeBrand.subImages = [cokeTestAngle, cokeTestAngle2]
        
        
        //--
        
        let molsonTestAngle:subImage = subImage()
        molsonTestAngle.price = "0.99"
        molsonTestAngle.imageName = "cellPlaceholder"
        molsonTestAngle.hashtags = ["#molson", "#ShareAmolsonWithDad", "#99CentsLimitedTime", "#MymolsonAddiction"]
        
        let molsonTestAngle2:subImage = subImage()
        molsonTestAngle.price = "0.99"
        molsonTestAngle.imageName = "cellPlaceholder"
        
        let molsonBrand:brand = brand()
        molsonBrand.imageName = "shasta"
        molsonBrand.price = "0.40"
        molsonBrand.subImages = [molsonTestAngle, molsonTestAngle2]
        
        let foodCategory:category = category()
        foodCategory.name = "Food"
        foodCategory.brands = [cokeBrand, molsonBrand]
        foodCategory.imageName = "fork-and-knife"
        
        //--
        
        
        let jetskiTestAngle:subImage = subImage()
        jetskiTestAngle.price = "0.99"
        jetskiTestAngle.imageName = "cellPlaceholder"
        jetskiTestAngle.hashtags = ["#jetski", "#ShareAjetskiWithDad", "#99CentsLimitedTime", "#MyjetskiAddiction"]
        
        let jetskiTestAngle2:subImage = subImage()
        jetskiTestAngle.price = "0.99"
        jetskiTestAngle.imageName = "cellPlaceholder"
        
        let jetskiBrand:brand = brand()
        jetskiBrand.imageName = "cellPlaceholder"
        jetskiBrand.price = "0.50"
        jetskiBrand.subImages = [jetskiTestAngle, jetskiTestAngle2]
        
        let natureCategory:category = category()
        natureCategory.name = "Nature"
        natureCategory.brands = [jetskiBrand]
        natureCategory.imageName = "hand-sun"
        
        categories = [foodCategory, natureCategory]
        
    }
    
    @IBAction func nextButtonPushed() {
        
        println("nextButtonPushed called")
        
        
        
    }
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
    
    if (segue.identifier == "ShowHashtagSelectionViewController"){
        
    }
    }
    
    override func viewDidLoad(){
        
        super.viewDidLoad()
        
        self.photoView.image = self.image
        
        self.navigationController?.navigationBarHidden = false
        //categoryCollectionView.layoutMargins = UIEdgeInsetsMake(0, 0, 0, 0)
        //categoryCollectionView.invalidateIntrinsicContentSize()
        //.itemSize = categoryCollectionView.frame.size
        //categoryCollectionView.collectionViewLayout.invalidateLayout()
        
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
        
        //let nameLabel:UILabel = cell.viewWithTag(COLLECTION_VIEW_CATEGORY_NAME_LABEL_TAG) as! UILabel
        //nameLabel.text = (categories.objectAtIndex(indexPath.row) as! category).name
        
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
    
    func collectionView(collectionView: UICollectionView, didSelectItemAtIndexPath indexPath: NSIndexPath){
        
        println("didSelectItemAtIndexPath Row: \(indexPath.section) Index: \(indexPath.row)")
        
        switch (collectionView.tag){
            case COLLECTION_VIEW_CATEGORY:
                selectedCategoryIndex = indexPath.row
                selectedBrandIndex = 0
                selectedAngleIndex = 0
                self.brandCollectionView.reloadData()
                self.subImageCollectionView.reloadData()
                break
            case COLLECTION_VIEW_IMAGE:
                selectedBrandIndex = indexPath.row
                selectedAngleIndex = 0
                self.subImageCollectionView.reloadData()
                break
            case COLLECTION_VIEW_SUB_IMAGE:
                self.insertAdIntoImage()
                break
        default:
            break
        }
        
    }
    
    
    func insertAdIntoImage(){
        
        println("insertAdIntoImage")
        
    }
    
    

}
