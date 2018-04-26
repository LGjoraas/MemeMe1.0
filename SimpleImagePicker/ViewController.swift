//
//  ViewController.swift
//  SimpleImagePicker
//
//  Created by Ryan Gjoraas on 4/16/18.
//  Copyright © 2018 Developed by Gjoraas. All rights reserved.
//

import UIKit

class ViewController: UIViewController, UIImagePickerControllerDelegate,
UINavigationControllerDelegate, UITextFieldDelegate {
 
    // MARK: Properties
    let pickerController = UIImagePickerController()
    let textFieldsTopDelegate = TextFieldsTopDelegate()
    let textFieldsBottomDelegate = TextFieldsBottomDelegate()
    
    // MARK: Attributes
    let memeTextAttributes:[String: Any] = [
        NSAttributedStringKey.strokeColor.rawValue: UIColor.black,
        NSAttributedStringKey.foregroundColor.rawValue: UIColor.white,
        NSAttributedStringKey.font.rawValue: UIFont(name: "HelveticaNeue-CondensedBlack", size: 40)!,
        NSAttributedStringKey.strokeWidth.rawValue: -3.0]
    
    
    // MARK: Outlets and Declarations
    @IBOutlet weak var imagePickerView: UIImageView!
    @IBOutlet weak var takePhotoButton: UIBarButtonItem!
    @IBOutlet weak var topField: UITextField!
    @IBOutlet weak var bottomField: UITextField!
    
    // MARK: ViewDidLoad
    override func viewDidLoad() {
        super.viewDidLoad()
        //to check that imageView is loading properly, give it a color:
        imagePickerView.backgroundColor = #colorLiteral(red: 0, green: 0.9914394021, blue: 1, alpha: 1)
        imagePickerView.clipsToBounds = true
        
        self.topField.delegate = self.textFieldsTopDelegate
        self.bottomField.delegate = self.textFieldsBottomDelegate
        
        topField.defaultTextAttributes = memeTextAttributes
        bottomField.defaultTextAttributes = memeTextAttributes
        
        topField.text = "TOP"
        topField.textAlignment = NSTextAlignment.center
        
        bottomField.text = "BOTTOM"
        bottomField.textAlignment = NSTextAlignment.center
    }
    
    // MARK: ViewWillAppear
    override func viewWillAppear(_ animated: Bool) {
         takePhotoButton.isEnabled = UIImagePickerController.isSourceTypeAvailable(.camera)
        subscribeToKeyboardNotifications()
    }
    
    // MARK: ViewWillDisappear
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        unsubscribeFromKeyboardNotifications()
    }
    
    // MARK: Keybaord Functions
    @objc func keyboardWillShow(_ notification:Notification) {
        imagePickerView.frame.origin.y = -getKeyboardHeight(notification)
    }
    
    @objc func keyboardWillHide(_ notification:Notification) {
        imagePickerView.frame.origin.y = 0
    }
    func getKeyboardHeight(_ notification:Notification) -> CGFloat {
        let userInfo = notification.userInfo
        let keyboardSize = userInfo![UIKeyboardFrameEndUserInfoKey] as! NSValue //of CGRect
        return keyboardSize.cgRectValue.height
    }
    
    func subscribeToKeyboardNotifications() {
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillShow(_:)),
                                               name: .UIKeyboardWillShow, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillHide(_:)),
                                               name: .UIKeyboardWillHide, object: nil)
    }
    
    func unsubscribeFromKeyboardNotifications() {
        NotificationCenter.default.removeObserver(self, name: .UIKeyboardWillShow, object: nil)
        NotificationCenter.default.removeObserver(self, name: .UIKeyboardWillHide, object: nil)
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
    
    // MARK: ImagePicker cancelling after picking image
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        dismiss(animated: true, completion: nil)
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
    
}

    
