//
//  ToDoItem.swift
//  MyToDo
//
//  Created by nju on 2021/10/27.
//
import Foundation
struct ToDoItem: Codable{
    var title:String = ""
    var done:Bool = false
    var note: String = ""
    var url: String = ""
    var setDate: Bool = false
    var setTime: Bool = false
    // rounded to future 5 minutes
    var datetime: Date = Date(timeIntervalSinceReferenceDate:  (Date.now.timeIntervalSinceReferenceDate / 300.0).rounded(.up) * 300.0)
    var flag: Bool = false
    
    init(){
        
    }
    init(_ title:String,_ done:Bool){
        self.title = title
        self.done = done
    }

}
