//
//  MemeDetailViewController.swift
//  SimpleImagePicker
//
//  Created by Ryan Gjoraas on 5/29/18.
//  Copyright © 2018 Developed by Gjoraas. All rights reserved.
//

import UIKit

class MemeDetailViewController: UIViewController {

    
    var memes: Meme!
    
    @IBOutlet weak var detailImage: UIImageView!

    
    override func viewDidLoad() {
        super.viewDidLoad()
        detailImage.image = memes.memeImage
       
    }
}
