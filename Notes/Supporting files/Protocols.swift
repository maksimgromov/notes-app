//
//  Protocols.swift
//  Notes
//
//  Created by Максим Громов on 17.03.2021.
//

import UIKit

protocol NoteViewDelegate {
  func didUpdateNoteWithTitle(newTitle : String, andBody newBody : String)
}
