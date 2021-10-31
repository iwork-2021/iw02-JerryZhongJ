//
//  TableViewController.swift
//  MyToDo
//
//  Created by nju on 2021/10/27.
//

import UIKit

class ToDoTableController: UITableViewController {
    
    var items = [ToDoItem("Hello World", true), ToDoItem("Finish iOS Assignment", false)]
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(self.endEditing))
        self.view.addGestureRecognizer(tapGesture)
        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem
    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return items.count
    }

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "ToDoCell", for: indexPath) as! ToDoCell
        
        let row = indexPath.row
        cell.titleField.text = items[row].title
        if items[row].done {
            cell.doneButton.setImage(UIImage(systemName: "circle.inset.filled"), for: .normal)
        }else{
            cell.doneButton.setImage(UIImage(systemName: "circle"), for: .normal)
        }
        return cell
    }
    
    
    @IBAction func addItem(_ sender: Any) {
        addItem()
    }
    
    func addItem(){
        items.append(ToDoItem("", false))
        let index = IndexPath(row:items.count-1, section:0)
        tableView.insertRows(at: [index], with: .fade)
        let cell = tableView.cellForRow(at: index) as! ToDoCell
        cell.titleField.becomeFirstResponder()
    }
    
    @objc func endEditing(){
        view.endEditing(true)
    }
    /*
    // Override to support conditional editing of the table view.
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return true
    }
    */

    
    // Override to support editing the table view.
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            items.remove(at: indexPath.row)
            tableView.deleteRows(at: [indexPath], with: .fade)
        } else if editingStyle == .insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        }    
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "ShowDetail" {
            view.endEditing(true)
            let navController = segue.destination as! UINavigationController
            let detailController = navController.topViewController as! DetailTableController
            guard let cell = sender as? UITableViewCell, let indexPath = tableView.indexPath(for: cell) else{
                return
            }
            let row = indexPath.row
            detailController.row = row
            detailController.item = items[row]
        }
    }
    
    @IBAction func unwindWithCancel(unwindSegue: UIStoryboardSegue){
        
    }
    
    @IBAction func unwindWithDone(unwindSegue: UIStoryboardSegue){
        let detailController = unwindSegue.source as! DetailTableController
        detailController.endEditing()
        let row = detailController.row
        items[row] = detailController.item
        
        tableView.reloadRows(at: [IndexPath(row: row, section: 0)], with: .fade)
        
    }
    
    @IBAction func switchDone(_ sender: UIButton) {
        let cell = sender.superview!.superview as! UITableViewCell
        guard let index = tableView.indexPath(for: cell) else {
            return
        }
        let row = index.row
        items[row].done = !items[row].done
        
        if items[row].done {
            sender.setImage(UIImage(systemName: "circle.inset.filled"), for: .normal)
        }else{
            sender.setImage(UIImage(systemName: "circle"), for: .normal)
        }
        
    }
    
    
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

extension ToDoTableController: UITextFieldDelegate{

    func textFieldDidEndEditing(_ textField: UITextField) {
        
        print("stop editing " + textField.text!)
        let cell = textField.superview!.superview as! UITableViewCell
        guard let index = tableView.indexPath(for: cell) else{
            return
        }
        let text = textField.text!
        if text.trimmingCharacters(in: .whitespaces).isEmpty {
            items.remove(at: index.row)
            tableView.deleteRows(at: [index], with: .fade)
        }else{
            items[index.row].title = textField.text!
        }
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        addItem()
        return false
    }

}
