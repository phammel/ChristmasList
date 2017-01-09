//
//  NameViewController.swift
//  To Do List
//
//  Created by Phammel on 11/28/16.
//  Copyright © 2016 Phammel. All rights reserved.
//

import UIKit

class NameViewController: UIViewController,  UITableViewDelegate, UITableViewDataSource
{

    
    
    @IBOutlet weak var PersonTableView: UITableView!
    
    @IBOutlet weak var edditButton: UIBarButtonItem!
    
    @IBOutlet weak var NamesImageView: UIImageView!
    
    var personArray = [Person](){
        didSet{
            save()
        }
    }
    
    
    

//----------------------viewDidLoad-------------------------------------------------------
//-----------------------------------------------------------------------------------------
    override func viewDidLoad()
    {
       
        
        
        load()
        NamesImageView.animationImages = [
        UIImage(named: "1")!,
        UIImage(named: "2")!,
        UIImage(named: "3")!,
        UIImage(named: "2")! ]
        
        NamesImageView.animationDuration = 4
        NamesImageView.startAnimating()
    
        let delegate = UIApplication.shared.delegate as! AppDelegate
        delegate.instance = self
    
        
        
        super.viewDidLoad()
        PersonTableView.dataSource = self
        PersonTableView.delegate = self
        edditButton.tag = 0
        PersonTableView.allowsSelectionDuringEditing = true
        
        PersonTableView.backgroundColor = UIColor.clear
        
    }
    
    
    //----------------------------------load--------------------------------------
    //-----------------------------------------------------------------------------------------
    
    
    var filePath: String{
        let manager = FileManager.default
        let url = manager.urls(for: .documentDirectory, in: .userDomainMask).first! as URL
        return url.appendingPathComponent("savedData").path
        
    }
    
    func load()
    {
        if let array = NSKeyedUnarchiver.unarchiveObject(withFile: filePath) as? [Person]
        {
            personArray = array
        }
       
    }
    
    
    //----------------------------------save--------------------------------------
    //-----------------------------------------------------------------------------------------
    
    
    func save()
    {
        NSKeyedArchiver.archiveRootObject(personArray, toFile: filePath)
    }
    
    
    
//----------------------------------cellForRowAt--------------------------------------
//-----------------------------------------------------------------------------------------
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell
    {
        
        let myCell = PersonTableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath)
        
        myCell.textLabel?.text = personArray[indexPath.row].personName
        myCell.detailTextLabel?.text = ""
        myCell.backgroundColor = UIColor.clear
        
        
        
        return myCell
    }
//-----------------------------numberOfRowsInSection-----------------------------------
//-----------------------------------------------------------------------------------------
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int
    {
        
        return personArray.count
        
    }
//----------------------addTapped----------------------------------------------------
//-----------------------------------------------------------------------------------------
    
    @IBAction func addTapped(_ sender: Any)
    {
        
        let myAlert = UIAlertController(title: "Add Person", message: nil, preferredStyle: .alert)
        myAlert.addTextField { (alertTextfeild) -> Void in
            alertTextfeild.placeholder = "Name" // add place holder text
        }
        
        let cancelAction = UIAlertAction(title: "Cancel", style: UIAlertActionStyle.cancel, handler: nil)
        myAlert.addAction(cancelAction)
        
        let addAction = UIAlertAction(title: "Add", style: .default) { (addAction) -> Void in
            let name = myAlert.textFields![0] as UITextField
            
            self.personArray.append(Person(name: name.text!))
            self.PersonTableView.reloadData()
        }
        myAlert.addAction(addAction)
        
        
        self.present(myAlert, animated: true, completion: nil)
        
        
    }
//----------------------------edditTapped---------------------------------------------
//-----------------------------------------------------------------------------------------

    @IBAction func edditTapped(_ sender: Any)
    {
        if (edditButton.tag == 0)
        {
            
            PersonTableView.isEditing = true
            edditButton.tag = 1
        }
        else
        {
            PersonTableView.isEditing = false
            edditButton.tag = 0
        }
    }
//--------------------------commit editingStyle--------------------------------------
//-----------------------------------------------------------------------------------------
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath)
    {
        if (editingStyle == .delete)
        {
            
            personArray.remove(at: indexPath.row)
            PersonTableView.reloadData() // reload table view
        }
        
    }
//-----------------------------canMoveRowAt------------------------------------------------
//-----------------------------------------------------------------------------------------

    func tableView(_ tableView: UITableView, canMoveRowAt indexPath: IndexPath) -> Bool
    {
        return true
    }
//-------------------------moveRowAt------------------------------------------------
//-----------------------------------------------------------------------------------------
    func tableView(_ tableView: UITableView, moveRowAt sourceIndexPath: IndexPath, to destinationIndexPath: IndexPath)
    {
        let personN = personArray[sourceIndexPath.row]
        personArray.remove(at: sourceIndexPath.row)
        personArray.insert(personN, at: destinationIndexPath.row)

    }
    
    
    
//---------------------------didSelectRowAt------------------------------------------------
//-----------------------------------------------------------------------------------------

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath)
    {
       
        
        
        
        if (PersonTableView.isEditing == true)
        {
            let myAlert = UIAlertController(title: "Edit Name", message: nil, preferredStyle: .alert)
            myAlert.addTextField { (alertTextfeild) -> Void in
                alertTextfeild.placeholder = self.personArray[indexPath.row].personName // add place holder text
            }
            
            let cancelAction = UIAlertAction(title: "Cancel", style: UIAlertActionStyle.cancel, handler: nil)
            myAlert.addAction(cancelAction)
            
            let addAction = UIAlertAction(title: "Add", style: .default) { (addAction) -> Void in
                let name = myAlert.textFields![0] as UITextField
                
                self.personArray[indexPath.row].personName = name.text!
                self.PersonTableView.reloadData()
            }
            myAlert.addAction(addAction)
            
            
            self.present(myAlert, animated: true, completion: nil)
            
        }
       
    }
  //----------------------------shouldPerformSegue--------------------------------------
  //-----------------------------------------------------------------------------------------

    
    override func shouldPerformSegue(withIdentifier identifier: String, sender: Any?) -> Bool
    {
        return !(PersonTableView.isEditing)
    
    }

    override func prepare(for segue: UIStoryboardSegue, sender: Any?)
    {
        
        let detailview = segue.destination as! ListViewController
        let selectedrow = PersonTableView.indexPathForSelectedRow?.row
        
        detailview.curperson = personArray[selectedrow!]

        
        
    }
    
    
    
    
}
