//
//  TableViewController.swift
//  SimpleImagePicker
//
//  Created by Ryan Gjoraas on 5/24/18.
//  Copyright © 2018 Developed by Gjoraas. All rights reserved.
//

import UIKit

class TableViewController: UITableViewController {

    var memes: [Meme]! {
        let object = UIApplication.shared.delegate
        let appDelegate = object as! AppDelegate
        return appDelegate.memes
    }
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    // MARK: - Table view data source

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return memes.count
    }

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "tableReuseIdentifier", for: indexPath) as! TableViewCell
        
        let smallMeme = self.memes[(indexPath as NSIndexPath).row]
        
        // set the name and image
        cell.topLabel.text = smallMeme.topTextField
        cell.bottomLabel.text = smallMeme.bottomTextField
        cell.memeImage.image = smallMeme.memeImage
        
        return cell
    }
 
    // Displays meme detail view controller by selecting row
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let memeDetailVC = storyboard?.instantiateViewController(withIdentifier: "memeDetail") as! MemeDetailViewController
            memeDetailVC.memes = self.memes[(indexPath as NSIndexPath).row]
            self.navigationController!.pushViewController(memeDetailVC, animated: true)
    
    }
    
    @IBAction func unwindMemeEditor(segue: UIStoryboardSegue) {
        
    }

}
