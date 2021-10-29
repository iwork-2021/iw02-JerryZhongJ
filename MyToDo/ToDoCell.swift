//
//  TableViewCell.swift
//  MyToDo
//
//  Created by nju on 2021/10/27.
//

import UIKit

class ToDoCell: UITableViewCell {

    @IBOutlet weak var titleField: UITextField!
    @IBOutlet weak var doneButton: UIButton!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    @IBAction func beginEditing(_ sender: Any) {
        self.accessoryType = AccessoryType.detailButton
    }
    
    @IBAction func stopEditing(_ sender: Any) {
        self.accessoryType = AccessoryType.none
    }
    
}
