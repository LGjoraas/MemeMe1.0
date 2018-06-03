//
//  TableViewController.swift
//  SimpleImagePicker
//
//  Created by Ryan Gjoraas on 5/24/18.
//  Copyright © 2018 Developed by Gjoraas. All rights reserved.
//

import UIKit

class TableViewController: UITableViewController, UITabBarDelegate {

    var memes: [Meme]! {
        let object = UIApplication.shared.delegate
        let appDelegate = object as! AppDelegate
        return appDelegate.memes
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }

    
    // MARK: Table view data source

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return memes.count
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "tableReuseIdentifier", for: indexPath) as! TableViewCell
        let smallMeme = self.memes[(indexPath as NSIndexPath).row]
        cell.memeImage.image = smallMeme.memeImage
        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let memeDetailVC = storyboard?.instantiateViewController(withIdentifier: "memeDetail") as! MemeDetailViewController
            memeDetailVC.memes = self.memes[(indexPath as NSIndexPath).row]
            self.navigationController!.pushViewController(memeDetailVC, animated: true)
    }
    
    
    // MARK: Unwind Segue
    
    @IBAction func unwindMemeEditor(segue: UIStoryboardSegue) {
       tableView!.reloadData()
    }
}
