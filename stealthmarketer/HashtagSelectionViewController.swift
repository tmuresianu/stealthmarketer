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
    
    @IBAction func postToInstagram () {
        println("postToInstagram called")
    }
    
    override func viewDidLoad(){
        
        super.viewDidLoad()
    
        for row in hashtags {
            selectedRows.addObject(NSNumber(bool: false))
        }
        
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
    
        let cell:UITableViewCell = UITableViewCell(style: UITableViewCellStyle.Default, reuseIdentifier: "cell")
        
        let currentHashtag:hashtag = hashtags.objectAtIndex(indexPath.row) as! hashtag

        cell.textLabel!.text = currentHashtag.text
        
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
        
        self.tableView?.reloadRowsAtIndexPaths([indexPath], withRowAnimation: UITableViewRowAnimation.Fade)
        
        reloadPrice()
    }
    
    func reloadPrice(){
        
        priceLabel!.text = "$\(currentTotal%100).\(currentTotal/100)"
        
    }
}

class hashtag {
    
    var text:String = ""
    var price:Int = 0
    
}
