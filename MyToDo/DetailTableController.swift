//
//  DetailTableController.swift
//  MyToDo
//
//  Created by nju on 2021/10/30.
//

import UIKit

class DetailTableController: UITableViewController {
    
    @IBOutlet weak var titleField: UITextField!
    @IBOutlet weak var datePickerCell: UITableViewCell!
    @IBOutlet weak var timePickerCell: UITableViewCell!
    
    @IBOutlet weak var timeSwitchCell: UITableViewCell!
    @IBOutlet weak var dateSwitchCell: UITableViewCell!
    
    @IBOutlet weak var dateSwitch: UISwitch!
    @IBOutlet weak var timeSwitch: UISwitch!
    
    @IBOutlet weak var datePicker: UIDatePicker!
    @IBOutlet weak var timePicker: UIDatePicker!
    @IBOutlet weak var flagSwitch: UISwitch!
    
    @IBOutlet weak var dateLabel: UILabel!
    @IBOutlet weak var timeLabel: UILabel!
    
    @IBOutlet weak var doneButton: UIBarButtonItem!
    
    var item: ToDoItem = ToDoItem()
    var row: Int = 0
    
    var showDatePicker: Bool = false{
        didSet{
            switch(oldValue, showDatePicker){
            case(false, true):
                tableView.insertRows(at: [IndexPath(row: 1, section: 1)], with: .fade)
            case (true, false):
                tableView.deleteRows(at: [IndexPath(row: 1, section: 1)], with: .fade)
            default:
                break
            }
        }
        willSet{
            if(newValue == true){
                showTimePicker = false
            }
        }
    }
    var showTimePicker: Bool = false{
        didSet{
            switch(oldValue, showTimePicker){
            case(false, true):
                tableView.insertRows(at: [IndexPath(row: 2, section: 1)], with: .fade)
            case (true, false):
                tableView.deleteRows(at: [IndexPath(row: 2, section: 1)], with: .fade)
            default:
                break
            }
        }
        
        willSet{
            if(newValue == true){
                showDatePicker = false
            }
        }
    }
    var rowInSection1: Int{
        get{
            return showDatePicker || showTimePicker ? 3:2
        }
    }
    
    let dateFormatter = DateFormatter()
    let timeFormatter = DateFormatter()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        titleField.text = item.title
        
        dateFormatter.dateStyle = .medium
        dateFormatter.timeStyle = .none
        dateFormatter.doesRelativeDateFormatting = true
        dateFormatter.locale = Locale(identifier: "zh-CN")
        
        timeFormatter.dateStyle = .none
        timeFormatter.timeStyle = .short
        timeFormatter.doesRelativeDateFormatting = true
        timeFormatter.locale = Locale(identifier: "zh-CN")
        
        // trigger actions
        datetime = item.datetime
        setDate = item.setDate
        setTime = item.setTime
        
        flagSwitch.isOn = item.flag
        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem
    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 3
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        switch(section){
        case 1:
            return rowInSection1
        default:
            return super.tableView(tableView, numberOfRowsInSection: section)
        }
    }

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        switch((indexPath.section, indexPath.row, showDatePicker, showTimePicker)){
        case (1, 0, _, _):
            return dateSwitchCell
            
        case (1, 1, false, _):
            return timeSwitchCell
            
        case (1, 1, true, _):
            return datePickerCell
            
        case (1, 2, _, false):
            return timeSwitchCell
        
        case (1, 2, _, true):
            return timePickerCell
            
        default:
            return super.tableView(tableView, cellForRowAt: indexPath)
        }
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
//        tableView.beginUpdates()
        switch(indexPath){
        case tableView.indexPath(for: dateSwitchCell):
            if(dateSwitch.isOn){
                showDatePicker = !showDatePicker
            }
            
        case tableView.indexPath(for: timeSwitchCell):
            if(timeSwitch.isOn){
                showTimePicker = !showTimePicker
            }
            
        default:
            break
        }
        tableView.deselectRow(at: indexPath, animated: true)
//        tableView.endUpdates()
    }
    
    var setDate: Bool{
        get{
            return item.setDate
        }
        set{
            if(newValue){
                dateSwitch.setOn(true, animated: true)
                dateSwitchCell.selectionStyle = .gray
                
                item.setDate = true
                dateLabel.isHidden = false
            }else{
                showDatePicker = false
                setTime = false
                dateSwitch.setOn(false, animated: true)
                dateSwitchCell.selectionStyle = .none
                
                item.setDate = false
                dateLabel.isHidden = true
            }
        }
    }
    
    var setTime: Bool{
        get{
            return item.setTime
        }
        set{
            if(newValue){
                setDate = true
                timeSwitch.setOn(true, animated: true)
                timeSwitchCell.selectionStyle = .gray
                
                item.setTime = true
                timeLabel.isHidden = false
            }else{
                showTimePicker = false
                timeSwitch.setOn(false, animated: true)
                timeSwitchCell.selectionStyle = .none
                
                item.setTime = false
                timeLabel.isHidden = true
            }

        }
    }
    
    // manually change the switch's status
    @IBAction func dateSwitch(_ sender: UISwitch) {
        setDate = sender.isOn
        if(sender.isOn){
            showDatePicker = true
        }
    }
    
    @IBAction func timeSwitch(_ sender: UISwitch) {
        setTime = sender.isOn;
        if(sender.isOn){
            showTimePicker = true
        }
        
    }
    
    var datetime: Date{
        get{
            return item.datetime
        }
        set{
            item.datetime = newValue
            datePicker.date = newValue
            timePicker.date = newValue
        
            dateLabel.text = dateFormatter.string(from: newValue)
            timeLabel.text = timeFormatter.string(from: newValue)
        }
    }
    
    @IBAction func datePick(_ sender: UIDatePicker) {
        datetime = sender.date
    }
    
    @IBAction func flagSwitch(_ sender: UISwitch) {
        item.flag = sender.isOn
    }
    
    
    /*
    // Override to support conditional editing of the table view.
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return true
    }
    */

    /*
    // Override to support editing the table view.
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            // Delete the row from the data source
            tableView.deleteRows(at: [indexPath], with: .fade)
        } else if editingStyle == .insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        }    
    }
    */

    /*
    // Override to support rearranging the table view.
    override func tableView(_ tableView: UITableView, moveRowAt fromIndexPath: IndexPath, to: IndexPath) {

    }
    */

    /*
    // Override to support conditional rearranging of the table view.
    override func tableView(_ tableView: UITableView, canMoveRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the item to be re-orderable.
        return true
    }
    */

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}

extension DetailTableController: UITextFieldDelegate {
    func textFieldDidEndEditing(_ textField: UITextField) {
        let text = textField.text!
        switch(textField.tag){
        case 0:
            item.title = text
            
            
        case 1:
            item.note = text
            
        case 2:
            item.url = text
            
        default:
            break
        }
    }
    
    @IBAction func titleChanged(_ sender: UITextField) {
        doneButton.isEnabled = !sender.text!.trimmingCharacters(in: .whitespaces).isEmpty
    }
}
