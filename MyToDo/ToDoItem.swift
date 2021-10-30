//
//  ToDoItem.swift
//  MyToDo
//
//  Created by nju on 2021/10/27.
//

struct ToDoItem {
    var title:String = ""
    var done:Bool = false
    var note: String = ""
    var url: String = ""
    var setDate: Bool = false
    var setTime: Bool = false
    var datetime: Double = 0.0
    var flag: Bool = false
    
    init(){
        
    }
    init(_ title:String,_ done:Bool){
        self.title = title
        self.done = done
    }

}
