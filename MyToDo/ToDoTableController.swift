//
//  TableViewController.swift
//  MyToDo
//
//  Created by nju on 2021/10/27.
//

import UIKit

class ToDoTableController: UITableViewController {
    
    var items: [ToDoItem] = []
    
    let datetimeFormatter: DateFormatter = DateFormatter()
    override func viewDidLoad() {
        super.viewDidLoad()

        
        loadItems()
        
        datetimeFormatter.doesRelativeDateFormatting = true
        datetimeFormatter.locale = Locale(identifier: "zh-CN")
//        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(self.endEditing))
//        self.view.addGestureRecognizer(tapGesture)
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
        
        let item = items[indexPath.row]
        cell.titleField.text = item.title
        if item.done {
            cell.doneButton.setImage(UIImage(systemName: "circle.inset.filled"), for: .normal)
        }else{
            cell.doneButton.setImage(UIImage(systemName: "circle"), for: .normal)
        }
        
        datetimeFormatter.dateStyle = item.setDate ? .medium : .none
        datetimeFormatter.timeStyle = item.setTime ? .short : .none
        cell.datetimeLabel.text = datetimeFormatter.string(from: item.datetime)
        cell.datetimeLabel.isHidden = !item.setDate
        
        cell.flagImage.isHidden = !item.flag
        return cell
    }
    
    
    @IBAction func addItem(_ sender: Any) {
        addItem()
    }
    
    func addItem(){
        items.append(ToDoItem())
        let index = IndexPath(row:items.count-1, section:0)
        tableView.insertRows(at: [index], with: .fade)
        let cell = tableView.cellForRow(at: index) as! ToDoCell
        cell.titleField.text = ""
        cell.titleField.becomeFirstResponder()
    }
    
//    @objc func endEditing(){
//        view.endEditing(true)
//    }
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
            guard let cell = sender as? ToDoCell, let indexPath = tableView.indexPath(for: cell) else{
                return
            }
            if(cell.titleField.text!.trimmingCharacters(in: .whitespaces).isEmpty){
                cell.titleField.text = "新建提醒事项"
            }
            view.endEditing(true)
            let navController = segue.destination as! UINavigationController
            let detailController = navController.topViewController as! DetailTableController
            
            let row = indexPath.row
            detailController.row = row
            detailController.item = items[row]
        }
    }
    
    // unwind
    @IBAction func unwindWithCancel(unwindSegue: UIStoryboardSegue){
        
    }
    
    @IBAction func unwindWithDone(unwindSegue: UIStoryboardSegue){
        let detailController = unwindSegue.source as! DetailTableController
        detailController.view.endEditing(true)
        let row = detailController.row
        items[row] = detailController.item
        
        tableView.reloadRows(at: [IndexPath(row: row, section: 0)], with: .fade)
        
    }
    
    @IBAction func switchDone(_ sender: UIButton) {
        
        guard let cell = getCell(forButton: sender), let index = tableView.indexPath(for: cell) else {
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
    
    func getCell(forButton button: UIButton) -> UITableViewCell?{
        return button.superview?.superview?.superview as? UITableViewCell
    }
    
    func getCell(forTextField textField: UITextField) -> UITableViewCell?{
        return textField.superview?.superview?.superview?.superview as? UITableViewCell
    }
   
    func dataPath()->URL{
        return FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first!.appendingPathComponent("ToDoList.json")
    }
    
    func saveItems(){
        view.endEditing(true)
        do{
            let data = try JSONEncoder().encode(items)
            try data.write(to: dataPath(), options: .atomic)
        }catch{
            print("Can not save: \(error.localizedDescription)")
        }
    }
    
    func loadItems(){
        if let data = try? Data(contentsOf: dataPath()){
            do {
                items = try JSONDecoder().decode([ToDoItem].self, from: data)
            }catch{
                print("Can not decode \(error.localizedDescription)")
            }
        }
    }

  
    
}

extension ToDoTableController: UITextFieldDelegate{

    func textFieldDidEndEditing(_ textField: UITextField) {
        
//        print("stop editing " + textField.text!)
        
        guard let cell = getCell(forTextField: textField), let index = tableView.indexPath(for: cell) else{
            return
        }
        let text = textField.text!
        
        if text.trimmingCharacters(in: .whitespaces).isEmpty {
            items.remove(at: index.row)
            tableView.deleteRows(at: [index], with: .fade)
        }else{
            items[index.row].title = text
        }
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        addItem()
        return false
    }

}
