//
//  PhotosViewController.swift
//  Instagram
//
//  Created by Ken Lâm on 10/13/16.
//  Copyright © 2016 Ken Lam. All rights reserved.
//

import UIKit
import AFNetworking

class PhotosViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    
    @IBOutlet weak var photosTableView: UITableView!
    var photos = [NSDictionary]()
    let refreshControl = UIRefreshControl()

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        photosTableView.delegate = self
        photosTableView.dataSource = self
        fetchData()
        refreshControl.addTarget(self, action: #selector(PhotosViewController.fetchData), for: UIControlEvents.valueChanged)
        photosTableView.insertSubview(refreshControl, at: 0)

    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func fetchData() {
        let accessToken = "435569061.c66ada7.d12d19c8687e427591f254586e4f3e47"
        let userId = "435569061"
        let url = URL(string: "https://api.instagram.com/v1/users/\(userId)/media/recent/?access_token=\(accessToken)")
        if let url = url {
            let request = URLRequest(
                url: url,
                cachePolicy: NSURLRequest.CachePolicy.reloadIgnoringLocalCacheData,
                timeoutInterval: 10)
            let session = URLSession(
                configuration: URLSessionConfiguration.default,
                delegate: nil,
                delegateQueue: OperationQueue.main)
            let task = session.dataTask(
                with: request,
                completionHandler: { (dataOrNil, response, error) in
                    if let data = dataOrNil {
                        if let responseDictionary = try! JSONSerialization.jsonObject(with: data, options: []) as? NSDictionary {
                            print("response: \(responseDictionary)")
                            if let photoData = responseDictionary["data"] as? [NSDictionary] {
                                self.photos = photoData
                                self.photosTableView.reloadData()
                                self.refreshControl.endRefreshing()
                            }
                        }
                    }
            })
            task.resume()
        }
    }
    
    public func numberOfSections(in tableView: UITableView) -> Int {
        return photos.count
    }
    
    public func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    
    public func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 170
    }
    
    public func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let data = photos[section] 
        
        let headerView = UIView(frame: CGRect(x: 0, y: 0, width: 320, height: 50))
        headerView.backgroundColor = UIColor(white: 1, alpha: 0.9)

        let profileView = UIImageView(frame: CGRect(x: 10, y: 10, width: 32, height: 32))
        profileView.clipsToBounds = true
        profileView.layer.cornerRadius = 15
        profileView.layer.borderColor = UIColor(white: 0.7, alpha: 0.8).cgColor
        profileView.layer.borderWidth = 1
        profileView.setImageWith(URL(string: data.value(forKeyPath: "user.profile_picture") as! String)!)
        
        let usernameView = UILabel(frame: CGRect(x: 48, y: 15, width: 200, height: 22))
        usernameView.text = (data.value(forKeyPath: "user.username") as! String)
        
        headerView.addSubview(profileView)
        headerView.addSubview(usernameView)
        return headerView
    }
    
    public func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 50
    }
    
    public func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = photosTableView.dequeueReusableCell(withIdentifier: "photoCell", for: indexPath) as! PhotoViewCell
        let data = photos[indexPath.section] as NSDictionary
        cell.photoImageView.setImageWith(URL(string: data.value(forKeyPath: "images.thumbnail.url") as! String)!)
        cell.accessoryType = UITableViewCellAccessoryType.none
        return cell
    }

    

    /*
    // MARK: - Navigation
    */
    
    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let nextVC = segue.destination as! DetailViewController
        let index = photosTableView.indexPathForSelectedRow?.section
        let data = photos[index!] as NSDictionary
        nextVC.data = data
        
    }

}
