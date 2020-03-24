//
//  ViewController.swift
//  anotherApp
//
//  Created by Andrey on 2020-01-11.
//  Copyright © 2020 Andrey. All rights reserved.
//

import UIKit
import Firebase

class ViewController: UIViewController, UIPickerViewDataSource, UIPickerViewDelegate {
    
    let db = Firestore.firestore()
    
    @IBOutlet weak var poemTitle: UILabel!
    @IBOutlet weak var poemText: UITextView!
    @IBOutlet weak var authorField: UITextField!
    @IBOutlet weak var authorPickerView: UIPickerView!
    
    var authors: [String] = ["Pushkin","Brodskij"]
    
    var currentSelect: String = ""
    
    func grabPoem(numberOfPoem: Int) {
    
    currentSelect = authors[0]
        
     let docRef = db.collection(currentSelect).document("\(numberOfPoem)")
     docRef.getDocument { (document, error) in
         if let document = document, document.exists {
             var poem = document.get("text")!
             var title = document.get("title")!
             self.poemText.text = (poem as! String).replacingOccurrences(of: "\\n", with: "\n")
            self.poemTitle.text = (title as! String)
         } else {
                self.poemText.text = "Поэма не найдена"
         }
      }
    }
       func numberOfComponents(in pickerView: UIPickerView) -> Int {
             return 1
         }

      func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int{
        var countRows : Int = authors.count
        return countRows
     }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        
        let titleRow = authors[row]
        return titleRow
        
    }

    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        
        authorField.text = authors[row]
        authorPickerView.isHidden = true
        
        //переключать current select, разобраться почему не вызывается база данных
        currentSelect = authors[row]
        
        
        //after we hide the  pickerview, we make the text field interactable again
        authorField.isUserInteractionEnabled = true
        
    }
    
    @IBAction func authorFieldClick(_ sender: UITextField) {
        //hide the picker view
        authorPickerView.isHidden = false
        //make text field not editable
        authorField.isUserInteractionEnabled = false
        
    currentSelect = authorField.text!
    }
    

    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //assign random poem of Pushkin after the load
        authorField.text = authors[0]
        let number = Int.random(in: 1 ..< 450)
        grabPoem(numberOfPoem: number);
        
       
        
    }

    @IBAction func nextButtonPressed(_ sender: UIButton) {
        
        let number = Int.random(in: 1 ..< 450)
        grabPoem(numberOfPoem: number);
        
        
        
    }

   
        
            
    public struct Poem: Codable {

        let title: String
        let text: String?
        
        enum CodingKeys: String, CodingKey {
            case title
            case text
        }

    }
    
}

    
    
    
    


