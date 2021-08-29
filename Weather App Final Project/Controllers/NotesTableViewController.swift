//
//  NotesTableViewController.swift
//  Weather App Final Project
//
//  Created by linda.zande on 26/08/2021.
//

import UIKit
import CoreData


class NotesTableViewController: UITableViewController {

    //var notes = [String]()
var notes = [Note]()
var manageObjectContext: NSManagedObjectContext?
    
    override func viewDidLoad() {
        super.viewDidLoad()

        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        manageObjectContext = appDelegate.persistentContainer.viewContext
        
        loadData()
    }
    func loadData(){
        let request: NSFetchRequest<Note> = Note.fetchRequest()
        do {
            let result = try manageObjectContext?.fetch(request)
            notes = result!
            tableView.reloadData()
        }catch{
            fatalError("Error in retriving Notes")
        }
    }
    
    func saveData(){
        do{
        try manageObjectContext?.save()
        }catch{
            fatalError("Error in saving Note item")
            
        }
        loadData()
    }
    
    func deleteAllData() {
        let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: "Note")
        let request: NSBatchDeleteRequest = NSBatchDeleteRequest(fetchRequest: fetchRequest)
        do {
            try manageObjectContext?.execute(request)
            saveData()
        } catch let error {
            print(error.localizedDescription)
            
        }
    }
    @IBAction func addNewItem(_ sender: Any) {
        
        let alertController = UIAlertController(title: "Note", message: "Anything to add?", preferredStyle: .alert)
        alertController.addTextField { textField in
            print(textField)
        }
        
        let addActionButton = UIAlertAction(title: "Add", style: .default) { alertAction in
            let textField = alertController.textFields?.first
            let entity = NSEntityDescription.entity(forEntityName: "Note", in: self.manageObjectContext!)
            
          let note = NSManagedObject(entity: entity!, insertInto: self.manageObjectContext)
            
            note.setValue(textField?.text, forKey: "item")
            self.saveData()
           // self.notes.append(textField!.text!)
           // self.tableView.reloadData()
        }//addaction
        
        let cancelButton = UIAlertAction(title: "Cancel", style: .destructive, handler: nil)
        alertController.addAction(addActionButton)
        alertController.addAction(cancelButton)
        present(alertController, animated: true, completion: nil)
    }
    //deletAllItem button
    @IBAction func deleteAllItem(_ sender: Any) {
    
    let alertController = UIAlertController(title: "Delete All Notes", message: "Are you sure you want to delete them all?", preferredStyle: .actionSheet)
    let addActionButton = UIAlertAction(title: "Delete", style: .default) { alertAction in
        self.deleteAllData()
        
    }
    
    let cancelButton = UIAlertAction(title: "Cancel", style: .destructive, handler: nil)
    
    alertController.addAction(addActionButton)
    alertController.addAction(cancelButton)
    
    present(alertController, animated: true, completion: nil)
}

    // MARK: - Table view data source


    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return notes.count
        
       
    }

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "noteCell", for: indexPath)

       // cell.textLabel?.text = notes[indexPath.row]
        // Configure the cell...
        let note = notes[indexPath.row]
        cell.textLabel?.text = note.value(forKey: "item") as? String
        cell.accessoryType = note.completed ? .checkmark : .none
        return cell
    }
    



    
    // Override to support editing the table view.
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            manageObjectContext?.delete(notes[indexPath.row])
 
        }
        self.saveData()
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        notes[indexPath.row].completed = !notes[indexPath.row].completed
        self.saveData()
    }
   
}

