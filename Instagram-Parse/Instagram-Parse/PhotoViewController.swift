//
//  PhotoViewController.swift
//  Instagram-Parse
//
//  Created by Senyang Zhuang on 2/29/16.
//  Copyright © 2016 codepath. All rights reserved.
//

import UIKit
import Parse

class PhotoViewController: UIViewController, UITableViewDataSource, UITableViewDelegate{
    
    var user = PFUser.currentUser()
    var media = [PFObject]()
    
    @IBOutlet weak var tableView: UITableView!
    
    override func viewDidLoad() {
    
        super.viewDidLoad()
        tableView.dataSource = self
        tableView.delegate = self
        fetchData()
       
       
        
        
    }
    


    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = self.tableView.dequeueReusableCellWithIdentifier("PhotoViewCell", forIndexPath: indexPath) as! PhotoViewCell
        let data = self.media[indexPath.row]
        let file = data["media"] as! PFFile
        file.getDataInBackgroundWithBlock({
            (result, error) in
            cell.photoView.image = UIImage(data: result!)
        })
        
        cell.captionLabel.text = data["caption"] as! String
        
        return cell
    }
    
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return media.count
    }
    
    func fetchData(){
        
        // construct PFQuery
        let query = PFQuery(className: "UserMedia")
        query.orderByDescending("createdAt")
        query.includeKey("author")
        query.limit = 20
        // fetch data asynchronously
        query.findObjectsInBackgroundWithBlock { (media: [PFObject]?, error: NSError?) -> Void in
            if let media = media {
                // do something with the data fetched
              
                self.media = media
                self.tableView.reloadData()
            } else {
                // handle error
                print(error)
            }
        }
    }
    
    
    
    

    @IBAction func onLogout(sender: AnyObject) {
        PFUser.logOut()
        self.performSegueWithIdentifier("logoutSegue", sender: nil)
        
    }

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
