//
//  ViewController.swift
//  SimpleImagePicker
//
//  Created by Ryan Gjoraas on 4/16/18.
//  Copyright © 2018 Developed by Gjoraas. All rights reserved.
//

import UIKit

class ViewController: UIViewController, UIImagePickerControllerDelegate,
UINavigationControllerDelegate {
 
    // MARK: Outlets and Declarations
    @IBOutlet weak var imagePickerView: UIImageView!
    @IBOutlet weak var takePhotoButton: UIBarButtonItem!
    let pickerController = UIImagePickerController()
    
    
    // MARK: ImagePicker function and alert for no camera
    // no camera on simulator:
//    func noCamera(){
//        let alertVC = UIAlertController(title: "No Camera", message: "Sorry, this device has no camera",preferredStyle: .alert)
//        let okAction = UIAlertAction(title: "OK", style:.default, handler: nil)
//        alertVC.addAction(okAction)
//        present(alertVC, animated: true, completion: nil)
//    }
    
    // MARK: ImagePicker cancelling after picking image
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        dismiss(animated: true, completion: nil)
    }
    
    // MARK: ViewDidLoad
    override func viewDidLoad() {
        super.viewDidLoad()
        //to check that imageView is loading properly, give it a color:
        imagePickerView.backgroundColor = UIColor.lightGray
    }
    
    override func viewWillAppear(_ animated: Bool) {
         takePhotoButton.isEnabled = UIImagePickerController.isSourceTypeAvailable(.camera)
    }
    
    // MARK: ImagePicker Functions
    //what happens when picking an image and dismissing
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : Any]) {
        if let image = info[UIImagePickerControllerOriginalImage] as? UIImage {
        imagePickerView.image = image
        imagePickerView.contentMode = .scaleAspectFill
        dismiss(animated: true, completion: nil)
        }
    }
    
    // MARK: ImagePicker IBActions
    //pick button action - what happens when click button
    @IBAction func pickAnImageFromAlbum(_ sender: Any) {
        pickerController.delegate = self
        pickerController.sourceType = .photoLibrary
        present(pickerController, animated: true, completion: nil)
    }
    
    @IBAction func pickAnImageFromCamera(_ sender: UIBarButtonItem) {
        pickerController.delegate = self
        pickerController.allowsEditing = false
        pickerController.sourceType = UIImagePickerControllerSourceType.camera
        pickerController.cameraCaptureMode = .photo
        present(pickerController, animated: true, completion: nil)
    }

    //MARK: Text Field Functions
    
}

    
