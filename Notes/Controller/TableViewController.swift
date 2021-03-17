//
//  ViewController.swift
//  Notes
//
//  Created by Максим Громов on 17.03.2021.
//

import UIKit

class TableViewController: UITableViewController {
  
  let notes = Notes()
  var selectedIndex = K.sentinelValue
  
  override func viewDidLoad() {
    super.viewDidLoad()
    if let newNotes = UserDefaults.standard.array(forKey: "notes") as? [[String : String]] {
      self.notes.notes = newNotes
    } else {
      let dictionary = ["title" : "Example Note",
                        "body" : """
                              Example note
                              Hello. This is an exmaple of a note.
                        """]
      self.notes.notes.insert(dictionary, at: K.noteInsertionPositionZero)
    }
  }
  
  override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    return self.notes.notes.count
  }
  
  override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    let cell = tableView.dequeueReusableCell(withIdentifier: "cell")! as UITableViewCell
    cell.textLabel?.text = notes.notes[indexPath.row]["title"]
    return cell
  }
  
  override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
    self.selectedIndex = indexPath.row
    performSegue(withIdentifier: "showEditorSegue", sender: nil)
  }
  
  override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
    let notesEditorViewController = segue.destination as! NotesViewController
    notesEditorViewController.navigationItem.title = notes.notes[self.selectedIndex]["title"]
    notesEditorViewController.stroryBodyText = notes.notes[self.selectedIndex]["body"]
    notesEditorViewController.delegate = self
  }
  
  override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
    if editingStyle == .delete {
      self.notes.notes.remove(at: indexPath.row)
      self.tableView.reloadData()
      self.notes.saveNotes()
    }
  }
  
  @IBAction func newNote() {
    let dictionary = ["title" : "",
                      "body" : ""]
    self.notes.notes.insert(dictionary, at: K.noteInsertionPositionZero)
    self.selectedIndex = K.selectedValueZero
    self.tableView.reloadData()
    self.notes.saveNotes()
    performSegue(withIdentifier: "showEditorSegue", sender: nil)
  }
  
  func didUpdateNoteWithTitle(newTitle: String, andBody newBody: String) {
    self.notes.notes[self.selectedIndex]["title"] = newTitle
    self.notes.notes[self.selectedIndex]["body"] = newBody
    self.tableView.reloadData()
    self.notes.saveNotes()
  }
}

