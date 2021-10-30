//
//  DetailTableController.swift
//  MyToDo
//
//  Created by nju on 2021/10/30.
//

import UIKit

class DetailTableController: UITableViewController {
    
    @IBOutlet weak var datePickerCell: UITableViewCell!
    @IBOutlet weak var timePickerCell: UITableViewCell!
    
    @IBOutlet weak var timeSwitchCell: UITableViewCell!
    @IBOutlet weak var dateSwitchCell: UITableViewCell!
    var showDatePicker: Bool = false{
        didSet{
            if(showDatePicker){
                showTimePicker = false
            }
            tableView.reloadSections([1], with: .fade)
        }
    }
    var showTimePicker: Bool = false{
        didSet{
            if(showTimePicker){
                showDatePicker = false
            }
            tableView.reloadSections([1], with: .fade)
        }
    }
    var rowInSection1: Int{
        get{
            return showDatePicker || showTimePicker ? 3:2
        }
    }
    override func viewDidLoad() {
        super.viewDidLoad()

        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem
    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 2
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
        
        switch(indexPath.section){
        case 1:
            switch(indexPath.row){
            case 0:
                return dateSwitchCell
            case 1:
                if showDatePicker{
                    return datePickerCell
                }else{
                    return timeSwitchCell
                }
            case 2:
                if(showTimePicker){
                    return timePickerCell
                }else{
                    return timeSwitchCell
                }
            default:
                return UITableViewCell()
            }
        default:
            return super.tableView(tableView, cellForRowAt: indexPath)
        }
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
