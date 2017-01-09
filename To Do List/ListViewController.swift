//
//  ListViewController.swift
//  To Do List
//
//  Created by Phammel on 11/28/16.
//  Copyright © 2016 Phammel. All rights reserved.
//

import UIKit

class ListViewController: UIViewController,   UITableViewDelegate, UITableViewDataSource, UIImagePickerControllerDelegate, UINavigationControllerDelegate
{
    
    @IBOutlet weak var ItemTableView: UITableView!
    
    
    @IBOutlet weak var editButtob: UIBarButtonItem!
    
    @IBOutlet weak var imageView: UIImageView!
    
    var curperson: Person!
    
     var savedEntrees = ("","","")
    
    let imagePicker = UIImagePickerController()
    var selectedImage = "lilguy"
    
    let delegate = UIApplication.shared.delegate as! AppDelegate
  
    
    var adding = true
    
    
    override func viewDidLoad()
    {
        
        imageView.animationImages = [
            UIImage(named: "1")!,
            UIImage(named: "2")!,
            UIImage(named: "3")!,
            UIImage(named: "2")! ]
        
        imageView.animationDuration = 4
        imageView.startAnimating()
        
        
        imagePicker.allowsEditing = true
        imagePicker.delegate = self
        
        
        
        
        super.viewDidLoad()
        
        ItemTableView.dataSource = self
        ItemTableView.delegate = self
        editButtob.tag = 0
        ItemTableView.allowsSelectionDuringEditing = true
        
        ItemTableView.backgroundColor = UIColor.clear

        
        
    }
//-------------------------cellForRowAt------------------------------------------------------
//-----------------------------------------------------------------------------------------
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell
    {
        let myCell = ItemTableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath)
        
        myCell.textLabel?.text = " \(curperson.itemList[indexPath.row].priority) \(curperson.itemList[indexPath.row].itemName) - $\(curperson.itemList[indexPath.row].price)"
        myCell.detailTextLabel?.text = "\(curperson.itemList[indexPath.row].url)"
        myCell.backgroundColor = UIColor.clear
        
        if(curperson.itemList[indexPath.row].done)
        {
            myCell.accessoryType = .none
            
        }
        else
        {
            myCell.accessoryType = .checkmark
        }

      
        let path = getDocumentsDirectory().appendingPathComponent(curperson.itemList[indexPath.row].image)
        
       myCell.imageView?.image = UIImage(contentsOfFile: path.path)
        // bad -> myCell.imageView?.image = UIImage(named: curperson.itemList[indexPath.row].image)
        
        
        //--- use this to make the frame for the image larger so image can be scaled up
       
        //CGSize(width: 20, height: 20)
        let itemSize = CGSize(width: 100,height: 100)
        UIGraphicsBeginImageContextWithOptions(itemSize, false, UIScreen.main.scale)
        //CGRect(x: 0, y: 0, width: 20, height: 20)
        let imageRect = CGRect(x: 0.0, y: 0.0, width: itemSize.width,height: itemSize.height)
        myCell.imageView?.image!.draw(in: imageRect)
        myCell.imageView?.image! = UIGraphicsGetImageFromCurrentImageContext()!
        UIGraphicsEndImageContext()
        //---
        
        //make image scale to fit the imageview
        myCell.imageView?.contentMode = .scaleAspectFit

        
        delegate.save()
        return myCell

    }
    
//----------------------------numberOfRowsInSection--------------------------------
//-----------------------------------------------------------------------------------------
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int
    {
        print("name below")
        print(curperson.personName)
        return curperson.itemList.count
        delegate.save()
    }

//------------------------editTapped--------------------------------------------
//-----------------------------------------------------------------------------------------
    @IBAction func editTapped(_ sender: Any)
    {
        if (editButtob.tag == 0)
        {
            
            ItemTableView.isEditing = true
            editButtob.tag = 1
        }
        else
        {
            ItemTableView.isEditing = false
            editButtob.tag = 0
        }
        delegate.save()
        
    }
