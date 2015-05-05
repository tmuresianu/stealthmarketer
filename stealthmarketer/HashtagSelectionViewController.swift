//
//  HashtagSelectionViewController.swift
//  stealthmarketer
//
//  Created by Toby Muresianu on 5/2/15.
//  Copyright (c) 2015 tobymuresianu. All rights reserved.
//

import UIKit

class HashtagSelectionViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {
    
    
    @IBOutlet weak var priceLabel:UILabel?
    @IBOutlet weak var tableView:UITableView?
    
    var hashtags:NSArray = []
    var selectedRows:NSMutableArray = []
    var currentTotal:Int = 0
    var mediaID:String!
    
    @IBAction func postToInstagram () {
        println("postToInstagram called")
        
        let instagramURL = "instagram://media?id=\(mediaID)&tag?name=#Test2,#Test3"
        
        UIApplication.sharedApplication().openURL(NSURL(string: instagramURL)!)
        
    }
    
    override func viewDidLoad(){
        
        super.viewDidLoad()
    
        for row in hashtags {
            selectedRows.addObject(NSNumber(bool: false))
        }
        
    }
    
    func getPriceStringForAmount(amount:Int) -> String {
        
        var centsString = (amount % 100 < 10) ? "\(amount % 100)" : "0\(amount % 100)"
        
        return "$\(amount/100).\(centsString)"
        
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
    
        let cell:UITableViewCell = UITableViewCell(style: UITableViewCellStyle.Value1, reuseIdentifier: "cell")
        
        let currentHashtag:hashtag = hashtags.objectAtIndex(indexPath.row) as! hashtag

        cell.textLabel!.text = currentHashtag.text
        cell.detailTextLabel!.text = getPriceStringForAmount(currentHashtag.price)
        
        if ((selectedRows.objectAtIndex(indexPath.row) as! NSNumber).boolValue == true){
            cell.accessoryType = UITableViewCellAccessoryType.Checkmark
        }
        else {
            cell.accessoryType = UITableViewCellAccessoryType.None
        }
        
        return cell
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
     
        return hashtags.count
    }
    
    
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        
        //TODO: Recalculate ad.
        //if it is not selected, then we select it, and add to the total. If we deselect it, we subtract from the total.
        
        let selectedHashtag:hashtag = hashtags.objectAtIndex(indexPath.row) as! hashtag
        
        let wasSelected:Bool = (selectedRows.objectAtIndex(indexPath.row) as! NSNumber).boolValue
        
        if (wasSelected){
            currentTotal -= selectedHashtag.price
        }
        else {
            currentTotal += selectedHashtag.price
        }
        
        selectedRows.replaceObjectAtIndex(indexPath.row, withObject: NSNumber(bool: !wasSelected))
        self.tableView?.reloadRowsAtIndexPaths([indexPath], withRowAnimation: UITableViewRowAnimation.Fade)
        
        reloadPrice()
    }
    
    func reloadPrice(){
        
        priceLabel!.text = getPriceStringForAmount(currentTotal)
        
    }
}

class hashtag {
    
    var text:String = ""
    var price:Int = 0
    /*
    
    func hashtag(cost:Int, mytext:String){
        text = mytext
        price = cost
    }
    
    override func init( money cost:Int, blah mytext:String) {
        
        text = mytext
        price = cost
    }*/
}
