//
//  NotesViewController.swift
//  Notes
//
//  Created by Максим Громов on 17.03.2021.
//

import UIKit

class NotesViewController: UIViewController {
  
  @IBOutlet weak var textBody: UITextView!
  @IBOutlet weak var buttonDoneEditing: UIBarButtonItem!
  
  var stroryBodyText : String!
  var delegate : NoteViewDelegate?
  
  override func viewDidLoad() {
    super.viewDidLoad()
    self.textBody.text = self.stroryBodyText
    self.textBody.becomeFirstResponder()
    self.textBody.delegate = self
  }
  
  override func viewWillDisappear(_ animated: Bool) {
    super.viewWillDisappear(animated)
    if self.delegate != nil {
      self.delegate!.didUpdateNoteWithTitle(newTitle: self.navigationItem.title!, andBody: self.textBody.text)
    }
  }
  
  @IBAction func doneEditingBody() {
    self.textBody.resignFirstResponder()
    self.buttonDoneEditing.tintColor = UIColor.clear
    if self.delegate != nil {
      self.delegate!.didUpdateNoteWithTitle(newTitle: self.navigationItem.title!, andBody: self.textBody.text)
    }
  }
  
  func textViewDidBeginEditing(_ textView: UITextView) {
    self.buttonDoneEditing.tintColor = UIColor(red: 0, green: 122.0/255.0, blue: 1, alpha: 1)
  }
  
  func textViewDidChange(_ textView: UITextView) {
    let components = self.textBody.text.components(separatedBy: "\n")
    self.navigationItem.title = ""
    for item in components {
      if item.count > 0 {
        self.navigationItem.title = item
        break
      }
    }
  }
}
