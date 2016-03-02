//
//  UploadPhotoViewController.swift
//  Instagram-Parse
//
//  Created by Senyang Zhuang on 3/1/16.
//  Copyright © 2016 codepath. All rights reserved.
//

import UIKit
import Parse

class UploadPhotoViewController: UIViewController,UIImagePickerControllerDelegate,UINavigationControllerDelegate {

    @IBOutlet weak var imageView: UIImageView!
    
    @IBOutlet weak var captionTextField: UITextField!
    
    @IBOutlet weak var placeholderLabel: UILabel!
    override func viewDidLoad() {
        super.viewDidLoad()
        let onTapGesture: UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: Selector("onPickPhotos"))
        imageView.addGestureRecognizer(onTapGesture)
        imageView.backgroundColor = UIColor.grayColor().colorWithAlphaComponent(0.3)
        
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func viewWillAppear(animated: Bool) {
        if imageView.image == nil{
            self.placeholderLabel.hidden = false
        }else{
            self.placeholderLabel.hidden = true
        }
    }
    
    func onPickPhotos() {
       
        let vc = UIImagePickerController()
        vc.delegate = self
        vc.allowsEditing = true
        vc.sourceType = UIImagePickerControllerSourceType.PhotoLibrary
        self.presentViewController(vc, animated: true, completion: nil)
        let caption = captionTextField.text!
        
        
    }
    
    
    
    
    @IBAction func onSubmit(sender: AnyObject) {
        let caption = captionTextField.text!
        let newImage = resize(imageView.image!, newSize: CGSize(width: 100, height: 100))
        UserMedia.postUserImage(newImage, withCaption: caption) { (sucess: Bool!, error: NSError?) -> Void in
            if error == nil{
                print("Successfully uploadded an image")
                self.imageView.image = nil
                self.captionTextField.text = nil
                NSNotificationCenter.defaultCenter().postNotificationName("userDidPostNewPhotos", object: nil)
                self.tabBarController?.selectedIndex = 0
            }else{
                print(error)
            
            }
        }
        
        
    }
    
  
    
    func imagePickerController(picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : AnyObject]) {
        let originalImage = info[UIImagePickerControllerOriginalImage] as! UIImage
        let editedImage = info[UIImagePickerControllerOriginalImage] as! UIImage
        imageView.image = originalImage
        self.placeholderLabel.hidden = true
        dismissViewControllerAnimated(true, completion: nil)
    }
    
    func resize(image: UIImage, newSize: CGSize) -> UIImage {
        let resizeImageView = UIImageView(frame: CGRectMake(0, 0, newSize.width, newSize.height))
        resizeImageView.contentMode = UIViewContentMode.ScaleAspectFill
        resizeImageView.image = image
        
        UIGraphicsBeginImageContext(resizeImageView.frame.size)
        resizeImageView.layer.renderInContext(UIGraphicsGetCurrentContext()!)
        let newImage = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        return newImage
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
