//
//  NoteController.swift
//  Note_It
//
//  Created by Dominic Egginton on 18/09/2019.
//  Copyright © 2019 Dominic Egginton. All rights reserved.
//

import UIKit

protocol UpdateDelagate {
    func update(with note: Note, at index: Int)
}

class NoteController: UIViewController, UITextFieldDelegate, UITextViewDelegate, DeleteDelegate{
    

    @IBOutlet weak var doneButton: UIBarButtonItem!
    @IBOutlet weak var noteTextView: UITextView!
    @IBOutlet weak var noteTitleTextFeild: UITextField!
    @IBOutlet weak var noteTextViewBottomConstraint: NSLayoutConstraint!
    
    public var noteID: Int?
    var updateDelagate: UpdateDelagate?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // set text feilds delegates
        self.noteTitleTextFeild.delegate = self
        self.noteTextView.delegate = self
        
        // set text feilds to hidden
        self.noteTitleTextFeild.isHidden = true
        self.noteTextView.isHidden = true
        
        // set clear color for done button
        self.doneButton.tintColor = UIColor.clear
        
        // add notification observers for keyabord show and hide
        NotificationCenter.default.addObserver(self, selector: #selector(keybaordWillShow(_:)), name: UIResponder.keyboardWillShowNotification, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(keybaordWillHide(_:)), name: UIResponder.keyboardWillHideNotification, object: nil)
        
        if let id: Int = noteID {
            print("view did load with note \(id)")
            
            //unhide text feilds
            self.noteTitleTextFeild.isHidden = false
            self.noteTextView.isHidden = false
            
            // load note data into text feilds
            if let note = try? Notes.sharedInstance.getNote(atIndex: id) {
                self.title = note.title
                if note.title == "New Note" {
                    self.noteTitleTextFeild.text = ""
                } else {
                    self.noteTitleTextFeild.text = note.title
                }
                self.noteTextView.text = note.text
                
            }
        }
    }
    
    func saveNote() {
        var noteTitle = self.noteTitleTextFeild.text ?? "New Note"
        if noteTitle == "" {
            noteTitle = "New Note"
        }
        
        let noteText = self.noteTextView.text ?? ""
        
        self.title = noteTitle
        
        let note = Note(title: noteTitle, text: noteText)
        if let id = self.noteID {
            print("Saveing Note with \(id)")
            self.updateDelagate?.update(with: note, at: id)
        }
    }
    
    func textFieldDidEndEditing(_ textField: UITextField) {
        print("editing note title finished")
        
        // save note
        self.saveNote()
    }
    
    func textViewDidEndEditing(_ textView: UITextView) {
        print("editing note text finished")
        
        // save note
        self.saveNote()
    }
    
    // When done button is pressed dismiss keybaord
    @IBAction func dismissKeybaord(_ sender: UIBarButtonItem) {
        self.noteTextView.resignFirstResponder()
        self.noteTitleTextFeild.resignFirstResponder()
        
        // save note
        self.saveNote()
    }
    
    @objc func keybaordWillShow(_ notification: NSNotification) {
        print("showing keyabord")
        self.doneButton.tintColor = nil
        
        // ajust constraint for noteTextView for keyabord
        if let info = notification.userInfo {
            if let keybaordInfo = info[UIResponder.keyboardFrameBeginUserInfoKey] as! NSValue? {
                let hight = keybaordInfo.cgRectValue.height
                print("keyabord is \(hight)dp high")
                self.noteTextViewBottomConstraint.constant = hight + 10
            }
        }
    }
    
    @objc func keybaordWillHide(_ notification: NSNotification) {
        print("hiding keyabord")
        self.doneButton.tintColor = UIColor.clear
        
        // ajust constraint for noteTextView for keyabord
        self.noteTextViewBottomConstraint.constant = 20
    }
    
    func deleteNote(at index: Int) {
        if index == self.noteID {
            self.noteTitleTextFeild.text = ""
            self.noteTitleTextFeild.isHidden = true
            self.noteTextView.text = ""
            self.noteTextView.isHidden = true
            self.title = ""
            print("clearing note view")
        }
    }
    
}
