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
    
    func textFieldDidBeginEditing(_ textField: UITextField) {
        if textField.text!.isEmpty {
            textField.text = ""
        }
        bottomFieldTextClicked = true
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        bottomFieldTextClicked = false
        textField.resignFirstResponder()
        return true;
    }

}
