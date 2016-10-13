//
//  DetailViewController.swift
//  Instagram
//
//  Created by Ken Lâm on 10/13/16.
//  Copyright © 2016 Ken Lam. All rights reserved.
//

import UIKit
import AFNetworking

class DetailViewController: UIViewController {
    
    var data:NSDictionary!
    @IBOutlet weak var photoImageView: UIImageView!
    @IBOutlet weak var avatarImageView: UIImageView!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var usernameLabel: UILabel!
    @IBOutlet weak var captionLabel: UILabel!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        usernameLabel.text = data.value(forKeyPath: "user.username") as? String
        nameLabel.text = data.value(forKeyPath: "user.full_name") as? String
        captionLabel.text = data.value(forKeyPath: "caption.text") as? String
        photoImageView.setImageWith(URL(string: data.value(forKeyPath: "images.standard_resolution.url") as! String)!)
        avatarImageView.setImageWith(URL(string: data.value(forKeyPath: "user.profile_picture") as! String)!)
        
        
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
