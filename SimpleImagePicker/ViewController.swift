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
    @IBOutlet weak var toolBar: UIToolbar!
   
    
    // MARK: View Functions
    
    override func viewDidLoad() {
        super.viewDidLoad()
        initialize()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        takePhotoButton.isEnabled = UIImagePickerController.isSourceTypeAvailable(.camera)
        subscribeToKeyboardNotifications()
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.view.endEditing(true)
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        unsubscribeFromKeyboardNotifications()
    }
    
    
    // MARK: TextField Functions
    
    func configureText (textField: UITextField, withText: String) {
        if let textField = topField {
            textField.delegate = textFieldsTopDelegate
        }
        if let textField = bottomField {
            textField.delegate = textFieldsBottomDelegate
        }
        textField.defaultTextAttributes = memeTextAttributes
        textField.textAlignment = NSTextAlignment.center
        textField.text = withText
    }
    
    func initialize() {
        imagePickerView.backgroundColor = #colorLiteral(red: 0.8557942708, green: 0.9914394021, blue: 1, alpha: 1)
        imagePickerView.clipsToBounds = true
        
        configureText(textField: topField, withText: "TOP")
        configureText(textField: bottomField, withText: "BOTTOM")
    }
    
    
    // MARK: Keybaord Functions
    
    @objc func keyboardWillShow(_ notification:Notification) {
        if (textFieldsTopDelegate.topFieldTextClicked) {
            view.frame.origin.y = 0
        }
        if (textFieldsBottomDelegate.bottomFieldTextClicked) {
            view.frame.origin.y = -getKeyboardHeight(notification)
        }
    }
    
    @objc func keyboardWillHide(_ notification:Notification) {
        if (textFieldsTopDelegate.topFieldTextClicked) {
            view.frame.origin.y = 0
        }
        if (textFieldsBottomDelegate.bottomFieldTextClicked) {
            view.frame.origin.y = 0
        }
    }

    func getKeyboardHeight(_ notification:Notification) -> CGFloat {
        let userInfo = notification.userInfo
        let keyboardSize = userInfo![UIKeyboardFrameEndUserInfoKey] as! NSValue //of CGRect
        return keyboardSize.cgRectValue.height
    }
    
    func subscribeToKeyboardNotifications() {
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillShow(_:)), name: .UIKeyboardWillShow, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillHide(_:)), name: .UIKeyboardWillHide, object: nil)
    }
    
    func unsubscribeFromKeyboardNotifications() {
        NotificationCenter.default.removeObserver(self, name: .UIKeyboardWillShow, object: nil)
        NotificationCenter.default.removeObserver(self, name: .UIKeyboardWillHide, object: nil)
    }
    
    
    // MARK: ImagePicker Functions
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : Any]) {
        if let imagePicked = info[UIImagePickerControllerOriginalImage] as? UIImage {
        imagePickerView.image = imagePicked
        imagePickerView.contentMode = .scaleAspectFill
        dismiss(animated: true, completion: nil)
        }
    }
    
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        dismiss(animated: true, completion: nil)
    }
    
    
    // MARK: ImagePicker Actions

    @IBAction func pickAnImageFromAlbum(_ sender: Any) {
       beginPickingImage(sourceType: .photoLibrary)
        
    }
    
    @IBAction func pickAnImageFromCamera(_ sender: UIBarButtonItem) {
        beginPickingImage(sourceType: .camera)
    }
    
    func beginPickingImage(sourceType: UIImagePickerControllerSourceType) {
        let pickerController = UIImagePickerController()
        pickerController.delegate = self
        pickerController.sourceType = sourceType
        present(pickerController, animated: true, completion: nil)
    }
    
    // MARK: Toolbar Functions
    
    func hideToolbars() {
        self.toolBar.isHidden = true
        self.navigationController?.isToolbarHidden = true
    }
    
    func showToolbars() {
        self.toolBar.isHidden = false
        self.navigationController?.isToolbarHidden = false
    }
    
    
    // MARK: Generate Image
    
    func generateMemedImage() -> UIImage {
      
        hideToolbars()
        
        // MARK: Render view to an image
        UIGraphicsBeginImageContext(self.view.frame.size)
        view.drawHierarchy(in: self.view.frame, afterScreenUpdates: true)
        
        let memedImage: UIImage = UIGraphicsGetImageFromCurrentImageContext()!
        UIGraphicsEndImageContext()
        
        showToolbars()
        return memedImage
    }
    
    
    // MARK: Share Image
    
    @IBAction func shareButton(_ sender: Any) {
        
        let memedImage = generateMemedImage()
        
        let imageToShare = memedImage as Any
        let activityViewController = UIActivityViewController(activityItems: [imageToShare], applicationActivities: nil)
        activityViewController.popoverPresentationController?.sourceView = self.view
        activityViewController.completionWithItemsHandler =  {
            (activityType, success: Bool, returnedItems: [Any]?, error: Error?) in
            if success {
                let _ = Meme(topTextField: self.topField.text!, bottomTextField: self.bottomField.text!, originalImage: self.imagePickerView.image!, memeImage: self.generateMemedImage())
            }
        }
        present(activityViewController, animated: true, completion: nil)
    }
    
    
    // MARK: Cancel Button
    
    @IBAction func cancelButton(_ sender: Any) {
        imagePickerView.image = nil
        topField.text = "TOP"
        bottomField.text = "BOTTOM"
    }

}

    
