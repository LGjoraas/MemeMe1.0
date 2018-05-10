//
//  textFieldsViewController.swift
//  SimpleImagePicker
//
//  Created by Ryan Gjoraas on 4/24/18.
//  Copyright © 2018 Developed by Gjoraas. All rights reserved.
//

import UIKit

class TextFieldsTopDelegate: NSObject, UITextFieldDelegate {
    
//     func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
//
//        return true
//    }
    
    var topFieldTextClicked: Bool = false
  
    func textFieldDidBeginEditing(_ textField: UITextField) {
        if textField.text!.isEmpty {
            textField.text = "";
        }
        topFieldTextClicked = true
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        topFieldTextClicked = false
        return true;
    }
    
    
}
