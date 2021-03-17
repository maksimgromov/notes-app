//
//  Notes.swift
//  Notes
//
//  Created by Максим Громов on 17.03.2021.
//

import UIKit

class Notes {
  var notes = [[String : String]]()
  
  func saveNotes() {
    UserDefaults.standard.set(self.notes, forKey: "notes")
    UserDefaults.standard.synchronize()
  }
}