//---------------------addTapped------------------------------------------------------
//-----------------------------------------------------------------------------------------
    @IBAction func addTapped(_ sender: Any)
    {
        
        adding = true
        var ppriority = ""
        
        let myAlert = UIAlertController(title: "Add Item", message: nil, preferredStyle: .alert)
        myAlert.addTextField { (alertTextfeild) -> Void in
            alertTextfeild.placeholder = "Item"
            alertTextfeild.text = self.savedEntrees.0
        }
        myAlert.addTextField { (alertTextfeild) -> Void in
            alertTextfeild.placeholder = "Price"
            alertTextfeild.text = self.savedEntrees.1
        }
        myAlert.addTextField { (alertTextfeild) -> Void in
            alertTextfeild.placeholder = "Notes"
            alertTextfeild.text = self.savedEntrees.2
        }
        
   
        
        
        
        //----
        myAlert.addAction(UIAlertAction(title: "choose photo", style: .default ){ [unowned self, myAlert] _ in
            
            self.savedEntrees.0 = (myAlert.textFields?[0].text)!
             self.savedEntrees.1 = (myAlert.textFields?[1].text)!
              self.savedEntrees.2 = (myAlert.textFields?[2].text)!
            self.prePhotoPick(camera: false)
            
            
            
            
        })
        
        if (UIImagePickerController.isSourceTypeAvailable(.camera))
        {
            myAlert.addAction(UIAlertAction(title: "take photo", style: .default){ [unowned self, myAlert] _ in
                
                self.savedEntrees.0 = (myAlert.textFields?[0].text)!
                 self.savedEntrees.1 = (myAlert.textFields?[1].text)!
                  self.savedEntrees.2 = (myAlert.textFields?[2].text)!

                 self.prePhotoPick(camera: true)
                
                
                
            })
        }

        //---
        
        
        
        let onePriority = UIAlertAction(title: "!", style: .default) { (onePriority) -> Void in
            ppriority = "!"
            let item = myAlert.textFields![0] as UITextField
            let price = myAlert.textFields![1] as UITextField
            let Url = myAlert.textFields![2] as UITextField
            
            let path = self.selectedImage
            
            if (price.text == "")
            {
                price.text = "0"
            }
            
            self.curperson.itemList.append(Item(url: Url.text!, image: self.selectedImage, name: item.text!, price: Double(price.text!)!,priority: ppriority ))
            self.delegate.save()
            self.ItemTableView.reloadData()
            
            
            
            
        }
        myAlert.addAction(onePriority)
        let twoPriority = UIAlertAction(title: "!!", style: .default) { (twoPriority) -> Void in
            ppriority = "!!"
            let item = myAlert.textFields![0] as UITextField
            let price = myAlert.textFields![1] as UITextField
            let Url = myAlert.textFields![2] as UITextField
            
            let path = self.selectedImage
            
            if (price.text == "")
            {
                price.text = "0"
            }
            
            self.curperson.itemList.append(Item(url: Url.text!, image: self.selectedImage, name: item.text!, price: Double(price.text!)!,priority: ppriority ))
            self.delegate.save()
            self.ItemTableView.reloadData()
            
            
            
            
        }
        myAlert.addAction(twoPriority)
        let threePriority = UIAlertAction(title: "!!!", style: .default) { (threePriority) -> Void in
            ppriority = "!!!"
            let item = myAlert.textFields![0] as UITextField
            let price = myAlert.textFields![1] as UITextField
            let Url = myAlert.textFields![2] as UITextField
            
            let path = self.selectedImage
            
            if (price.text == "")
            {
                price.text = "0"
            }
            
            self.curperson.itemList.append(Item(url: Url.text!, image: self.selectedImage, name: item.text!, price: Double(price.text!)!,priority: ppriority ))
            self.delegate.save()
            self.ItemTableView.reloadData()
            
            
            
            
            
        }
        myAlert.addAction(threePriority)
        
        
        
        
        
        
        
        
        
        
        
        
        let cancelAction = UIAlertAction(title: "Cancel", style: UIAlertActionStyle.cancel, handler: nil)
        myAlert.addAction(cancelAction)
        
        
        
       
        delegate.save()
        
        self.present(myAlert, animated: true, completion: nil)

         delegate.save()
    }
    
    
    
    
    
    func prePhotoPick(camera: Bool)
    {
        if camera
        {
            imagePicker.sourceType = .camera
        }
        else
        {
            imagePicker.sourceType = .photoLibrary
        }
        present(imagePicker, animated: true, completion: nil)
    }

    
    func getDocumentsDirectory() -> URL
    {
        let paths = FileManager.default.urls(for: . documentDirectory, in: .userDomainMask)
        let documentsDirectory = paths[0]
        return documentsDirectory
    }
    

    
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : Any])
    {
        guard let image = info[UIImagePickerControllerEditedImage] as? UIImage else { return}
        
        let imageName = UUID().uuidString
        let imagePath = getDocumentsDirectory().appendingPathComponent(imageName)
        
        if let jpegData = UIImageJPEGRepresentation(image, 80)
        {
            try? jpegData.write(to: imagePath)
        }
        
        
        imagePicker.dismiss(animated: true)
        {
            () -> Void in
            self.selectedImage = imageName
            
            
                self.addTapped(self)
           
            
        }
        
    }

    
    
    
    
    
    
    
    
    
//-----------------------------------commiteditingStyle-----------------------------------------------------
//-----------------------------------------------------------------------------------------
    
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath)
    {
        if (editingStyle == .delete)
        {
            
            curperson.itemList.remove(at: indexPath.row)
            ItemTableView.reloadData() // reload table view
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
        let personN = curperson.itemList[sourceIndexPath.row]
        curperson.itemList.remove(at: sourceIndexPath.row)
        curperson.itemList.insert(personN, at: destinationIndexPath.row)
        delegate.save()

        
    }
    
    
    //----------------------------didSelectRowAt--------------------------------------
    //-----------------------------------------------------------------------------------------
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath)
    {
        if (ItemTableView.isEditing == false)
        {
            
            curperson.itemList[indexPath.row].done = !(curperson.itemList[indexPath.row].done)
            
                        ItemTableView.reloadData()
            
        }
        delegate.save()

        
    }

    
    
    
    

   
    
    
    
    
    
    
    
    
}
