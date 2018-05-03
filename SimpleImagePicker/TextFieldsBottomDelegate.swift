//
//  TextFieldsBottomDelegate.swift
//  SimpleImagePicker
//
//  Created by Ryan Gjoraas on 4/24/18.
//  Copyright © 2018 Developed by Gjoraas. All rights reserved.
//

import UIKit

class TextFieldsBottomDelegate: NSObject, UITextFieldDelegate {
    
    var bottomFieldTextClicked: Bool = false
    
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
      
        return true
    }
    func textFieldDidBeginEditing(_ textField: UITextField) {
        if textField.text!.isEmpty {
            textField.text = ""
        }
        bottomFieldTextClicked = true
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        bottomFieldTextClicked = false
        return true;
    }
    
    
    
}
