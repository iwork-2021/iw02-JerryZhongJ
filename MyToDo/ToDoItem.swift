//
//  ToDoItem.swift
//  MyToDo
//
//  Created by nju on 2021/10/27.
//

import UIKit

class ToDoItem: NSObject {
    var title:String
    var done:Bool
    
    init(_ title:String,_ done:Bool){
        self.title = title
        self.done = done
    }

}
