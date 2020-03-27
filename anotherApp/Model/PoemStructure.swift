//
//  PoemStructure.swift
//  anotherApp
//
//  Created by Andrey on 2020-03-27.
//  Copyright © 2020 Andrey. All rights reserved.
//

import Foundation
import Firebase

struct PoemStructure {
    
    let db = Firestore.firestore()
    
    
    var currentAuthor: String = ""
    
    
     func grabPoem(numberOfPoem: Int, cs: String) {
        
        
        let docRef = db.collection(cs).document("\(numberOfPoem)")
        docRef.getDocument { (document, error) in
            if let document = document, document.exists {
                document.get("text")
                var poem = document.get("text")!
                var title = document.get("title")!
                var currentPoem = Poem(title: (title as! String), text: (poem as! String).replacingOccurrences(of: "\\n", with: "\n"))
                
              //  self.poemText.text = currentPoem.text
               // self.poemTitle.text = currentPoem.title
            } else {
                //self.poemText.text = "Поэма не найдена"
            }
        }
    }
    
    
    
    
    
    
    
    
    
    
    
    
}