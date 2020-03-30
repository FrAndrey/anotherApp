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
    @IBOutlet weak var switchLabel: UITextField!
    
    @IBAction func shortLongCollectionSwitch(_ sender: UISwitch) {
        switchLabel.text = "Включая длинные"
    }
    
    
    
    var poemStructure = PoemStructure()
    static var currentSelect: String = ""
    
    
    
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int{
        var countRows : Int = poemStructure.authors.count
        return countRows
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        
        let titleRow = poemStructure.authors[row]
        return titleRow
        
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        
        authorField.text = poemStructure.authors[row]
        authorPickerView.isHidden = true
        
        //переключать current select
        ViewController.currentSelect = poemStructure.authors[row]
       // print(ViewController.currentSelect)
        
        //сделать видимым author field
        authorField.isHidden = false
        
        //after we hide the  pickerview, we make the text field interactable again
        authorField.isUserInteractionEnabled = true
        
         //after author is changed, загружаем случайную цитату для нового автора
        var number = Int.random(in: 1 ..< 300)
        var currentPoemNumber = poemStructure.grabPoem(numberOfPoem: number, cs: ViewController.currentSelect,
          titleLabel: poemTitle, textLabel: poemText )
        print("Number of Poem: \(currentPoemNumber)")
        
        
    }
    
    @IBAction func authorFieldClick(_ sender: UITextField) {
        //hide the picker view
        authorPickerView.isHidden = false
        //make text field not editable
        authorField.isUserInteractionEnabled = false
        //make author field invisible
        authorField.isHidden = true
        
    }
    
    
    func updateUI(_ poem: Poem) {
        
        poemTitle.text = poem.title
        poemText.text = poem.text
        
    }
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //assign random poem of Pushkin after the load, 0 means Pushkin
        ViewController.currentSelect = poemStructure.authors[0]
        authorField.text = ViewController.currentSelect

        var number = Int.random(in: 1 ..< 300)
         var currentPoemNumber =    poemStructure.grabPoem(numberOfPoem: number, cs: ViewController.currentSelect,
        titleLabel: poemTitle, textLabel: poemText )
        
        print("Number of Poem: \(currentPoemNumber)")
        print(poemStructure.currentPoem.title)
        
        
    }
    
    @IBAction func nextButtonPressed(_ sender: UIButton) {
        
        let number = Int.random(in: 1 ..< 450)
       var currentPoemNumber = poemStructure.grabPoem(numberOfPoem: number, cs: ViewController.currentSelect,
       titleLabel: poemTitle, textLabel: poemText )
        
        print("Number of Poem: \(currentPoemNumber)")
        
        //ВАЖНО как поэму, poemStructure.currentPoem возвращает ПРЕДЫДУЩУЮ,
        // а не ту что сейчас на экране
        //это хорошо - потому что можно вернуться назад единожды
        // или - загружать эти поэмы в List, и возможнось делать мультиклик назад
        // но тогда - нужно будет запоминать и автора.
         print(poemStructure.currentPoem.title)
        print(poemStructure.currentPoem.text)
        
    }
    
    
    
    
    
  /*  public struct Poem: Codable {
        
        let title: String
        let text: String?
        
        enum CodingKeys: String, CodingKey {
            case title
            case text
        }
        
    } */
    
}







