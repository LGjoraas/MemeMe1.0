//
//  CollectionViewController.swift
//  SimpleImagePicker
//
//  Created by Ryan Gjoraas on 5/24/18.
//  Copyright © 2018 Developed by Gjoraas. All rights reserved.
//

import UIKit

private let reuseIdentifier = "collectionReuseIdentifier"

class CollectionViewController: UICollectionViewController {

    var memes: [Meme]! {
        let object = UIApplication.shared.delegate
        let appDelegate = object as! AppDelegate
        return appDelegate.memes
    }
    
    @IBOutlet weak var flowLayout: UICollectionViewFlowLayout!

    override func viewDidLoad() {
        super.viewDidLoad()

        let space:CGFloat = 4.0
        let dimensionWidth = (view.frame.size.width - (3 * space)) / 3.0
        let dimensionHeight = (view.frame.size.height - (3 * space)) / 2.0
        
        flowLayout.minimumInteritemSpacing = space
        flowLayout.minimumLineSpacing = space
        flowLayout.itemSize = CGSize(width: dimensionWidth, height: dimensionHeight)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        collectionView?.reloadData()
    }

    
//    MARK: UICollectionViewDataSource

    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return memes.count
    }

    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: reuseIdentifier, for: indexPath) as! CollectionViewCell
        let smallMeme = self.memes[(indexPath as NSIndexPath).row]
        cell.memeImage?.image = smallMeme.memeImage
        return cell
    }

    override func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let memeGeneratorVC = storyboard?.instantiateViewController(withIdentifier: "memeDetail") as! MemeDetailViewController
        memeGeneratorVC.memes = self.memes[(indexPath as NSIndexPath).row]
        self.navigationController!.pushViewController(memeGeneratorVC, animated: true)
    }
}
