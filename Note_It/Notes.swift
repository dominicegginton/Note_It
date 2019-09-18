//
//  Notes.swift
//  Note_It
//
//  Created by Dominic Egginton on 18/09/2019.
//  Copyright © 2019 Dominic Egginton. All rights reserved.
//

import Foundation

struct Note {
    
    var title: String
    var text: String
}

class Notes {
    
    var notes: [Note]
    public static let sharedInstance = Notes()
    
    init() {
        self.notes = []
    }
    
    public func add(note: Note) throws {
        self.notes.append(note)
    }
    
    public func getNote(atIndex index: Int) throws -> Note {
        if self.notes.indices.contains(index) {
            return self.notes[index]
        } else {
            throw NoteError.outOfRange(index)
        }
    }
    
    public var count: Int {
        return self.notes.count
    }
    
    public func clearList() {
        self.notes.removeAll()
    }
    
    public func insert(note newNote: Note, at index: Int) throws {
        if self.notes.indices.contains(index) {
            self.notes.insert(newNote, at: index)
        } else {
            throw NoteError.outOfRange(index)
        }
    }
    
    public func update(note updatedNote: Note, at index: Int) throws {
        if self.notes.indices.contains(index) {
            self.notes[index] = updatedNote
        } else {
            throw NoteError.outOfRange(index)
        }
    }
    
    public func remove(at index: Int) throws {
        if self.notes.indices.contains(index) {
            self.notes.remove(at: index)
        } else {
            throw NoteError.outOfRange(index)
        }
    }
    
    enum NoteError: Error {
        case outOfRange(_ index: Int)
    }
    
}

