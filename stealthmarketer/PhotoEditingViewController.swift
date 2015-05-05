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
        var hashtags:NSArray = []
    }
    class brand {
        var price:String?
        var imageName:String = ""
        var subImages:NSArray = []
        var hashtags:NSArray = []
    }
    class subImage {
        var price:String?
        var imageName:String = ""
        var hashtags:NSArray = []
    }
    
    func loadAdvertisements (){
        
        
        let cokeTestAngle:subImage = subImage()
        cokeTestAngle.price = "$0.99"
        cokeTestAngle.imageName = "sprite"
        
        let cokeBrand:brand = brand()
        cokeBrand.imageName = "sprite"
        cokeBrand.price = "$0.40"
        cokeBrand.subImages = [cokeTestAngle]
        
        let cokeHashtag1 = hashtag()
        cokeHashtag1.price = 10
        cokeHashtag1.text = "#Coke"
        
        let cokeHashtag2 = hashtag()
        cokeHashtag2.price = 15
        cokeHashtag2.text = "#ShareACokeWithDad"
        
        let cokeHashtag3 = hashtag()
        cokeHashtag3.price = 20
        cokeHashtag3.text = "#99CentsLimitedTime"
        
        let cokeHashtag4 = hashtag()
        cokeHashtag4.price = 25
        cokeHashtag4.text = "#MyCokeAddiction"
        
        let hashtagsArray = [cokeHashtag1, cokeHashtag2, cokeHashtag3, cokeHashtag4]
        
        //--
        
        let shastaTestAngle:subImage = subImage()
        shastaTestAngle.price = "$0.99"
        shastaTestAngle.imageName = "shasta-from-above"
        let shastaTestAngle2:subImage = subImage()
        shastaTestAngle2.price = "$0.99"
        shastaTestAngle2.imageName = "shasta-straight"
        
        shastaTestAngle.hashtags = hashtagsArray
        shastaTestAngle2.hashtags = hashtagsArray
        
        let shastaBrand:brand = brand()
        shastaBrand.imageName = "shasta"
        shastaBrand.price = "$0.55"
        shastaBrand.subImages = [shastaTestAngle, shastaTestAngle2]
        
        shastaBrand.hashtags = ["#shasta", "#ShareAshastaWithDad", "#99CentsLimitedTime", "#MyshastaAddiction"]
        
        
        let foodCategory:category = category()
        foodCategory.name = "Food"
        foodCategory.brands = [cokeBrand, shastaBrand]
        foodCategory.imageName = "fork-and-knife"
        
        //--
        
        
        let jetskiTestAngle:subImage = subImage()
        jetskiTestAngle.price = "$0.99"
        jetskiTestAngle.imageName = "jet-ski"
        
        let jetskiTestAngle2:subImage = subImage()
        jetskiTestAngle.price = "$0.99"
        jetskiTestAngle.imageName = "jet-ski-flipped"
        jetskiTestAngle.hashtags = ["#jetski", "#ShareAjetskiWithDad", "#99CentsLimitedTime", "#MyjetskiAddiction"]
        
        let jetskiBrand:brand = brand()
        jetskiBrand.imageName = "jet-ski"
        jetskiBrand.price = "$0.50"
        jetskiBrand.subImages = [jetskiTestAngle, jetskiTestAngle2]
        jetskiBrand.hashtags = ["#jetski", "#ShareAjetskiWithDad", "#99CentsLimitedTime", "#MyjetskiAddiction"]
        
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
        
        var nextVC:HashtagSelectionViewController = segue.destinationViewController as! HashtagSelectionViewController
        
        let selectedCategory:category = categories.objectAtIndex(selectedCategoryIndex) as! category
        let selectedBrand:brand = selectedCategory.brands.objectAtIndex(selectedBrandIndex) as! brand
        let selectedAngle:subImage = selectedBrand.subImages.objectAtIndex(selectedAngleIndex!) as! subImage
        
        
        println("Number of hashtags: \(selectedAngle.hashtags.count)")
        
        nextVC.hashtags = selectedAngle.hashtags
        
        
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
        
        let selectedCategory:category = categories.objectAtIndex(selectedCategoryIndex) as! category
        let selectedBrand:brand = selectedCategory.brands.objectAtIndex(selectedBrandIndex) as! brand
        let selectedAngle:subImage = selectedBrand.subImages.objectAtIndex(selectedAngleIndex!) as! subImage
        
        let selectedImage:UIImage = UIImage(named:selectedAngle.imageName)!
        
        let adView = DraggableImageView(frame: CGRectMake(160, 160, selectedImage.size.width * 2, selectedImage.size.height * 2))
        
        adView.image = selectedImage
        
        //adView.backgroundColor = UIColor.redColor()
        
        self.photoView.superview!.addSubview(adView)
        
    }
    
    
    func saveImage (){
    
        println("saveImage called")
    
        UIGraphicsBeginImageContextWithOptions(self.photoView.bounds.size, self.photoView.opaque, 0.0);
        self.photoView.layer.renderInContext(UIGraphicsGetCurrentContext())
        let viewImage = UIGraphicsGetImageFromCurrentImageContext();
        UIGraphicsEndImageContext();
    
        let imdata = UIImagePNGRepresentation (viewImage); // get PNG representation
        let im2 = UIImage(data: imdata) // wrap UIImage around PNG representation
    
        UIImageWriteToSavedPhotosAlbum(im2, self,  "thisImage:hasBeenSavedInPhotoAlbumWithError:usingContextInfo:", nil)
    
    }
    

}
