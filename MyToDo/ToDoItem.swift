//
//  ToDoItem.swift
//  MyToDo
//
//  Created by nju on 2021/10/27.
//

import UIKit

struct ToDoItem {
    var title:String
    var done:Bool
    
    init(_ title:String,_ done:Bool){
        self.title = title
        self.done = done
    }

}
