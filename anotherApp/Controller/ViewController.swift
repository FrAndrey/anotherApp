//
//  ViewController.swift
//  anotherApp
//
//  Created by Andrey on 2020-01-11.
//  Copyright © 2020 Andrey. All rights reserved.
//

import UIKit

class ViewController: UIViewController, UIPickerViewDataSource, UIPickerViewDelegate {
    
    @IBOutlet weak var poemTitle: UILabel!
    @IBOutlet weak var poemText: UITextView!
    @IBOutlet weak var authorField: UITextField!
    @IBOutlet weak var authorPickerView: UIPickerView!
    
    var poemStructure = PoemStructure()
    
    var authors: [String] = ["Pushkin","Brodskij"]
    
     var currentPoemNumber: Int = 0
    
    var currentSelect: String = ""
    
    
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
  
        //переключать current select
        currentSelect = authors[row]
        print(currentSelect)
        
        //сделать видимым author field
        authorField.isHidden = false
        
        //after we hide the  pickerview, we make the text field interactable again
        authorField.isUserInteractionEnabled = true
        
    }
    
    @IBAction func authorFieldClick(_ sender: UITextField) {
        //hide the picker view
        authorPickerView.isHidden = false
        //make text field not editable
        authorField.isUserInteractionEnabled = false
        //make author field invisible
        authorField.isHidden = true
        
       
    }
    

    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //assign random poem of Pushkin after the load, 0 means Pushkin
        currentSelect = authors[0]
        authorField.text = currentSelect
        let number = Int.random(in: 1 ..< 450)
        //поколдовать. Нужно понять текущий номер поэмы чтобы было возможно вернуться к ней
        //ИДЕЯ: чтобы вернуться можно было всего лишь раз
        currentPoemNumber = number
        grabPoem(numberOfPoem: number,cs: currentSelect);
        
       
        
    }

    @IBAction func nextButtonPressed(_ sender: UIButton) {
        
        let number = Int.random(in: 1 ..< 450)
        grabPoem(numberOfPoem: number,cs: currentSelect)
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

    
    
    
    


