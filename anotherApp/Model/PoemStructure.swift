//
//  PoemStructure.swift
//  anotherApp
//
//  Created by Andrey on 2020-03-27.
//  Copyright © 2020 Andrey. All rights reserved.
//

import Foundation
import Firebase

class PoemStructure {
    
    let db = Firestore.firestore()
    
    
    var currentAuthor: String = ""
    var authors: [String] = ["Pushkin","Brodskij"]
    var currentPoem = Poem(title: "", text: "")

    
    // func grabPoem - ждет как аргумент количество поэм, автора, который выбран в данный момент,
    // а так же label для title и text. По странной причине currentPoem не возвращает ничего
    // при этом функция нормально возвращает стих.
    
    func grabPoem(numberOfPoem: Int, cs: String, titleLabel: UILabel, textLabel: UITextView) -> Int{
        
        let docRef = db.collection(cs).document("\(numberOfPoem)")
        
        docRef.getDocument { (document, error) in
            if let document = document, document.exists {
                document.get("text")
                var poem = document.get("text")!
                var title = document.get("title")!
                self.currentPoem = Poem(title: (title as! String), text: (poem as! String).replacingOccurrences(of: "\\n", with: "\n"))
                textLabel.text = self.currentPoem.text
                titleLabel.text = self.currentPoem.title
                
            } else {
                self.currentPoem = Poem (title: "", text: "Поэма не найдена, попробуй еще раз" )
            }
        }
        //to know what number of Poem is
        return numberOfPoem
    }
    
    
    
    
    
    
    
    
    
    
    
    
}
