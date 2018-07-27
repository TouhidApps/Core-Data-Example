//
//  ViewController.swift
//  CoreDataiOS
//
//  Created by Touhid on 7/23/18.
//  Copyright © 2018 Touhid Apps!. All rights reserved.
//

import UIKit
import CoreData

class ViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    var students = [Student]()

    @IBOutlet weak var tableView: UITableView!
    
    @IBAction func addStudents(_ sender: UIBarButtonItem) {
        
        let alertController = UIAlertController(title: "Add Student", message: "", preferredStyle: .alert)
        alertController.addTextField { (textField: UITextField) in
            textField.placeholder = "Name"
        }
        alertController.addTextField { (textField: UITextField) in
            textField.placeholder = "Phone"
        }
        alertController.addTextField { (textField: UITextField) in
            textField.placeholder = "Address"
        }
        
        let dismiss = UIAlertAction(title: "Cancel", style: UIAlertActionStyle.cancel) { (action) in
            alertController.dismiss(animated: true, completion: nil)
        }
        let add = UIAlertAction(title: "Save", style: UIAlertActionStyle.default) { (action) in
            // Save data
            
            let name = alertController.textFields![0]
            let phone = alertController.textFields![1]
            let address = alertController.textFields![2];
        
            self.addNewStudent(name: name.text!, phone: phone.text!, address: address.text!)
        
            self.students = self.fetchData()
            self.tableView.reloadData()
        }

        
        alertController.addAction(dismiss)
        alertController.addAction(add)
        
        self.present(alertController, animated: true, completion: nil)

        
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.tableView.delegate = self
        self.tableView.dataSource = self
        
        self.students = self.fetchData()
        self.tableView.reloadData()
        
        
    }

    
    func addNewStudent(name: String, phone: String, address: String){
        
        let managedContext = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
        guard let entity = NSEntityDescription.entity(forEntityName: "Student", in: managedContext) else {return}
        let student = Student(entity: entity, insertInto: managedContext)
        student.name = name
        student.phone = phone
        student.address = address
        self.save()
    }
    

    func fetchData() -> [Student]{
        
        let managedContext = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
        
        do{
            let students = try managedContext.fetch(Student.fetchRequest())
            return students as! [Student]
        } catch let error as NSError{
            print("Could not fetch \(error)")
            return []
        }
    }
    
    func deleteData(_ student: Student) {
        let managedContext = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
        managedContext.delete(student)
        self.save()
    }
    
    func save(){
         let managedContext = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
        do {
            try managedContext.save()
        }catch{
            print("Failded saving")
        }
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.students.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "StudentTableViewCell", for: indexPath) as! StudentTableViewCell
        
        let student = self.students[indexPath.row]
        cell.setDataToView(name: student.name!, phone: student.phone!, address: student.address!)
        
        return cell
    }

    func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        return true
    }
    
//    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
//        if editingStyle == .delete{
//            print("Deleted")
//            self.deleteData(self.students[indexPath.row])
//            self.students.remove(at: indexPath.row)
//            self.tableView.beginUpdates()
//            self.tableView.deleteRows(at: [indexPath], with: .automatic)
//            self.tableView.endUpdates()
//        }
//    }
    
    func tableView(_ tableView: UITableView, editActionsForRowAt indexPath: IndexPath) -> [UITableViewRowAction]? {
        let editAction = UITableViewRowAction(style: .normal, title: "Edit") { (action, indexPath) in
            print("Edit")
            let alertController = UIAlertController(title: "Edit Student", message: "", preferredStyle: .alert)
            alertController.addTextField { (textField: UITextField) in
                textField.text = self.students[indexPath.row].name
            }
            alertController.addTextField { (textField: UITextField) in
                textField.text = self.students[indexPath.row].phone
            }
            alertController.addTextField { (textField: UITextField) in
                textField.text = self.students[indexPath.row].address
            }
            
            let dismiss = UIAlertAction(title: "Cancel", style: UIAlertActionStyle.cancel) { (action) in
                alertController.dismiss(animated: true, completion: nil)
            }
            let add = UIAlertAction(title: "Save", style: UIAlertActionStyle.default) { (action) in
                // Save data
                
                let name = alertController.textFields![0]
                let phone = alertController.textFields![1]
                let address = alertController.textFields![2];
                
                self.students[indexPath.row].name = name.text
                self.students[indexPath.row].phone = phone.text
                self.students[indexPath.row].address = address.text
                self.save()
                
                self.tableView.reloadData()
            }
            
            
            alertController.addAction(dismiss)
            alertController.addAction(add)
            
            self.present(alertController, animated: true, completion: nil)

        }
        let deleteAction = UITableViewRowAction(style: .default, title: "Delete") { (action, indexPath) in
            print("Deleted")
            self.deleteData(self.students[indexPath.row])
            self.students.remove(at: indexPath.row)
            
            self.tableView.beginUpdates()
            self.tableView.deleteRows(at: [indexPath], with: .automatic)
            self.tableView.endUpdates()
        }

        return [deleteAction, editAction]
    }
    
}









